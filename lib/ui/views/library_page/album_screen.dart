import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/all.dart';

import '../../../logic/models/album.dart';
import '../../../logic/viewmodels/library_page/album_screen_viewmodel.dart';
import 'widgets/custom_image_cover_widget.dart';
import 'widgets/track_tile_widget.dart';

class AlbumScreen extends HookWidget {
  final Album album;

  const AlbumScreen({Key key, this.album}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: [
          _buildCover(context),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 20),
            sliver: buildList(),
          ),
        ],
      ),
    );
  }

  Widget _buildCover(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return SliverToBoxAdapter(
      child: CustomImageCoverWidget(
        imgUrl: album.imgUrl,
        width: screenWidth,
        height: screenWidth,
        caption: album.name,
      ),
    );
  }

  Widget buildList() {
    final model = useProvider(albumScreenViewModel(album));
    return SliverList(
      delegate: SliverChildListDelegate(
        model.tracks.map((t) => TrackTileWidget(track: t)).toList(),
      ),
    );
  }
}
