import 'package:flutter/foundation.dart';
import 'package:moor/moor.dart';

import '../../database/moor_database.dart';
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

  TrackInfosCompanion get asTrackInfo => TrackInfosCompanion(
        id: id != null ? Value(id) : Value.absent(),
        name: name != null ? Value(name) : Value.absent(),
        trackNumber: trackNumber != null ? Value(trackNumber) : Value.absent(),
        lyrics: lyrics != null ? Value(lyrics) : Value.absent(),
        albumId: album != null ? Value(album.id) : Value.absent(),
      );
}
