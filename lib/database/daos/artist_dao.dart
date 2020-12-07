part of '../moor_database.dart';

class ArtistInfos extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get imgUrl => text()();

  Set<Column> get primaryKey => {id};
}

extension ArtistInfoExtension on ArtistInfo {
  Artist get asArtist => Artist(id: id, name: name, imgUrl: imgUrl);
}

extension ArtistExtension on Artist {
  ArtistInfosCompanion get asArtistInfo => ArtistInfosCompanion(
        id: id != null ? Value(id) : Value.absent(),
        name: name != null ? Value(name) : Value.absent(),
        imgUrl: imgUrl != null ? Value(imgUrl) : Value.absent(),
      );
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

  Future saveArtist(Artist artist) =>
      into(artistInfos).insertOnConflictUpdate(artist.asArtistInfo);

  Future deleteArtist(Artist artist) =>
      delete(artistInfos).delete(artist.asArtistInfo);
}
