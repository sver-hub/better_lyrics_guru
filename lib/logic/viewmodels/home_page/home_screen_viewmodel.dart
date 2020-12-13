import 'package:flutter/material.dart';

import '../../../database/moor_database.dart';

class HomeScreenViewModel extends ChangeNotifier {
  UserDao userDataProvider;

  HomeScreenViewModel(BuildContext context);
}
