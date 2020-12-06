import 'package:hooks_riverpod/all.dart';

import 'models/user_data.dart';

final appState = StateProvider((ref) => AppState());

class AppState {
  UserData currentUser;
  bool needsDownload = false;
  bool isLibraryReady = true;
}
