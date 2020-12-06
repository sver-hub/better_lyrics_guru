import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lyrics_guru/database/moor_database.dart';
import 'package:lyrics_guru/logic/models/album.dart';
import 'package:lyrics_guru/logic/models/track.dart';
import 'package:lyrics_guru/database/db.dart';

final albumScreenViewModel =
    ChangeNotifierProvider.family<AlbumScreenViewModel, Album>(
        (ref, album) => AlbumScreenViewModel(album));

class AlbumScreenViewModel extends ChangeNotifier {
  List<Track> _tracks = [];
  List<Track> get tracks => _tracks;

  Album _album;
  Album get album => _album;

  final _trackProvider = db<TrackInfoDao>();

  AlbumScreenViewModel(Album album) {
    _album = album;
    loadData();
  }

  void loadData() async {
    _tracks = await _trackProvider.getTracksOfAlbum(album);
    notifyListeners();
  }
}
