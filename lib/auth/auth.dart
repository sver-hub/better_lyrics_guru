import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/all.dart';

import '../database/db.dart';
import '../database/moor_database.dart';
import '../logic/models/user_data.dart';
import '../services/spotify/spotify_service.dart';
import '../ui/widgets/screen_fade_transition.dart';
import 'services/auth_service.dart';
import 'sign_in/sign_in_screen.dart';
import 'sign_in/spotify_auth_screen.dart';
import 'widgets/loading_screen.dart';

final _firebaseUserStream = StreamProvider(
  (ref) => ref.watch(authService).authStateChanges,
);

final _spotifyAuthStream = StreamProvider(
  (ref) => ref.watch(spotifyService).authenticated,
);

final _userFromDb = FutureProvider.family<UserData, User>((ref, user) async {
  final userDao = db<UserDao>();
  var userDB = await userDao.getUser(user.uid);

  if (userDB == null) {
    userDB = UserData(
      uid: user.uid,
      email: user.email,
      name: user.displayName,
      imgUrl: user.photoURL,
    );
    userDao.saveUserData(userDB);
  }

  return userDB;
});

class Auth extends HookWidget {
  final Widget child;

  const Auth({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _firebaseBuilder(
      childBuilder: (user) => _checkUserBuilder(
        user,
        childBuilder: (userData) => _spotifyBuilder(
          userData,
          child: child,
        ),
      ),
    );
  }

  Widget _firebaseBuilder({Widget Function(User) childBuilder}) {
    final authState = useProvider(_firebaseUserStream);
    return authState.when(
      data: (user) => user != null ? childBuilder(user) : SignInScreenBuilder(),
      loading: () => LoadingScreen(),
      error: (err, stack) => Container(),
    );
  }

  Widget _checkUserBuilder(User user,
      {Widget Function(UserData) childBuilder}) {
    final userDb = useProvider(_userFromDb(user));
    return userDb.when(
      data: (user) => childBuilder(user),
      loading: () => LoadingScreen(),
      error: (err, stack) => Container(),
    );
  }

  Widget _spotifyBuilder(UserData userData, {Widget child}) {
    final authState = useProvider(_spotifyAuthStream);
    return authState.when(
      data: (isAuth) => isAuth
          ? child
          : ScreenFadeTransition(
              destinationPage: SpotifyAuthScreen(userData: userData),
            ),
      loading: () => LoadingScreen(),
      error: (err, stack) => Container(),
    );
  }
}
