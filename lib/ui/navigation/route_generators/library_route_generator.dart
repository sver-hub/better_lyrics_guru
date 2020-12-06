import 'package:flutter/material.dart';

import '../../../logic/models/album.dart';
import '../../../logic/models/artist.dart';
import '../../../logic/models/track.dart';
import '../../views/library/album_screen.dart';
import '../../views/library/artist_screen.dart';
import '../../views/library/library_screen.dart';
import '../../views/library/track_screen.dart';
import 'page_route_transition.dart';

class LibraryRouteGenerator {
  static const ARTIST = '/artist';
  static const ALBUM = '/album';
  static const TRACK = '/track';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return PageRouteTransition.fadeTransition(to: LibraryScreen());

      case ARTIST:
        if (args is Artist)
          return PageRouteTransition.fadeTransition(
              to: ArtistScreen(artist: args));
        throw Exception('Wrong params to /albums');

      case ALBUM:
        if (args is Album)
          return PageRouteTransition.fadeTransition(
              to: AlbumScreen(album: args));
        throw Exception('Wrong params to /albums');

      case TRACK:
        if (args is Track)
          return PageRouteTransition.fadeTransition(
              to: TrackScreen(track: args));
        throw Exception('Wrong params to /albums');

      default:
        throw Exception('Wrong path in home navigator');
    }
  }
}
