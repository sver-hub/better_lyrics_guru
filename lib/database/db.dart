import 'dart:io';
import 'dart:isolate';

import 'package:get_it/get_it.dart';
import 'package:lyrics_guru/database/moor_database.dart';
import 'package:moor/ffi.dart';
import 'package:moor/isolate.dart';
import 'package:moor/moor.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

Future<MoorIsolate> _createMoorIsolate() async {
  final dir = await getApplicationDocumentsDirectory();
  final path = p.join(dir.path, 'lyrics_guru.sqlite');
  final receivePort = ReceivePort();

  await Isolate.spawn(
    _startBackground,
    _IsolateStartRequest(receivePort.sendPort, path),
  );

  return (await receivePort.first as MoorIsolate);
}

void _startBackground(_IsolateStartRequest request) {
  final executor = VmDatabase(File(request.targetPath));
  final moorIsolate = MoorIsolate.inCurrent(
    () => DatabaseConnection.fromExecutor(executor),
  );

  request.sendMoorIsolate.send(moorIsolate);
}

class _IsolateStartRequest {
  final SendPort sendMoorIsolate;
  final String targetPath;

  _IsolateStartRequest(this.sendMoorIsolate, this.targetPath);
}

GetIt db = GetIt.instance;

Future initDb() async {
  MoorIsolate isolate = await _createMoorIsolate();
  DatabaseConnection connection = await isolate.connect();
  final database = LyricsGuruDB.connect(connection);

  db.registerLazySingleton<ArtistInfoDao>(() => ArtistInfoDao(database));
  db.registerLazySingleton<AlbumInfoDao>(() => AlbumInfoDao(database));
  db.registerLazySingleton<TrackInfoDao>(() => TrackInfoDao(database));
  db.registerLazySingleton<UserInfoDao>(() => UserInfoDao(database));
}
