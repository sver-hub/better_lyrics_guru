import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:spotify/spotify.dart' as Spotify;

import '../../logic/models/album.dart';
import '../../logic/models/artist.dart';
import '../../logic/models/track.dart';
import 'spotify_service.dart';

class SpotifyServiceImplementation extends SpotifyService {
  Spotify.Spotify spotify = Spotify.Spotify(
      clientId: '6835c2dadf634991b30d7052e3b43a4a',
      clientSecret: '36ed6b35fb1b4d419929ba708fa18b0a');

  bool _auth = false;
  // ignore: close_sinks
  StreamController<bool> _controller;

  @override
  Future<String> authenticate() async {
    final grant = await spotify.authorize(
        redirectUri: 'lyrics-guru://callback', scopes: ['user-library-read']);
    if (grant == null || grant.refreshToken == null) return null;
    _controller.sink.add(true);
    _auth = true;
    return grant.refreshToken;
  }

  @override
  Stream<Track> getStreamOfSavedTracks() async* {
    final stream = spotify.api.me.tracks.all();
    await for (final spTrack in stream) {
      final track = _convert(spTrack);
      debugPrint(track.name);
      yield track;
    }
  }

  Track _convert(Spotify.Track spotifyTrack) {
    final artist = _convertArtist(spotifyTrack.artists[0]);
    final album = _convertAlbum(spotifyTrack.album, artist);
    final trackId = spotifyTrack.id;
    final trackTitle = spotifyTrack.name;
    final trackNumber =
        spotifyTrack.trackNumber + 20 * (spotifyTrack.discNumber - 1);
    return Track(
      id: trackId,
      name: trackTitle,
      album: album,
      lyrics: null,
      trackNumber: trackNumber,
    );
  }

  Album _convertAlbum(Spotify.Album spotifyAlbum, Artist artist) {
    final albumId = spotifyAlbum.id;
    final albumTitle = spotifyAlbum.name;
    final albumCoverUrl = spotifyAlbum.images[0].url;
    final releaseDate = spotifyAlbum.releaseDate;
    return Album(
      id: albumId,
      name: albumTitle,
      imgUrl: albumCoverUrl,
      artist: artist,
      releaseDate: releaseDate,
    );
  }

  Artist _convertArtist(Spotify.Artist spotifyArtist) {
    final artistId = spotifyArtist.id;
    final artistName = spotifyArtist.name;
    final artistThumbnailUrl = spotifyArtist.images[0].url;
    return Artist(
      id: artistId,
      name: artistName,
      imgUrl: artistThumbnailUrl,
    );
  }

  @override
  void authenticateWithToken(String token) async {
    final grant = await spotify.refreshToken(refreshToken: token);
    if (grant == null) throw Exception('authenticateWithToken');
    _controller.sink.add(true);
    _auth = true;
  }

  @override
  Future<String> getUserName() async {
    return (await spotify.api.me()).displayName;
  }

  @override
  Future<String> getUserImageUrl() async {
    return (await spotify.api.me()).images[0].url;
  }

  @override
  Stream<bool> get authenticated {
    _controller = StreamController<bool>();
    _controller.sink.add(_auth);
    return _controller.stream;
  }

  @override
  void signOut() {
    _auth = false;
  }
}
