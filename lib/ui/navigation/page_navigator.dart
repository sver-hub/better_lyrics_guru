import 'package:flutter/material.dart';

class PageNavigator extends StatelessWidget {
  final GlobalKey<NavigatorState> navKey;
  final Route<dynamic> Function(RouteSettings) onGenerateRoute;

  const PageNavigator(
      {Key key, @required this.navKey, @required this.onGenerateRoute})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navKey,
      initialRoute: '/',
      onGenerateRoute: onGenerateRoute,
    );
  }
}
