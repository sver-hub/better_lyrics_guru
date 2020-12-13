import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../logic/app_state/app_state.dart';
import '../../../logic/models/artist.dart';
import '../../../logic/viewmodels/library_page/library_screen_viewmodel.dart';
import '../../navigation/route_generators/library_route_generator.dart';

class LibraryScreen extends HookWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: FractionalOffset.topLeft,
          end: FractionalOffset.bottomRight,
          stops: [0, 0.6],
          colors: [Color(0xFF33658A), Colors.black],
        ),
      ),
      padding: const EdgeInsets.fromLTRB(10, 30, 10, 0),
      child: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: [
          _buildTitle(),
          _buildButtons(),
          _buildList(),
        ],
      ),
    );
  }

  Widget _buildTitle() {
    return const SliverToBoxAdapter(
      child: SizedBox(
        height: 150,
        child: Center(
          child: Text(
            'Your Music',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
          ),
        ),
      ),
    );
  }

  Widget _buildButtons() {
    final state = useProvider(libraryState);
    return Builder(
      builder: (context) => SliverToBoxAdapter(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () => state.isLoading
                  ? null
                  : context.read(libraryScreenViewModel).dowloadLibrary(),
            ),
            SizedBox(width: 40),
            IconButton(
                icon: Icon(Icons.download_sharp),
                onPressed: () => state.isLoading
                    ? null
                    : context.read(libraryScreenViewModel).downloadLyrics()),
          ],
        ),
      ),
    );
  }

  Widget _buildList() {
    final model = useProvider(libraryScreenViewModel);
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) => _ArtistPreview(model.artists[index]),
        childCount: model.artists.length,
      ),
    );
  }
}

class _ArtistPreview extends StatelessWidget {
  final Artist artist;

  const _ArtistPreview(this.artist, {Key key}) : super(key: key);

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
