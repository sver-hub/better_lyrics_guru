import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/all.dart';

import '../../../logic/models/album.dart';
import '../../../logic/models/track.dart';
import '../../../logic/viewmodels/library_page/album_screen_viewmodel.dart';
import '../../navigation/route_generators/library_route_generator.dart';

class AlbumScreen extends HookWidget {
  final Album album;

  const AlbumScreen({Key key, this.album}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
            child: _buildCover(context),
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 20),
            sliver: buildList(),
          ),
        ],
      ),
    );
  }

  Widget _buildCover(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: MediaQuery.of(context).size.width,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: Image(
              image: CachedNetworkImageProvider(album.imgUrl),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
          height: MediaQuery.of(context).size.width,
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
              Container(
                child: IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios,
                  ),
                  iconSize: 30.0,
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
              SizedBox(width: 20.0),
              SizedBox(
                width: MediaQuery.of(context).size.width - 80,
                child: Text(
                  album.name,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildList() {
    // return ChangeNotifierProvider<AlbumScreenViewModel>(
    //   create: (context) => AlbumScreenViewModel(album),
    //   lazy: true,
    //   child: Consumer<AlbumScreenViewModel>(
    //     builder: (context, model, child) => SliverList(
    //       delegate: SliverChildListDelegate(
    //           model.tracks.map((t) => _TrackTile(track: t)).toList()),
    //     ),
    //   ),
    // );
    final model = useProvider(albumScreenViewModel(album));
    return SliverList(
      delegate: SliverChildListDelegate(
        model.tracks.map((t) => _TrackTile(track: t)).toList(),
      ),
    );
  }
}

class _TrackTile extends StatelessWidget {
  final Track track;

  const _TrackTile({Key key, this.track}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => Navigator.of(context)
          .pushNamed(LibraryRouteGenerator.TRACK, arguments: track),
      title: Text(
        track.name,
        style: TextStyle(
          fontSize: 24,
        ),
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(
        track.album.artist.name + ' - ' + track.album.name,
        style: TextStyle(
          color: Colors.white54,
        ),
      ),
    );
  }
}
