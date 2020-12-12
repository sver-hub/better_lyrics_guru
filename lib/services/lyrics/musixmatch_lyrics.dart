import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../database/db.dart';
import '../../database/moor_database.dart';
import '../../logic/models/track.dart';
import 'lyrics_service.dart';

class MusixmatchLyrics extends LyricsService {
  final _trackDao = db<TrackDao>();
  //final _albumDao = db<AlbumDao>();

  Future<String> _fetchLyrics(String trackName, String artistName) async {
    final uri = Uri.https('api.musixmatch.com', '/ws/1.1/matcher.lyrics.get', {
      'format': 'json',
      'q_track': trackName,
      'q_artist': artistName,
      'apikey': 'c93249e90e0b1e63f6e4342b33294a3b'
    });

    final json = jsonDecode((await http.get(uri)).body);

    if (json['message'] == null ||
        json['message']['header'] == null ||
        json['message']['header']['status_code'] != 200 ||
        json['message']['body'] == null ||
        json['message']['body']['lyrics'] == null ||
        json['message']['body']['lyrics']['lyrics_body'] == null ||
        json['message']['body']['lyrics']['lyrics_body'] == '') return null;

    String lyrics = json['message']['body']['lyrics']['lyrics_body'];
    lyrics = lyrics.replaceRange(
        lyrics.indexOf('...\n\n*******'), lyrics.length, '');

    return lyrics;
  }

  // @override
  // Future fetchAndSaveLyricsOfAlbum(Album album) async {
  //   final tracks = await _trackDao.getTracksOfAlbum(album);
  //   for (final track in tracks) {
  //     if (track.lyrics == null) {
  //       final lyrics = await getLyricsOfTrack(track);
  //       await _trackDao.saveTrack(track.withLyrics(lyrics));
  //       print('saved ' + track.name);
  //     }
  //   }
  // }

  // @override
  // Future fetchAndSaveLyricsOfArtist(Artist artist) async {
  //   final albums = await _albumDao.getAlbumsOfArtist(artist);
  //   for (final album in albums) {
  //     await fetchAndSaveLyricsOfAlbum(album);
  //   }
  // }

  @override
  Future fetchLyricsOfTrack(Track track) async {
    if (track.lyrics != null) return;
    final lyrics = await _fetchLyrics(track.name, track.album.artist.name);
    print(track.name);
    await _trackDao.saveTrack(track.withLyrics(lyrics));
  }
}
