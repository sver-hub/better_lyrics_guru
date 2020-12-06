import '../../database/moor_database.dart';
import '../../database/db.dart';
import '../../logic/models/album.dart';
import '../../logic/models/artist.dart';
import '../spotify/spotify_service.dart';
import 'library_service.dart';

class LibraryServiceImplementation extends LibraryService {
  LibraryServiceImplementation(this.spotifyService);

  final SpotifyService spotifyService;
  final _artistDao = db<ArtistInfoDao>();
  final _albumDao = db<AlbumInfoDao>();
  final _trackDao = db<TrackInfoDao>();

  @override
  Future<void> loadFavouriteTracks() async {
    final artists = List<Artist>();
    final albums = List<Album>();

    final savedTrackStream = spotifyService.getStreamOfSavedTracks();

    await for (final track in savedTrackStream) {
      final album = track.album;
      final artist = album.artist;

      if (!artists.contains(artist)) {
        artists.add(artist);
        _artistDao.saveArtistInfo(artist.asArtistInfo);
      }

      if (!albums.contains(album)) {
        albums.add(album);
        _albumDao.saveAlbumInfo(album.asAlbumInfo);
      }

      _trackDao.saveTrackInfo(track.asTrackInfo);
    }
  }
}
