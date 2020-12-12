import 'package:hooks_riverpod/all.dart';

import '../models/user_data.dart';

part 'current_user.dart';
part 'library_state.dart';

final currentUser = StateNotifierProvider<CurrentUser>((ref) => CurrentUser());
final libraryState =
    StateNotifierProvider<LibraryState>((ref) => LibraryState());
