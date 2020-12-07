import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lyrics_guru/database/moor_database.dart';
import 'package:lyrics_guru/logic/models/artist.dart';
import 'package:lyrics_guru/services/library/library_service.dart';
import 'package:lyrics_guru/database/db.dart';

import '../../app_state.dart';

final libraryScreenViewModel =
    ChangeNotifierProvider<LibraryScreenViewModel>((ref) {
  final libServ = ref.read(libraryService);
  final appSt = ref.watch(appState);
  return LibraryScreenViewModel(libServ, appSt);
});

class LibraryScreenViewModel extends ChangeNotifier {
  final _artistDao = db<ArtistInfoDao>();
  final LibraryService _libraryService;
  final StateController<AppState> _appState;

  List<Artist> _artists = [];
  List<Artist> get artists => _artists;

  LibraryScreenViewModel(this._libraryService, this._appState) {
    loadData();
  }

  void loadData() async {
    _artistDao.watchAllArtists().listen((updatedList) {
      _artists = updatedList;
      notifyListeners();
    });
    if (_appState.state.needsDownload) {
      dowloadLibrary();
    }
  }

  void dowloadLibrary() async {
    _appState.state.isLibraryReady = false;
    await _libraryService.loadFavouriteTracks();
    _appState.state.isLibraryReady = true;
    _appState.state.needsDownload = false;
  }
}
