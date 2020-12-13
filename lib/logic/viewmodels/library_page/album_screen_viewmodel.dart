import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../database/db.dart';
import '../../../database/moor_database.dart';
import '../../models/album.dart';
import '../../models/track.dart';

final albumScreenViewModel =
    ChangeNotifierProvider.family<AlbumScreenViewModel, Album>(
        (ref, album) => AlbumScreenViewModel(album));

class AlbumScreenViewModel extends ChangeNotifier {
  List<Track> _tracks = [];
  List<Track> get tracks => _tracks;

  Album _album;
  Album get album => _album;

  final _trackDao = db<TrackDao>();

  AlbumScreenViewModel(Album album) {
    _album = album;
    loadData();
  }

  void loadData() async {
    _trackDao.watchTracksOfAlbum(_album).listen((updatedList) {
      _tracks = updatedList;
      notifyListeners();
    });
  }
}
