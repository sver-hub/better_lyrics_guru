import 'package:hooks_riverpod/all.dart';

import '../spotify/spotify_service.dart';
import 'library_service_implementation.dart';

final libraryService = Provider<LibraryService>((ref) {
  final spotify = ref.read(spotifyService);
  return LibraryServiceImplementation(spotify);
});

abstract class LibraryService {
  Future<void> loadFavouriteTracks();
}
