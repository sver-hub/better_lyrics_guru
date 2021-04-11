import '../../logic/models/word.dart';

import '../../logic/models/track.dart';
import '../words/words_service.dart';

import '../../database/db.dart';
import '../../database/moor_database.dart';
import '../../logic/models/album.dart';
import '../../logic/models/artist.dart';
import '../lyrics/lyrics_service.dart';
import '../spotify/spotify_service.dart';
import 'library_service.dart';

class LibraryServiceImplementation extends LibraryService {
  LibraryServiceImplementation(
      this._spotifyService, this._lyricsService, this._wordsService);

  final SpotifyService _spotifyService;
  final LyricsService _lyricsService;
  final WordsService _wordsService;
  final _artistDao = db<ArtistDao>();
  final _albumDao = db<AlbumDao>();
  final _trackDao = db<TrackDao>();

  @override
  Future<void> loadFavouriteTracks() async {
    final artists = <Artist>[];
    final albums = <Album>[];

    final savedTrackStream = _spotifyService.getStreamOfSavedTracks();

    await for (final track in savedTrackStream) {
      final album = track.album;
      final artist = album.artist;

      if (!artists.contains(artist)) {
        artists.add(artist);
        _artistDao.saveArtist(artist);
      }

      if (!albums.contains(album)) {
        albums.add(album);
        _albumDao.saveAlbum(album);
      }

      _trackDao.saveTrack(track);
    }
  }

  @override
  Stream<int> loadLyrics() async* {
    final artists = await _artistDao.getAllArtists();
    final albums = [
      for (final artist in artists)
        ...(await _albumDao.getAlbumsOfArtist(artist))
    ];
    final tracks = [
      for (final album in albums) ...(await _trackDao.getTracksOfAlbum(album))
    ];
    int remaining = tracks.length;
    yield remaining;
    for (final track in tracks) {
      await _lyricsService.fetchLyricsOfTrack(track);
      yield --remaining;
    }
  }

  @override
  Future<List<Word>> getWordsOfTrack(Track track) async {
    return await _wordsService.analyseLyrics(track);
  }
}
