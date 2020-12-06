import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/all.dart';

import '../../database/moor_database.dart';
import '../../database/db.dart';
import '../../services/spotify/spotify_service.dart';
import '../../ui/widgets/platform_exception_alert_dialog.dart';
import '../../logic/models/user_data.dart';
import '../../logic/app_state.dart';
import '../services/auth_service.dart';
import '../constants/strings.dart';
import '../widgets/logo.dart';
import '../widgets/loading_screen.dart';
import '../widgets/social_sign_in_button.dart';

class SpotifyAuthScreen extends HookWidget {
  static const Key spotifyButtonKey = Key('spotify');
  final UserData userData;

  const SpotifyAuthScreen({Key key, @required this.userData}) : super(key: key);

  Future<void> _signOut(BuildContext context, AuthService auth) async {
    try {
      await auth.signOut();
    } on PlatformException catch (e) {
      await PlatformExceptionAlertDialog(
        title: Strings.logoutFailed,
        exception: e,
      ).show(context);
    }
  }

  Future<void> _signInSpotify(
    SpotifyService spotify,
    ValueNotifier<bool> isLoading,
    StateController<AppState> appState,
  ) async {
    isLoading.value = true;
    final refreshToken = await spotify.authenticate();
    final user = userData.copyWith(refreshToken: refreshToken);
    final userProvider = db<UserInfoDao>();
    userProvider.updateUserInfo(user.asUserInfo);
    appState.state.currentUser = user;
    appState.state.needsDownload = true;
    isLoading.value = false;
  }

  @override
  Widget build(BuildContext context) {
    final _isLoading = useState(false);
    final _spotify = useProvider(spotifyService);
    final _auth = useProvider(authService);
    final _appState = useProvider(appState);

    if (userData.refreshToken != null) {
      _spotify.authenticateWithToken(userData.refreshToken);
      _appState.state.currentUser = userData;
      return LoadingScreen();
    }

    return Scaffold(
      backgroundColor: Color(0xFF8185E2),
      appBar: _buildAppBar(context, _auth),
      body: Center(
        child: Column(
          children: [
            Logo(),
            _buildTitle(),
            const SizedBox(height: 80.0),
            ..._buildText(),
            const SizedBox(height: 150.0),
            SocialSignInButton(
              key: SpotifyAuthScreen.spotifyButtonKey,
              assetName: 'assets/sp-logo.png',
              text: 'Sign In on Spotify',
              onTap: () => _isLoading.value
                  ? null
                  : _signInSpotify(_spotify, _isLoading, _appState),
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context, AuthService auth) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios),
        onPressed: () => _signOut(context, auth),
      ),
    );
  }

  Widget _buildTitle() {
    return const Text(
      "Lyrics Guru",
      style: TextStyle(
          fontWeight: FontWeight.bold, fontSize: 35.0, color: Colors.white),
    );
  }

  List<Widget> _buildText() {
    const color = Colors.white;
    return [
      const Text(
        "The Only Step Left",
        style: TextStyle(fontSize: 20.0, color: color),
      ),
      const Text(
        "Is To Sign In Your Spotify Account",
        style: TextStyle(fontSize: 20.0, color: color),
      ),
      const Text(
        "So That I Know Your Favourite Songs",
        style: TextStyle(fontSize: 20.0, color: color),
      ),
    ];
  }
}
