import 'package:hooks_riverpod/all.dart';

import '../../logic/models/track.dart';
import 'musixmatch_lyrics.dart';

final lyricsService = Provider<LyricsService>((ref) => MusixmatchLyrics());

abstract class LyricsService {
  Future fetchLyricsOfTrack(Track track);
}
