import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/all.dart';

import '../../../logic/models/album.dart';
import '../../../logic/models/artist.dart';
import '../../../logic/viewmodels/library_page/artist_screen_viewmodel.dart';
import '../../navigation/route_generators/library_route_generator.dart';

class ArtistScreen extends HookWidget {
  final Artist artist;

  const ArtistScreen({Key key, this.artist}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
            child: _buildCoverImage(context),
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(10, 30, 10, 20),
            sliver: _buildGrid(),
          ),
        ],
      ),
    );
  }

  Widget _buildCoverImage(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.width - 50,
          child: Image(
            image: CachedNetworkImageProvider(artist.imgUrl),
            fit: BoxFit.cover,
          ),
        ),
        Container(
          height: MediaQuery.of(context).size.width - 50,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: FractionalOffset(0.5, 0.7),
              end: FractionalOffset.bottomCenter,
              colors: [
                Colors.black.withOpacity(0.0),
                Colors.black.withOpacity(0.4),
              ],
              stops: [0.0, 1.0],
            ),
          ),
        ),
        Positioned(
          bottom: 10.0,
          left: 10.0,
          child: Row(
            children: [
              IconButton(
                icon: Icon(
                  Icons.arrow_back_ios,
                ),
                color: Colors.white,
                iconSize: 30.0,
                onPressed: () => Navigator.of(context).pop(),
              ),
              SizedBox(width: 20.0),
              Text(
                artist.name,
                style: Theme.of(context)
                    .textTheme
                    .headline2
                    .copyWith(color: Colors.white),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildGrid() {
    final model = useProvider(artistScreenViewModel(artist));
    return SliverGrid.count(
      crossAxisCount: 2,
      children: [for (final album in model.albums) _AlbumPreview(album: album)],
      crossAxisSpacing: 20.0,
      mainAxisSpacing: 20.0,
      childAspectRatio: 0.77,
    );
  }
}

class _AlbumPreview extends StatelessWidget {
  final Album album;

  const _AlbumPreview({Key key, this.album}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
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
              SizedBox(
                height: 10,
              ),
              SizedBox(
                width: double.infinity,
                child: Text(
                  album.name,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: Text(
                  album.artist.name,
                  style: TextStyle(
                    color: Colors.white54,
                    fontSize: 15,
                    letterSpacing: 0.8,
                  ),
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
