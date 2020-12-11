import 'package:hooks_riverpod/all.dart';

import 'models/user_data.dart';

// final appState = ChangeNotifierProvider((ref) => AppState());

// class AppState extends ChangeNotifier {
//   UserData _currentUser;
//   UserData get currentUser => _currentUser;
//   set currentUser(UserData user) {
//     _currentUser = user;
//     notifyListeners();
//   }

//   bool _needsDownload = false;
//   bool get needsDownload => _needsDownload;
//   set needsDownload(bool val) {
//     _needsDownload = val;
//     notifyListeners();
//   }

//   bool _isLibraryReady = true;
//   bool get isLibraryReady => _isLibraryReady;
//   set isLibraryReady(bool val) {
//     _isLibraryReady = val;
//     notifyListeners();
//   }
// }

final currentUser = StateNotifierProvider<CurrentUser>((ref) => CurrentUser());
final libraryState =
    StateNotifierProvider<LibraryState>((ref) => LibraryState());

class CurrentUser extends StateNotifier<UserData> {
  CurrentUser() : super(null);

  String get name => state.name;
  set name(String val) => state = state.copyWith(name: val);

  UserData get user => state;
  set user(UserData val) => state = val;

  String get imgUrl => state.imgUrl;
}

class LibraryStateValue {
  LibraryStateValue(this.needsDownload, this.isReady);
  bool needsDownload;
  bool isReady;
}

class LibraryState extends StateNotifier<LibraryStateValue> {
  LibraryState() : super(LibraryStateValue(false, true));

  bool get needsDownload => state.needsDownload;
  bool get isReady => state.isReady;

  set needsDownload(bool val) => state = LibraryStateValue(val, isReady);
  set isReady(bool val) => state = LibraryStateValue(needsDownload, val);
}
