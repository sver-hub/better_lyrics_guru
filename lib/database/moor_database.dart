import 'dart:io';

import 'package:lyrics_guru/logic/models/album.dart';
import 'package:lyrics_guru/logic/models/artist.dart';
import 'package:lyrics_guru/logic/models/track.dart';
import 'package:lyrics_guru/logic/models/user_data.dart';
import 'package:moor/ffi.dart';
import 'package:moor/moor.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

part 'moor_database.g.dart';
part 'daos/artist_dao.dart';
part 'daos/album_dao.dart';
part 'daos/track_dao.dart';
part 'daos/user_dao.dart';

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'lyrics_guru.sqlite'));
    return VmDatabase(file);
  });
}

@UseMoor(
    tables: [ArtistInfos, AlbumInfos, TrackInfos, UserInfos],
    daos: [ArtistInfoDao, AlbumInfoDao, TrackInfoDao, UserInfoDao])
class LyricsGuruDB extends _$LyricsGuruDB {
  LyricsGuruDB() : super(_openConnection());

  LyricsGuruDB.connect(DatabaseConnection connection)
      : super.connect(connection);

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        beforeOpen: (details) async {
          await customStatement('PRAGMA foreign_keys = ON');
        },
      );
}
