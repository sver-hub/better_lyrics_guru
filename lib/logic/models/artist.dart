import 'package:flutter/foundation.dart';
import 'package:moor/moor.dart';

import '../../database/moor_database.dart';

class Artist {
  final String id;
  final String name;
  final String imgUrl;

  const Artist({
    @required this.id,
    @required this.name,
    @required this.imgUrl,
  });

  @override
  bool operator ==(other) => other is Artist && other.id == id;

  @override
  int get hashCode => id.hashCode;

  ArtistInfosCompanion get asArtistInfo => ArtistInfosCompanion(
        id: id != null ? Value(id) : Value.absent(),
        name: name != null ? Value(name) : Value.absent(),
        imgUrl: imgUrl != null ? Value(imgUrl) : Value.absent(),
      );
}
