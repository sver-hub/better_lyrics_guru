part of 'app_state.dart';

class CurrentUser extends StateNotifier<UserData> {
  CurrentUser() : super(null);

  String get name => state.name;
  set name(String val) => state = state.copyWith(name: val);

  UserData get user => state;
  set user(UserData val) => state = val;

  String get imgUrl => state.imgUrl;
}
