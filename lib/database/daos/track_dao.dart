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

extension TrackInfoExtension on TrackInfo {
  Track asTrack({@required Album album}) => Track(
        id: id,
        name: name,
        trackNumber: trackNumber,
        lyrics: lyrics,
        album: album,
      );
}

extension TrackExtension on Track {
  TrackInfosCompanion get asTrackInfo => TrackInfosCompanion(
        id: id != null ? Value(id) : Value.absent(),
        name: name != null ? Value(name) : Value.absent(),
        trackNumber: trackNumber != null ? Value(trackNumber) : Value.absent(),
        lyrics: lyrics != null ? Value(lyrics) : Value.absent(),
        albumId: album != null ? Value(album.id) : Value.absent(),
      );
}

@UseDao(tables: [TrackInfos])
class TrackDao extends DatabaseAccessor<LyricsGuruDB> with _$TrackDaoMixin {
  final LyricsGuruDB db;

  TrackDao(this.db) : super(db);

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

  Future saveTrack(Track track) =>
      into(trackInfos).insertOnConflictUpdate(track.asTrackInfo);

  Future deleteTrack(Track track) =>
      delete(trackInfos).delete(track.asTrackInfo);
}
