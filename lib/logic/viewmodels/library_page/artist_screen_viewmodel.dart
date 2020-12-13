import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../database/db.dart';
import '../../../database/moor_database.dart';
import '../../models/album.dart';
import '../../models/artist.dart';

final artistScreenViewModel =
    ChangeNotifierProvider.family<ArtistScreenViewModel, Artist>(
        (ref, artist) => ArtistScreenViewModel(artist));

class ArtistScreenViewModel extends ChangeNotifier {
  ArtistScreenViewModel(Artist artist) {
    _artist = artist;
    loadData();
  }

  final _albumDao = db<AlbumDao>();

  List<Album> _albums = [];
  List<Album> get albums => _albums;

  Artist _artist;
  Artist get artist => _artist;

  bool _sortAsc = true;
  set sortAsc(bool val) => {if (val != _sortAsc) _albums = _albums.reversed};

  void loadData() async {
    _albumDao.watchAlbumsOfArtist(_artist).listen((updatedList) {
      _albums = updatedList;
      notifyListeners();
    });
  }
}
