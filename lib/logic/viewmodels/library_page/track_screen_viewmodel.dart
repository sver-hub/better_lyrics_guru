import 'package:flutter/material.dart';

import '../../models/track.dart';

class TrackScreenViewModel extends ChangeNotifier {
  Track _track;
  Track get track => _track;

  TrackScreenViewModel(Track track) {
    _track = track;
  }
}
