import 'dart:io';

import 'package:moor/ffi.dart';
import 'package:moor/moor.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import '../logic/models/album.dart';
import '../logic/models/artist.dart';
import '../logic/models/track.dart';
import '../logic/models/user_data.dart';
import '../logic/models/word.dart';

part 'daos/album_dao.dart';
part 'daos/artist_dao.dart';
part 'daos/track_dao.dart';
part 'daos/user_dao.dart';
part 'daos/word_dao.dart';
part 'moor_database.g.dart';

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'lyrics_guru.sqlite'));
    return VmDatabase(file);
  });
}

@UseMoor(tables: [
  ArtistInfos,
  AlbumInfos,
  TrackInfos,
  UserInfos,
  WordInfos,
  WordTrackRefs,
], daos: [
  ArtistDao,
  AlbumDao,
  TrackDao,
  UserDao,
  WordDao,
])
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
