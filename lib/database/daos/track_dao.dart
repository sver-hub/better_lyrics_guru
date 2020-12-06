part of '../moor_database.dart';

class TrackInfos extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get lyrics => text().nullable()();
  IntColumn get trackNumber => integer()();
  TextColumn get albumId =>
      text().customConstraint('REFERENCES album_infos(id)')();

  Set<Column> get primaryKey => {id};
}

extension TrackExtension on TrackInfo {
  Track asTrack({@required Album album}) => Track(
        id: id,
        name: name,
        trackNumber: trackNumber,
        lyrics: lyrics,
        album: album,
      );
}

@UseDao(tables: [TrackInfos])
class TrackInfoDao extends DatabaseAccessor<LyricsGuruDB>
    with _$TrackInfoDaoMixin {
  final LyricsGuruDB db;

  TrackInfoDao(this.db) : super(db);

  Future<List<Track>> getTracksOfAlbum(Album album) async {
    final query = select(trackInfos)
      ..where((t) => t.albumId.equals(album.id))
      ..orderBy(([
        (t) => OrderingTerm(expression: t.trackNumber),
      ]));

    return (await query.get())
        .map((row) => row.asTrack(
              album: album,
            ))
        .toList();
  }

  Stream<List<Track>> watchTracksOfAlbum(Album album) {
    final query = select(trackInfos)
      ..where((t) => t.albumId.equals(album.id))
      ..orderBy(([
        (t) => OrderingTerm(expression: t.trackNumber),
      ]));

    return query.watch().map((rows) => rows
        .map(
          (row) => row.asTrack(album: album),
        )
        .toList());
  }

  Future saveTrackInfo(Insertable<TrackInfo> trackInfo) =>
      into(trackInfos).insertOnConflictUpdate(trackInfo);

  Future deleteTrackInfo(Insertable<TrackInfo> trackInfo) =>
      delete(trackInfos).delete(trackInfo);
}
