import 'package:hooks_riverpod/all.dart';

import '../lyrics/lyrics_service.dart';
import '../spotify/spotify_service.dart';
import 'library_service_implementation.dart';

final libraryService = Provider<LibraryService>((ref) {
  final spotify = ref.read(spotifyService);
  final lyrics = ref.read(lyricsService);
  return LibraryServiceImplementation(spotify, lyrics);
});

abstract class LibraryService {
  Future loadFavouriteTracks();

  Stream<int> loadLyrics();
}
