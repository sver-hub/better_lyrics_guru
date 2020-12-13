import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/all.dart';

import '../../../auth/constants/strings.dart';
import '../../../auth/services/auth_service.dart';
import '../../../logic/app_state/app_state.dart';
import '../../navigation/route_generators/home_route_generator.dart';
import '../../widgets/platform_alert_dialog.dart';
import '../../widgets/platform_exception_alert_dialog.dart';

class HomePage extends HookWidget {
  Future<void> _signOut(BuildContext context) async {
    try {
      await context.read(authService).signOut();
    } on PlatformException catch (e) {
      await PlatformExceptionAlertDialog(
        title: Strings.logoutFailed,
        exception: e,
      ).show(context);
    }
  }

  Future<void> _confirmSignOut(BuildContext context) async {
    final didRequestSignOut = await PlatformAlertDialog(
      title: Strings.logout,
      content: Strings.logoutAreYouSure,
      cancelActionText: Strings.cancel,
      defaultActionText: Strings.logout,
    ).show(context);
    if (didRequestSignOut == true) {
      _signOut(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final _user = useProvider(currentUser);
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: FractionalOffset(-0.5, -0.5),
            end: FractionalOffset.bottomRight,
            colors: [Colors.orange[900], Colors.black],
          ),
        ),
        padding: EdgeInsets.only(top: 30),
        child: CustomScrollView(
          physics: BouncingScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(
              child: _buildAppBar(context),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 150,
                child: Center(
                  child: Text(
                    'Welcome Back, ' + _user.name,
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(height: 400),
            ),
            SliverToBoxAdapter(
              child: ElevatedButton(
                child: Text('sign out'),
                onPressed: () => _confirmSignOut(context),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return AppBar(
      actions: [
        IconButton(
          icon: Icon(Icons.person_outline),
          onPressed: () => Navigator.of(context).pushNamed(
            HomeRouteGenerator.PROFILE,
          ),
        )
      ],
      backgroundColor: Colors.transparent,
      elevation: 0,
    );
  }
}
