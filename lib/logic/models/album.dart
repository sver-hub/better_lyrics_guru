import 'package:flutter/foundation.dart';
import 'package:moor/moor.dart';

import '../../database/moor_database.dart';
import 'artist.dart';

class Album {
  final String id;
  final String name;
  final String imgUrl;
  final DateTime releaseDate;
  final Artist artist;

  const Album({
    @required this.id,
    @required this.name,
    @required this.imgUrl,
    @required this.releaseDate,
    @required this.artist,
  });

  @override
  bool operator ==(other) => other is Album && other.id == id;

  @override
  int get hashCode => id.hashCode;

  AlbumInfosCompanion get asAlbumInfo => AlbumInfosCompanion(
        id: id != null ? Value(id) : Value.absent(),
        name: name != null ? Value(name) : Value.absent(),
        imgUrl: imgUrl != null ? Value(imgUrl) : Value.absent(),
        releaseDate: releaseDate != null ? Value(releaseDate) : Value.absent(),
        artistId: artist != null ? Value(artist.id) : Value.absent(),
      );
}
