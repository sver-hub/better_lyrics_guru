import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../ui/widgets/platform_exception_alert_dialog.dart';
import '../constants/strings.dart';
//import 'package:lyrics_guru/auth/sign_in/email_password_sign_in_page.dart';
import '../sign_in/sign_in_manager.dart';
import '../widgets/delayed_animation.dart';
import '../widgets/logo.dart';
import '../widgets/social_sign_in_button.dart';

class SignInScreenBuilder extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final isLoading = useState(false);
    final manager = useProvider(signInManager(isLoading));
    return SignInScreen._(
      isLoading: isLoading.value,
      manager: manager,
      title: 'Firebase Auth Demo',
    );
  }
}

class SignInScreen extends StatelessWidget {
  const SignInScreen._({Key key, this.isLoading, this.manager, this.title})
      : super(key: key);
  final SignInManager manager;
  final String title;
  final bool isLoading;
  final int delay = 500;

  static const Key googleButtonKey = Key('google');
  // static const Key emailPasswordButtonKey = Key('email-password');

  Future<void> _showSignInError(
      BuildContext context, PlatformException exception) async {
    await PlatformExceptionAlertDialog(
      title: Strings.signInFailed,
      exception: exception,
    ).show(context);
  }

  Future<void> _signInWithGoogle(BuildContext context) async {
    try {
      await manager.signInWithGoogle();
    } on PlatformException catch (e) {
      if (e.code != 'ERROR_ABORTED_BY_USER') {
        _showSignInError(context, e);
      }
    }
  }

  // Future<void> _signInWithEmailAndPassword(BuildContext context) async {
  //   final navigator = Navigator.of(context);
  //   await EmailPasswordSignInPage.show(
  //     context,
  //     onSignedIn: navigator.pop,
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF8185E2),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Logo(),
            _buildDelayedText("Hi There",
                fontSize: 35.0, weight: FontWeight.bold, delay: delay),
            _buildDelayedText("I'm Lyrics Guru",
                fontSize: 35.0, weight: FontWeight.bold, delay: 2 * delay),
            const SizedBox(height: 50.0),
            _buildDelayedText("And I Will Help You", delay: 3 * delay),
            _buildDelayedText("Understand Your Favourite Songs",
                delay: 4 * delay),
            const SizedBox(height: 150.0),
            _buildDelayedText("But First You Need To Sign In",
                weight: FontWeight.bold, delay: 5 * delay),
            const SizedBox(height: 50.0),
            DelayedAnimation(
              child: _buildButtons(context),
              delay: 6 * delay,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDelayedText(String text,
      {double fontSize = 20.0,
      FontWeight weight,
      Color color = Colors.white,
      @required int delay}) {
    return DelayedAnimation(
      child: Text(
        text,
        style: TextStyle(fontSize: fontSize, fontWeight: weight, color: color),
      ),
      delay: delay,
    );
  }

  Widget _buildButtons(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        SocialSignInButton(
          key: SignInScreen.googleButtonKey,
          assetName: 'assets/go-logo.png',
          text: Strings.signInWithGoogle,
          onTap: isLoading ? null : () => _signInWithGoogle(context),
          loading: isLoading,
          color: Colors.white,
        ),
        SizedBox(height: 8),
        // SignInButton(
        //   key: SignInPage.emailPasswordButtonKey,
        //   text: Strings.signInWithEmailPassword,
        //   onTap: isLoading ? null : () => _signInWithEmailAndPassword(context),
        //   textColor: Colors.white,
        //   color: Colors.teal[700],
        // ),
      ],
    );
  }
}
