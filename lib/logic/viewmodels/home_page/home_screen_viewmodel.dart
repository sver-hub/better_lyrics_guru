import 'package:flutter/material.dart';
import 'package:hooks_riverpod/all.dart';

import '../../app_state/app_state.dart';

final homeScreenViewModel = ChangeNotifierProvider<HomeScreenViewModel>((ref) {
  final curUser = ref.read(currentUser);
  return HomeScreenViewModel(curUser);
});

class HomeScreenViewModel extends ChangeNotifier {
  HomeScreenViewModel(this.user);
  final CurrentUser user;

  String get userName => user.name;
}
