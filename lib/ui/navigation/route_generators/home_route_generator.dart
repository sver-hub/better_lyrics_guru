import 'package:flutter/material.dart';

import '../../views/home/home_page.dart';
import 'page_route_transition.dart';

class HomeRouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return PageRouteTransition.fadeTransition(to: HomePage());

      default:
        throw Exception('Wrong path in home navigator');
    }
  }
}
