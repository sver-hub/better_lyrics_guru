import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../logic/models/album.dart';
import '../../../navigation/route_generators/library_route_generator.dart';

class AlbumPreviewWidget extends StatelessWidget {
  final Album album;

  const AlbumPreviewWidget({Key key, this.album}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context)
          .pushNamed(LibraryRouteGenerator.ALBUM, arguments: album),
      child: SizedBox.expand(
        child: Container(
          child: Column(
            children: [
              Expanded(
                child: ClipRRect(
                  child: Image(
                    fit: BoxFit.cover,
                    image: CachedNetworkImageProvider(album.imgUrl),
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: Text(
                  album.name,
                  style: Theme.of(context).textTheme.headline4,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: Text(
                  album.artist.name,
                  style: Theme.of(context).textTheme.subtitle2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
