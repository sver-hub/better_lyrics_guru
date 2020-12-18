import 'package:hooks_riverpod/all.dart';

import '../../logic/models/track.dart';
import '../../logic/models/word.dart';
import '../lyrics/lyrics_service.dart';
import '../spotify/spotify_service.dart';
import '../words/words_service.dart';
import 'library_service_implementation.dart';

final libraryService = Provider<LibraryService>((ref) {
  final spotify = ref.read(spotifyService);
  final lyrics = ref.read(lyricsService);
  final words = ref.read(wordsService);
  return LibraryServiceImplementation(spotify, lyrics, words);
});

abstract class LibraryService {
  Future loadFavouriteTracks();

  Stream<int> loadLyrics();

  Future<List<Word>> getWordsOfTrack(Track track);
}
