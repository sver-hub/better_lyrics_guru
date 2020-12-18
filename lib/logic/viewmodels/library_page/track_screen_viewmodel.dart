import 'package:flutter/material.dart';
import 'package:hooks_riverpod/all.dart';

import '../../../services/library/library_service.dart';
import '../../models/track.dart';

final trackSreenViewModel =
    ChangeNotifierProvider.family<TrackScreenViewModel, Track>((ref, track) {
  final libServ = ref.read(libraryService);
  return TrackScreenViewModel(track, libServ);
});

class TrackScreenViewModel extends ChangeNotifier {
  TrackScreenViewModel(Track track, this._libraryService) {
    _track = track;
  }

  final LibraryService _libraryService;

  Track _track;
  Track get track => _track;

  bool _analyzing = false;
  bool get analyzing => _analyzing;
  void _setAnalyzing(bool val) {
    _analyzing = val;
    notifyListeners();
  }

  Future analyzeTrack() async {
    _setAnalyzing(true);
    final words = await _libraryService.getWordsOfTrack(_track);
    for (final word in words) {
      debugPrint(word.word);
    }
    _setAnalyzing(false);
  }
}
