import 'package:flutter/foundation.dart';
import 'package:moor/moor.dart';

import 'album.dart';

class Track {
  final String id;
  final String name;
  final String lyrics;
  final int trackNumber;
  final Album album;

  const Track({
    @required this.id,
    @required this.name,
    @required this.trackNumber,
    @required this.lyrics,
    @required this.album,
  });

  @override
  bool operator ==(other) => other is Track && other.id == id;

  @override
  int get hashCode => id.hashCode;
}
