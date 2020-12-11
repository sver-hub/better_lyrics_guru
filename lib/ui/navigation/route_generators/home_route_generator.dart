import 'package:flutter/material.dart';
import 'package:lyrics_guru/ui/views/home_page/profile_screen.dart';

import '../../views/home_page/home_screen.dart';
import 'page_route_transition.dart';

class HomeRouteGenerator {
  static const PROFILE = '/profile';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return PageRouteTransition.fadeTransition(to: HomePage());
      case PROFILE:
        return PageRouteTransition.fadeTransition(to: ProfileScreen());
      default:
        throw Exception('Wrong path in home navigator');
    }
  }
}
