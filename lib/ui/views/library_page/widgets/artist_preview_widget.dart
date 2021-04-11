import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../logic/models/artist.dart';
import '../../../navigation/route_generators/library_route_generator.dart';

class ArtistPreviewWidget extends StatelessWidget {
  final Artist artist;

  const ArtistPreviewWidget(this.artist, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context).pushNamed(
        LibraryRouteGenerator.ARTIST,
        arguments: artist,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: CachedNetworkImageProvider(
                artist.imgUrl,
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Text(
                artist.name,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1.2,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
