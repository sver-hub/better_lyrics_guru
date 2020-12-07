part of '../moor_database.dart';

class AlbumInfos extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get imgUrl => text()();
  DateTimeColumn get releaseDate => dateTime()();
  TextColumn get artistId =>
      text().customConstraint('REFERENCES artist_infos(id)')();

  Set<Column> get primaryKey => {id};
}

extension AlbumInfoExtension on AlbumInfo {
  Album asAlbum({@required Artist artist}) => Album(
      id: id,
      name: name,
      imgUrl: imgUrl,
      releaseDate: releaseDate,
      artist: artist);
}

extension AlbumExtension on Album {
  AlbumInfosCompanion get asAlbumInfo => AlbumInfosCompanion(
        id: id != null ? Value(id) : Value.absent(),
        name: name != null ? Value(name) : Value.absent(),
        imgUrl: imgUrl != null ? Value(imgUrl) : Value.absent(),
        releaseDate: releaseDate != null ? Value(releaseDate) : Value.absent(),
        artistId: artist != null ? Value(artist.id) : Value.absent(),
      );
}

@UseDao(tables: [AlbumInfos])
class AlbumInfoDao extends DatabaseAccessor<LyricsGuruDB>
    with _$AlbumInfoDaoMixin {
  final LyricsGuruDB db;

  AlbumInfoDao(this.db) : super(db);

  Future<List<Album>> getAlbumsOfArtist(Artist artist) async {
    final query = select(albumInfos)
      ..where((a) => a.artistId.equals(artist.id))
      ..orderBy(
        ([
          (a) => OrderingTerm(expression: a.releaseDate),
        ]),
      );

    return (await query.get())
        .map((row) => row.asAlbum(
              artist: artist,
            ))
        .toList();
  }

  Stream<List<Album>> watchAlbumsOfArtist(Artist artist) {
    final query = select(albumInfos)
      ..where((a) => a.artistId.equals(artist.id))
      ..orderBy(
        ([
          (a) => OrderingTerm(expression: a.releaseDate),
        ]),
      );
    return query.watch().map((rows) => rows
        .map(
          (row) => row.asAlbum(artist: artist),
        )
        .toList());
  }

  Future saveAlbum(Album album) =>
      into(albumInfos).insertOnConflictUpdate(album.asAlbumInfo);

  Future deleteAlbum(Album album) =>
      delete(albumInfos).delete(album.asAlbumInfo);
}
