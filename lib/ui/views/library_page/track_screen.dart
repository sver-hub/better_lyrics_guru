import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/all.dart';
import '../../../logic/viewmodels/library_page/track_screen_viewmodel.dart';
import '../../widgets/custom_flat_button.dart';

import '../../../logic/models/track.dart';

class TrackScreen extends HookWidget {
  final Track track;

  const TrackScreen({Key key, this.track}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = useProvider(trackSreenViewModel(track));
    return Container(
      color: Colors.white,
      child: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 20, 20, 20),
            child: _buildReturn(context),
          ),
          _buildName(),
          Divider(color: Colors.grey[700], thickness: 1),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: _buildLyrics(),
          ),
          _buildButton(context, model),
          SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }

  Widget _buildReturn(BuildContext context) {
    return Row(
      children: [
        IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width - 80,
          child: Text(
            'Back to ' + track.album.name,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 18,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildName() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: SizedBox(
            width: double.infinity,
            child: Text(
              track.name,
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.8,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(30, 10, 20, 0),
          child: SizedBox(
            width: double.infinity,
            child: Text(
              'By ' + track.album.artist.name,
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 17,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLyrics() {
    return Column(
      children: [
        ..._getLines(track.lyrics).map(
          (e) => Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: SizedBox(
              width: double.infinity,
              child: Text(
                e,
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget _buildButton(BuildContext context, TrackScreenViewModel model) {
    return CustomFlatButton(
      child: Text(
        'Analyze',
        style:
            Theme.of(context).textTheme.headline2.copyWith(color: Colors.white),
      ),
      color: Colors.indigo,
      loading: model.analyzing,
      onTap: () => model.analyzeTrack(),
    );
  }

  List<String> _getLines(String text) {
    if (text == null)
      return [
        'Either This Track Is Instrumental',
        'Or Lyrics Are Not Accessible'
      ];
    return text.split('\n');
  }
}
