import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/all.dart';

import '../../../logic/models/artist.dart';
import '../../../logic/viewmodels/library_page/artist_screen_viewmodel.dart';
import 'widgets/album_preview_widget.dart';
import 'widgets/custom_image_cover_widget.dart';

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
          _buildCoverImage(context),
          _buildGrid(),
        ],
      ),
    );
  }

  Widget _buildCoverImage(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return SliverToBoxAdapter(
      child: CustomImageCoverWidget(
        width: screenWidth,
        height: screenWidth - 50,
        imgUrl: artist.imgUrl,
        caption: artist.name,
      ),
    );
  }

  Widget _buildGrid() {
    final model = useProvider(artistScreenViewModel(artist));
    return SliverPadding(
      padding: const EdgeInsets.fromLTRB(10, 30, 10, 20),
      sliver: SliverGrid.count(
        crossAxisCount: 2,
        children: [
          for (final album in model.albums) AlbumPreviewWidget(album: album)
        ],
        crossAxisSpacing: 20.0,
        mainAxisSpacing: 20.0,
        childAspectRatio: 0.77,
      ),
    );
  }
}
