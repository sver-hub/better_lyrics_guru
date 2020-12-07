import 'package:flutter/material.dart';
import 'package:lyrics_guru/database/moor_database.dart';

class HomeScreenViewModel extends ChangeNotifier {
  UserDao userDataProvider;

  HomeScreenViewModel(BuildContext context);
}
