import '../../database/db.dart';
import '../../database/moor_database.dart';
import '../../logic/models/album.dart';
import '../../logic/models/artist.dart';
import '../lyrics/lyrics_service.dart';
import '../spotify/spotify_service.dart';
import 'library_service.dart';

class LibraryServiceImplementation extends LibraryService {
  LibraryServiceImplementation(this._spotify, this._lyrics);

  final SpotifyService _spotify;
  final LyricsService _lyrics;
  final _artistDao = db<ArtistDao>();
  final _albumDao = db<AlbumDao>();
  final _trackDao = db<TrackDao>();

  @override
  Future<void> loadFavouriteTracks() async {
    final artists = List<Artist>();
    final albums = List<Album>();

    final savedTrackStream = _spotify.getStreamOfSavedTracks();

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
      await _lyrics.fetchLyricsOfTrack(track);
      yield --remaining;
    }
  }
}
