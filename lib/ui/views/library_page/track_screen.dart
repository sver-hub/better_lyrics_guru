import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/all.dart';

import '../../../logic/models/track.dart';
import '../../../logic/viewmodels/library_page/track_screen_viewmodel.dart';
import '../../widgets/custom_flat_button.dart';
import '../../widgets/return_widget.dart';

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
          ReturnWidget(title: 'Back to ' + track.album.name),
          _buildName(),
          Divider(color: Colors.grey[700], thickness: 1),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: _buildLyrics(model),
          ),
          _buildButton(context, model),
          SizedBox(height: 30),
        ],
      ),
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

  Widget _buildLyrics(TrackScreenViewModel model) {
    return Column(
      children: [
        ...model.lyrics.map(
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
      spinnerColor: Colors.white,
      onTap: () => model.analyzeTrack(Navigator.of(context)),
    );
  }
}
