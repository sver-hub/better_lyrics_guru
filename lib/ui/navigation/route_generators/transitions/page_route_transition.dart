import 'package:flutter/material.dart';

abstract class PageRouteTransition {
  static Route fadeTransition({@required Widget to}) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => to,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final tween =
            Tween(begin: 0.0, end: 1.0).chain(CurveTween(curve: Curves.ease));
        return FadeTransition(
          opacity: animation.drive(tween),
          child: child,
        );
      },
    );
  }
}
