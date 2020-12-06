import 'package:hooks_riverpod/all.dart';
import '../../logic/models/track.dart';
import 'spotify_service_implementation.dart';

final spotifyService = Provider((ref) => SpotifyServiceImplementation());

abstract class SpotifyService {
  Stream<bool> get authenticated;

  Future<String> authenticate();

  void authenticateWithToken(String token);

  Stream<Track> getStreamOfSavedTracks();

  Future<String> getUserName();

  Future<String> getUserImageUrl();

  void signOut();
}
