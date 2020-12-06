part of '../moor_database.dart';

class ArtistInfos extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get imgUrl => text()();

  Set<Column> get primaryKey => {id};
}

extension ArtistExtension on ArtistInfo {
  Artist get asArtist => Artist(id: id, name: name, imgUrl: imgUrl);
}

@UseDao(tables: [ArtistInfos])
class ArtistInfoDao extends DatabaseAccessor<LyricsGuruDB>
    with _$ArtistInfoDaoMixin {
  final LyricsGuruDB db;

  ArtistInfoDao(this.db) : super(db);

  Future<List<Artist>> getAllArtists() async {
    final query = (select(artistInfos)
      ..orderBy(
        ([
          (a) => OrderingTerm(expression: a.name),
        ]),
      ));

    return (await query.get()).map((row) => row.asArtist).toList();
  }

  Stream<List<Artist>> watchAllArtists() {
    final query = (select(artistInfos)
      ..orderBy(
        ([
          (a) => OrderingTerm(expression: a.name.lower()),
        ]),
      ));

    return query.watch().map((rows) => rows
        .map(
          (row) => row.asArtist,
        )
        .toList());
  }

  Future saveArtistInfo(Insertable<ArtistInfo> artistInfo) =>
      into(artistInfos).insertOnConflictUpdate(artistInfo);

  Future deleteArtistInfo(Insertable<ArtistInfo> artistInfo) =>
      delete(artistInfos).delete(artistInfo);
}
