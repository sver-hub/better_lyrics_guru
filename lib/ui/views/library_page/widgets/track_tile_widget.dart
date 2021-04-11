import 'package:flutter/material.dart';

import '../../../../logic/models/track.dart';
import '../../../navigation/route_generators/library_route_generator.dart';

class TrackTileWidget extends StatelessWidget {
  final Track track;

  const TrackTileWidget({Key key, this.track}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => Navigator.of(context)
          .pushNamed(LibraryRouteGenerator.TRACK, arguments: track),
      title: Text(
        track.name,
        style: Theme.of(context).textTheme.headline3,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(
        track.album.artist.name + ' - ' + track.album.name,
        style: Theme.of(context).textTheme.subtitle1,
      ),
    );
  }
}
