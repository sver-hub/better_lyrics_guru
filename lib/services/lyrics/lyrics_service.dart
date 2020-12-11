import 'package:hooks_riverpod/all.dart';

import '../../logic/models/album.dart';
import '../../logic/models/artist.dart';
import '../../logic/models/track.dart';
import 'musixmatch_lyrics.dart';

final lyricsService = Provider<LyricsService>((ref) => MusixmatchLyrics());

abstract class LyricsService {
  Future<String> getLyricsOfTrack(Track track);

  Future fetchAndSaveLyricsOfAlbum(Album album);

  Future fetchAndSaveLyricsOfArtist(Artist artist);
}
