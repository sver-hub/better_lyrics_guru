import 'package:flutter/material.dart';
import 'package:hooks_riverpod/all.dart';
import '../../../ui/views/library_page/found_words_screen.dart';

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

  Future analyzeTrack(NavigatorState nav) async {
    _setAnalyzing(true);
    final words = await _libraryService.getWordsOfTrack(_track);
    for (final word in words) {
      debugPrint(word.word);
    }
    _setAnalyzing(false);
    //TODO: refactor to named route
    nav.push(MaterialPageRoute(
      builder: (context) => FoundWordsScreen(
        artistName: track.album.artist.name,
        trackName: track.name,
        words: words,
      ),
    ));
  }

  List<String> get lyrics {
    if (_track.lyrics == null)
      return ['Lyrics are still to be downloaded'];
    else if (_track.lyrics == 'Not Available')
      return [
        'Unfortunatelly our crystall ball couldn\'t find lyrics of this track...'
      ];
    else if (_track.lyrics == 'Instrumental')
      return ['This track is instrumental, nothing to be learnt here...'];
    else
      return _track.lyrics.split('\n');
  }
}
