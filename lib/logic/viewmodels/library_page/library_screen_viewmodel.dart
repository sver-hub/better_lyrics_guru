import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lyrics_guru/database/moor_database.dart';
import 'package:lyrics_guru/logic/models/artist.dart';
import 'package:lyrics_guru/services/library/library_service.dart';
import 'package:lyrics_guru/database/db.dart';

import '../../app_state/app_state.dart';

final libraryScreenViewModel =
    ChangeNotifierProvider<LibraryScreenViewModel>((ref) {
  final libServ = ref.read(libraryService);
  final libState = ref.watch(libraryState);
  return LibraryScreenViewModel(libServ, libState);
});

class LibraryScreenViewModel extends ChangeNotifier {
  final _artistDao = db<ArtistDao>();
  final LibraryService _libraryService;
  final LibraryState _libraryState;

  List<Artist> _artists = [];
  List<Artist> get artists => _artists;

  LibraryScreenViewModel(this._libraryService, this._libraryState) {
    loadData();
  }

  void loadData() async {
    _artistDao.watchAllArtists().listen((updatedList) {
      _artists = updatedList;
      notifyListeners();
    });
    if (_libraryState.needsDownload) {
      dowloadLibrary();
    }
  }

  void dowloadLibrary() async {
    _libraryState.setLoading();
    await _libraryService.loadFavouriteTracks();
    _libraryState.setReady();
  }

  Stream<int> downloadLyrics() {
    return _libraryService.loadLyrics();
  }
}
