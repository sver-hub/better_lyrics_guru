import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../logic/viewmodels/library_page/library_screen_viewmodel.dart';
import 'widgets/artist_preview_widget.dart';

class LibraryScreen extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final model = useProvider(libraryScreenViewModel);
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: [
          _buildTitle(context),
          _buildButtons(model),
          _buildList(model),
        ],
      ),
    );
  }

  Widget _buildTitle(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: 150,
        child: Center(
          child: Text(
            'Your Music',
            style: Theme.of(context).textTheme.headline2,
          ),
        ),
      ),
    );
  }

  Widget _buildButtons(LibraryScreenViewModel model) {
    return SliverToBoxAdapter(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () =>
                model.state.isLoading ? null : model.dowloadLibrary(),
          ),
          SizedBox(width: 40),
          IconButton(
            icon: Icon(Icons.download_sharp),
            onPressed: () =>
                model.state.isLoading ? null : model.downloadLyrics(),
          ),
        ],
      ),
    );
  }

  Widget _buildList(LibraryScreenViewModel model) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) => ArtistPreviewWidget(model.artists[index]),
        childCount: model.artists.length,
      ),
    );
  }
}
