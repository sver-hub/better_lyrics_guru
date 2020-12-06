// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'moor_database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class ArtistInfo extends DataClass implements Insertable<ArtistInfo> {
  final String id;
  final String name;
  final String imgUrl;
  ArtistInfo({@required this.id, @required this.name, @required this.imgUrl});
  factory ArtistInfo.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final stringType = db.typeSystem.forDartType<String>();
    return ArtistInfo(
      id: stringType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      name: stringType.mapFromDatabaseResponse(data['${effectivePrefix}name']),
      imgUrl:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}img_url']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<String>(id);
    }
    if (!nullToAbsent || name != null) {
      map['name'] = Variable<String>(name);
    }
    if (!nullToAbsent || imgUrl != null) {
      map['img_url'] = Variable<String>(imgUrl);
    }
    return map;
  }

  ArtistInfosCompanion toCompanion(bool nullToAbsent) {
    return ArtistInfosCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      imgUrl:
          imgUrl == null && nullToAbsent ? const Value.absent() : Value(imgUrl),
    );
  }

  factory ArtistInfo.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return ArtistInfo(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      imgUrl: serializer.fromJson<String>(json['imgUrl']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'imgUrl': serializer.toJson<String>(imgUrl),
    };
  }

  ArtistInfo copyWith({String id, String name, String imgUrl}) => ArtistInfo(
        id: id ?? this.id,
        name: name ?? this.name,
        imgUrl: imgUrl ?? this.imgUrl,
      );
  @override
  String toString() {
    return (StringBuffer('ArtistInfo(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('imgUrl: $imgUrl')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      $mrjf($mrjc(id.hashCode, $mrjc(name.hashCode, imgUrl.hashCode)));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is ArtistInfo &&
          other.id == this.id &&
          other.name == this.name &&
          other.imgUrl == this.imgUrl);
}

class ArtistInfosCompanion extends UpdateCompanion<ArtistInfo> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> imgUrl;
  const ArtistInfosCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.imgUrl = const Value.absent(),
  });
  ArtistInfosCompanion.insert({
    @required String id,
    @required String name,
    @required String imgUrl,
  })  : id = Value(id),
        name = Value(name),
        imgUrl = Value(imgUrl);
  static Insertable<ArtistInfo> custom({
    Expression<String> id,
    Expression<String> name,
    Expression<String> imgUrl,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (imgUrl != null) 'img_url': imgUrl,
    });
  }

  ArtistInfosCompanion copyWith(
      {Value<String> id, Value<String> name, Value<String> imgUrl}) {
    return ArtistInfosCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      imgUrl: imgUrl ?? this.imgUrl,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (imgUrl.present) {
      map['img_url'] = Variable<String>(imgUrl.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ArtistInfosCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('imgUrl: $imgUrl')
          ..write(')'))
        .toString();
  }
}

class $ArtistInfosTable extends ArtistInfos
    with TableInfo<$ArtistInfosTable, ArtistInfo> {
  final GeneratedDatabase _db;
  final String _alias;
  $ArtistInfosTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedTextColumn _id;
  @override
  GeneratedTextColumn get id => _id ??= _constructId();
  GeneratedTextColumn _constructId() {
    return GeneratedTextColumn(
      'id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _nameMeta = const VerificationMeta('name');
  GeneratedTextColumn _name;
  @override
  GeneratedTextColumn get name => _name ??= _constructName();
  GeneratedTextColumn _constructName() {
    return GeneratedTextColumn(
      'name',
      $tableName,
      false,
    );
  }

  final VerificationMeta _imgUrlMeta = const VerificationMeta('imgUrl');
  GeneratedTextColumn _imgUrl;
  @override
  GeneratedTextColumn get imgUrl => _imgUrl ??= _constructImgUrl();
  GeneratedTextColumn _constructImgUrl() {
    return GeneratedTextColumn(
      'img_url',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [id, name, imgUrl];
  @override
  $ArtistInfosTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'artist_infos';
  @override
  final String actualTableName = 'artist_infos';
  @override
  VerificationContext validateIntegrity(Insertable<ArtistInfo> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name'], _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('img_url')) {
      context.handle(_imgUrlMeta,
          imgUrl.isAcceptableOrUnknown(data['img_url'], _imgUrlMeta));
    } else if (isInserting) {
      context.missing(_imgUrlMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ArtistInfo map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return ArtistInfo.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $ArtistInfosTable createAlias(String alias) {
    return $ArtistInfosTable(_db, alias);
  }
}

class AlbumInfo extends DataClass implements Insertable<AlbumInfo> {
  final String id;
  final String name;
  final String imgUrl;
  final DateTime releaseDate;
  final String artistId;
  AlbumInfo(
      {@required this.id,
      @required this.name,
      @required this.imgUrl,
      @required this.releaseDate,
      @required this.artistId});
  factory AlbumInfo.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final stringType = db.typeSystem.forDartType<String>();
    final dateTimeType = db.typeSystem.forDartType<DateTime>();
    return AlbumInfo(
      id: stringType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      name: stringType.mapFromDatabaseResponse(data['${effectivePrefix}name']),
      imgUrl:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}img_url']),
      releaseDate: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}release_date']),
      artistId: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}artist_id']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<String>(id);
    }
    if (!nullToAbsent || name != null) {
      map['name'] = Variable<String>(name);
    }
    if (!nullToAbsent || imgUrl != null) {
      map['img_url'] = Variable<String>(imgUrl);
    }
    if (!nullToAbsent || releaseDate != null) {
      map['release_date'] = Variable<DateTime>(releaseDate);
    }
    if (!nullToAbsent || artistId != null) {
      map['artist_id'] = Variable<String>(artistId);
    }
    return map;
  }

  AlbumInfosCompanion toCompanion(bool nullToAbsent) {
    return AlbumInfosCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      imgUrl:
          imgUrl == null && nullToAbsent ? const Value.absent() : Value(imgUrl),
      releaseDate: releaseDate == null && nullToAbsent
          ? const Value.absent()
          : Value(releaseDate),
      artistId: artistId == null && nullToAbsent
          ? const Value.absent()
          : Value(artistId),
    );
  }

  factory AlbumInfo.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return AlbumInfo(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      imgUrl: serializer.fromJson<String>(json['imgUrl']),
      releaseDate: serializer.fromJson<DateTime>(json['releaseDate']),
      artistId: serializer.fromJson<String>(json['artistId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'imgUrl': serializer.toJson<String>(imgUrl),
      'releaseDate': serializer.toJson<DateTime>(releaseDate),
      'artistId': serializer.toJson<String>(artistId),
    };
  }

  AlbumInfo copyWith(
          {String id,
          String name,
          String imgUrl,
          DateTime releaseDate,
          String artistId}) =>
      AlbumInfo(
        id: id ?? this.id,
        name: name ?? this.name,
        imgUrl: imgUrl ?? this.imgUrl,
        releaseDate: releaseDate ?? this.releaseDate,
        artistId: artistId ?? this.artistId,
      );
  @override
  String toString() {
    return (StringBuffer('AlbumInfo(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('imgUrl: $imgUrl, ')
          ..write('releaseDate: $releaseDate, ')
          ..write('artistId: $artistId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          name.hashCode,
          $mrjc(imgUrl.hashCode,
              $mrjc(releaseDate.hashCode, artistId.hashCode)))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is AlbumInfo &&
          other.id == this.id &&
          other.name == this.name &&
          other.imgUrl == this.imgUrl &&
          other.releaseDate == this.releaseDate &&
          other.artistId == this.artistId);
}

class AlbumInfosCompanion extends UpdateCompanion<AlbumInfo> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> imgUrl;
  final Value<DateTime> releaseDate;
  final Value<String> artistId;
  const AlbumInfosCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.imgUrl = const Value.absent(),
    this.releaseDate = const Value.absent(),
    this.artistId = const Value.absent(),
  });
  AlbumInfosCompanion.insert({
    @required String id,
    @required String name,
    @required String imgUrl,
    @required DateTime releaseDate,
    @required String artistId,
  })  : id = Value(id),
        name = Value(name),
        imgUrl = Value(imgUrl),
        releaseDate = Value(releaseDate),
        artistId = Value(artistId);
  static Insertable<AlbumInfo> custom({
    Expression<String> id,
    Expression<String> name,
    Expression<String> imgUrl,
    Expression<DateTime> releaseDate,
    Expression<String> artistId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (imgUrl != null) 'img_url': imgUrl,
      if (releaseDate != null) 'release_date': releaseDate,
      if (artistId != null) 'artist_id': artistId,
    });
  }

  AlbumInfosCompanion copyWith(
      {Value<String> id,
      Value<String> name,
      Value<String> imgUrl,
      Value<DateTime> releaseDate,
      Value<String> artistId}) {
    return AlbumInfosCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      imgUrl: imgUrl ?? this.imgUrl,
      releaseDate: releaseDate ?? this.releaseDate,
      artistId: artistId ?? this.artistId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (imgUrl.present) {
      map['img_url'] = Variable<String>(imgUrl.value);
    }
    if (releaseDate.present) {
      map['release_date'] = Variable<DateTime>(releaseDate.value);
    }
    if (artistId.present) {
      map['artist_id'] = Variable<String>(artistId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AlbumInfosCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('imgUrl: $imgUrl, ')
          ..write('releaseDate: $releaseDate, ')
          ..write('artistId: $artistId')
          ..write(')'))
        .toString();
  }
}

class $AlbumInfosTable extends AlbumInfos
    with TableInfo<$AlbumInfosTable, AlbumInfo> {
  final GeneratedDatabase _db;
  final String _alias;
  $AlbumInfosTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedTextColumn _id;
  @override
  GeneratedTextColumn get id => _id ??= _constructId();
  GeneratedTextColumn _constructId() {
    return GeneratedTextColumn(
      'id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _nameMeta = const VerificationMeta('name');
  GeneratedTextColumn _name;
  @override
  GeneratedTextColumn get name => _name ??= _constructName();
  GeneratedTextColumn _constructName() {
    return GeneratedTextColumn(
      'name',
      $tableName,
      false,
    );
  }

  final VerificationMeta _imgUrlMeta = const VerificationMeta('imgUrl');
  GeneratedTextColumn _imgUrl;
  @override
  GeneratedTextColumn get imgUrl => _imgUrl ??= _constructImgUrl();
  GeneratedTextColumn _constructImgUrl() {
    return GeneratedTextColumn(
      'img_url',
      $tableName,
      false,
    );
  }

  final VerificationMeta _releaseDateMeta =
      const VerificationMeta('releaseDate');
  GeneratedDateTimeColumn _releaseDate;
  @override
  GeneratedDateTimeColumn get releaseDate =>
      _releaseDate ??= _constructReleaseDate();
  GeneratedDateTimeColumn _constructReleaseDate() {
    return GeneratedDateTimeColumn(
      'release_date',
      $tableName,
      false,
    );
  }

  final VerificationMeta _artistIdMeta = const VerificationMeta('artistId');
  GeneratedTextColumn _artistId;
  @override
  GeneratedTextColumn get artistId => _artistId ??= _constructArtistId();
  GeneratedTextColumn _constructArtistId() {
    return GeneratedTextColumn('artist_id', $tableName, false,
        $customConstraints: 'REFERENCES artist_infos(id)');
  }

  @override
  List<GeneratedColumn> get $columns =>
      [id, name, imgUrl, releaseDate, artistId];
  @override
  $AlbumInfosTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'album_infos';
  @override
  final String actualTableName = 'album_infos';
  @override
  VerificationContext validateIntegrity(Insertable<AlbumInfo> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name'], _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('img_url')) {
      context.handle(_imgUrlMeta,
          imgUrl.isAcceptableOrUnknown(data['img_url'], _imgUrlMeta));
    } else if (isInserting) {
      context.missing(_imgUrlMeta);
    }
    if (data.containsKey('release_date')) {
      context.handle(
          _releaseDateMeta,
          releaseDate.isAcceptableOrUnknown(
              data['release_date'], _releaseDateMeta));
    } else if (isInserting) {
      context.missing(_releaseDateMeta);
    }
    if (data.containsKey('artist_id')) {
      context.handle(_artistIdMeta,
          artistId.isAcceptableOrUnknown(data['artist_id'], _artistIdMeta));
    } else if (isInserting) {
      context.missing(_artistIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AlbumInfo map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return AlbumInfo.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $AlbumInfosTable createAlias(String alias) {
    return $AlbumInfosTable(_db, alias);
  }
}

class TrackInfo extends DataClass implements Insertable<TrackInfo> {
  final String id;
  final String name;
  final String lyrics;
  final int trackNumber;
  final String albumId;
  TrackInfo(
      {@required this.id,
      @required this.name,
      this.lyrics,
      @required this.trackNumber,
      @required this.albumId});
  factory TrackInfo.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final stringType = db.typeSystem.forDartType<String>();
    final intType = db.typeSystem.forDartType<int>();
    return TrackInfo(
      id: stringType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      name: stringType.mapFromDatabaseResponse(data['${effectivePrefix}name']),
      lyrics:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}lyrics']),
      trackNumber: intType
          .mapFromDatabaseResponse(data['${effectivePrefix}track_number']),
      albumId: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}album_id']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<String>(id);
    }
    if (!nullToAbsent || name != null) {
      map['name'] = Variable<String>(name);
    }
    if (!nullToAbsent || lyrics != null) {
      map['lyrics'] = Variable<String>(lyrics);
    }
    if (!nullToAbsent || trackNumber != null) {
      map['track_number'] = Variable<int>(trackNumber);
    }
    if (!nullToAbsent || albumId != null) {
      map['album_id'] = Variable<String>(albumId);
    }
    return map;
  }

  TrackInfosCompanion toCompanion(bool nullToAbsent) {
    return TrackInfosCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      lyrics:
          lyrics == null && nullToAbsent ? const Value.absent() : Value(lyrics),
      trackNumber: trackNumber == null && nullToAbsent
          ? const Value.absent()
          : Value(trackNumber),
      albumId: albumId == null && nullToAbsent
          ? const Value.absent()
          : Value(albumId),
    );
  }

  factory TrackInfo.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return TrackInfo(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      lyrics: serializer.fromJson<String>(json['lyrics']),
      trackNumber: serializer.fromJson<int>(json['trackNumber']),
      albumId: serializer.fromJson<String>(json['albumId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'lyrics': serializer.toJson<String>(lyrics),
      'trackNumber': serializer.toJson<int>(trackNumber),
      'albumId': serializer.toJson<String>(albumId),
    };
  }

  TrackInfo copyWith(
          {String id,
          String name,
          String lyrics,
          int trackNumber,
          String albumId}) =>
      TrackInfo(
        id: id ?? this.id,
        name: name ?? this.name,
        lyrics: lyrics ?? this.lyrics,
        trackNumber: trackNumber ?? this.trackNumber,
        albumId: albumId ?? this.albumId,
      );
  @override
  String toString() {
    return (StringBuffer('TrackInfo(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('lyrics: $lyrics, ')
          ..write('trackNumber: $trackNumber, ')
          ..write('albumId: $albumId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          name.hashCode,
          $mrjc(lyrics.hashCode,
              $mrjc(trackNumber.hashCode, albumId.hashCode)))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is TrackInfo &&
          other.id == this.id &&
          other.name == this.name &&
          other.lyrics == this.lyrics &&
          other.trackNumber == this.trackNumber &&
          other.albumId == this.albumId);
}

class TrackInfosCompanion extends UpdateCompanion<TrackInfo> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> lyrics;
  final Value<int> trackNumber;
  final Value<String> albumId;
  const TrackInfosCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.lyrics = const Value.absent(),
    this.trackNumber = const Value.absent(),
    this.albumId = const Value.absent(),
  });
  TrackInfosCompanion.insert({
    @required String id,
    @required String name,
    this.lyrics = const Value.absent(),
    @required int trackNumber,
    @required String albumId,
  })  : id = Value(id),
        name = Value(name),
        trackNumber = Value(trackNumber),
        albumId = Value(albumId);
  static Insertable<TrackInfo> custom({
    Expression<String> id,
    Expression<String> name,
    Expression<String> lyrics,
    Expression<int> trackNumber,
    Expression<String> albumId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (lyrics != null) 'lyrics': lyrics,
      if (trackNumber != null) 'track_number': trackNumber,
      if (albumId != null) 'album_id': albumId,
    });
  }

  TrackInfosCompanion copyWith(
      {Value<String> id,
      Value<String> name,
      Value<String> lyrics,
      Value<int> trackNumber,
      Value<String> albumId}) {
    return TrackInfosCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      lyrics: lyrics ?? this.lyrics,
      trackNumber: trackNumber ?? this.trackNumber,
      albumId: albumId ?? this.albumId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (lyrics.present) {
      map['lyrics'] = Variable<String>(lyrics.value);
    }
    if (trackNumber.present) {
      map['track_number'] = Variable<int>(trackNumber.value);
    }
    if (albumId.present) {
      map['album_id'] = Variable<String>(albumId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TrackInfosCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('lyrics: $lyrics, ')
          ..write('trackNumber: $trackNumber, ')
          ..write('albumId: $albumId')
          ..write(')'))
        .toString();
  }
}

class $TrackInfosTable extends TrackInfos
    with TableInfo<$TrackInfosTable, TrackInfo> {
  final GeneratedDatabase _db;
  final String _alias;
  $TrackInfosTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedTextColumn _id;
  @override
  GeneratedTextColumn get id => _id ??= _constructId();
  GeneratedTextColumn _constructId() {
    return GeneratedTextColumn(
      'id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _nameMeta = const VerificationMeta('name');
  GeneratedTextColumn _name;
  @override
  GeneratedTextColumn get name => _name ??= _constructName();
  GeneratedTextColumn _constructName() {
    return GeneratedTextColumn(
      'name',
      $tableName,
      false,
    );
  }

  final VerificationMeta _lyricsMeta = const VerificationMeta('lyrics');
  GeneratedTextColumn _lyrics;
  @override
  GeneratedTextColumn get lyrics => _lyrics ??= _constructLyrics();
  GeneratedTextColumn _constructLyrics() {
    return GeneratedTextColumn(
      'lyrics',
      $tableName,
      true,
    );
  }

  final VerificationMeta _trackNumberMeta =
      const VerificationMeta('trackNumber');
  GeneratedIntColumn _trackNumber;
  @override
  GeneratedIntColumn get trackNumber =>
      _trackNumber ??= _constructTrackNumber();
  GeneratedIntColumn _constructTrackNumber() {
    return GeneratedIntColumn(
      'track_number',
      $tableName,
      false,
    );
  }

  final VerificationMeta _albumIdMeta = const VerificationMeta('albumId');
  GeneratedTextColumn _albumId;
  @override
  GeneratedTextColumn get albumId => _albumId ??= _constructAlbumId();
  GeneratedTextColumn _constructAlbumId() {
    return GeneratedTextColumn('album_id', $tableName, false,
        $customConstraints: 'REFERENCES album_infos(id)');
  }

  @override
  List<GeneratedColumn> get $columns =>
      [id, name, lyrics, trackNumber, albumId];
  @override
  $TrackInfosTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'track_infos';
  @override
  final String actualTableName = 'track_infos';
  @override
  VerificationContext validateIntegrity(Insertable<TrackInfo> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name'], _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('lyrics')) {
      context.handle(_lyricsMeta,
          lyrics.isAcceptableOrUnknown(data['lyrics'], _lyricsMeta));
    }
    if (data.containsKey('track_number')) {
      context.handle(
          _trackNumberMeta,
          trackNumber.isAcceptableOrUnknown(
              data['track_number'], _trackNumberMeta));
    } else if (isInserting) {
      context.missing(_trackNumberMeta);
    }
    if (data.containsKey('album_id')) {
      context.handle(_albumIdMeta,
          albumId.isAcceptableOrUnknown(data['album_id'], _albumIdMeta));
    } else if (isInserting) {
      context.missing(_albumIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TrackInfo map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return TrackInfo.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $TrackInfosTable createAlias(String alias) {
    return $TrackInfosTable(_db, alias);
  }
}

class UserInfo extends DataClass implements Insertable<UserInfo> {
  final String uid;
  final String email;
  final String name;
  final String imgUrl;
  final String refreshToken;
  UserInfo(
      {@required this.uid,
      this.email,
      this.name,
      this.imgUrl,
      this.refreshToken});
  factory UserInfo.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final stringType = db.typeSystem.forDartType<String>();
    return UserInfo(
      uid: stringType.mapFromDatabaseResponse(data['${effectivePrefix}uid']),
      email:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}email']),
      name: stringType.mapFromDatabaseResponse(data['${effectivePrefix}name']),
      imgUrl:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}img_url']),
      refreshToken: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}refresh_token']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || uid != null) {
      map['uid'] = Variable<String>(uid);
    }
    if (!nullToAbsent || email != null) {
      map['email'] = Variable<String>(email);
    }
    if (!nullToAbsent || name != null) {
      map['name'] = Variable<String>(name);
    }
    if (!nullToAbsent || imgUrl != null) {
      map['img_url'] = Variable<String>(imgUrl);
    }
    if (!nullToAbsent || refreshToken != null) {
      map['refresh_token'] = Variable<String>(refreshToken);
    }
    return map;
  }

  UserInfosCompanion toCompanion(bool nullToAbsent) {
    return UserInfosCompanion(
      uid: uid == null && nullToAbsent ? const Value.absent() : Value(uid),
      email:
          email == null && nullToAbsent ? const Value.absent() : Value(email),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      imgUrl:
          imgUrl == null && nullToAbsent ? const Value.absent() : Value(imgUrl),
      refreshToken: refreshToken == null && nullToAbsent
          ? const Value.absent()
          : Value(refreshToken),
    );
  }

  factory UserInfo.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return UserInfo(
      uid: serializer.fromJson<String>(json['uid']),
      email: serializer.fromJson<String>(json['email']),
      name: serializer.fromJson<String>(json['name']),
      imgUrl: serializer.fromJson<String>(json['imgUrl']),
      refreshToken: serializer.fromJson<String>(json['refreshToken']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'uid': serializer.toJson<String>(uid),
      'email': serializer.toJson<String>(email),
      'name': serializer.toJson<String>(name),
      'imgUrl': serializer.toJson<String>(imgUrl),
      'refreshToken': serializer.toJson<String>(refreshToken),
    };
  }

  UserInfo copyWith(
          {String uid,
          String email,
          String name,
          String imgUrl,
          String refreshToken}) =>
      UserInfo(
        uid: uid ?? this.uid,
        email: email ?? this.email,
        name: name ?? this.name,
        imgUrl: imgUrl ?? this.imgUrl,
        refreshToken: refreshToken ?? this.refreshToken,
      );
  @override
  String toString() {
    return (StringBuffer('UserInfo(')
          ..write('uid: $uid, ')
          ..write('email: $email, ')
          ..write('name: $name, ')
          ..write('imgUrl: $imgUrl, ')
          ..write('refreshToken: $refreshToken')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      uid.hashCode,
      $mrjc(
          email.hashCode,
          $mrjc(
              name.hashCode, $mrjc(imgUrl.hashCode, refreshToken.hashCode)))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is UserInfo &&
          other.uid == this.uid &&
          other.email == this.email &&
          other.name == this.name &&
          other.imgUrl == this.imgUrl &&
          other.refreshToken == this.refreshToken);
}

class UserInfosCompanion extends UpdateCompanion<UserInfo> {
  final Value<String> uid;
  final Value<String> email;
  final Value<String> name;
  final Value<String> imgUrl;
  final Value<String> refreshToken;
  const UserInfosCompanion({
    this.uid = const Value.absent(),
    this.email = const Value.absent(),
    this.name = const Value.absent(),
    this.imgUrl = const Value.absent(),
    this.refreshToken = const Value.absent(),
  });
  UserInfosCompanion.insert({
    @required String uid,
    this.email = const Value.absent(),
    this.name = const Value.absent(),
    this.imgUrl = const Value.absent(),
    this.refreshToken = const Value.absent(),
  }) : uid = Value(uid);
  static Insertable<UserInfo> custom({
    Expression<String> uid,
    Expression<String> email,
    Expression<String> name,
    Expression<String> imgUrl,
    Expression<String> refreshToken,
  }) {
    return RawValuesInsertable({
      if (uid != null) 'uid': uid,
      if (email != null) 'email': email,
      if (name != null) 'name': name,
      if (imgUrl != null) 'img_url': imgUrl,
      if (refreshToken != null) 'refresh_token': refreshToken,
    });
  }

  UserInfosCompanion copyWith(
      {Value<String> uid,
      Value<String> email,
      Value<String> name,
      Value<String> imgUrl,
      Value<String> refreshToken}) {
    return UserInfosCompanion(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      name: name ?? this.name,
      imgUrl: imgUrl ?? this.imgUrl,
      refreshToken: refreshToken ?? this.refreshToken,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (uid.present) {
      map['uid'] = Variable<String>(uid.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (imgUrl.present) {
      map['img_url'] = Variable<String>(imgUrl.value);
    }
    if (refreshToken.present) {
      map['refresh_token'] = Variable<String>(refreshToken.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UserInfosCompanion(')
          ..write('uid: $uid, ')
          ..write('email: $email, ')
          ..write('name: $name, ')
          ..write('imgUrl: $imgUrl, ')
          ..write('refreshToken: $refreshToken')
          ..write(')'))
        .toString();
  }
}

class $UserInfosTable extends UserInfos
    with TableInfo<$UserInfosTable, UserInfo> {
  final GeneratedDatabase _db;
  final String _alias;
  $UserInfosTable(this._db, [this._alias]);
  final VerificationMeta _uidMeta = const VerificationMeta('uid');
  GeneratedTextColumn _uid;
  @override
  GeneratedTextColumn get uid => _uid ??= _constructUid();
  GeneratedTextColumn _constructUid() {
    return GeneratedTextColumn(
      'uid',
      $tableName,
      false,
    );
  }

  final VerificationMeta _emailMeta = const VerificationMeta('email');
  GeneratedTextColumn _email;
  @override
  GeneratedTextColumn get email => _email ??= _constructEmail();
  GeneratedTextColumn _constructEmail() {
    return GeneratedTextColumn(
      'email',
      $tableName,
      true,
    );
  }

  final VerificationMeta _nameMeta = const VerificationMeta('name');
  GeneratedTextColumn _name;
  @override
  GeneratedTextColumn get name => _name ??= _constructName();
  GeneratedTextColumn _constructName() {
    return GeneratedTextColumn(
      'name',
      $tableName,
      true,
    );
  }

  final VerificationMeta _imgUrlMeta = const VerificationMeta('imgUrl');
  GeneratedTextColumn _imgUrl;
  @override
  GeneratedTextColumn get imgUrl => _imgUrl ??= _constructImgUrl();
  GeneratedTextColumn _constructImgUrl() {
    return GeneratedTextColumn(
      'img_url',
      $tableName,
      true,
    );
  }

  final VerificationMeta _refreshTokenMeta =
      const VerificationMeta('refreshToken');
  GeneratedTextColumn _refreshToken;
  @override
  GeneratedTextColumn get refreshToken =>
      _refreshToken ??= _constructRefreshToken();
  GeneratedTextColumn _constructRefreshToken() {
    return GeneratedTextColumn(
      'refresh_token',
      $tableName,
      true,
    );
  }

  @override
  List<GeneratedColumn> get $columns =>
      [uid, email, name, imgUrl, refreshToken];
  @override
  $UserInfosTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'user_infos';
  @override
  final String actualTableName = 'user_infos';
  @override
  VerificationContext validateIntegrity(Insertable<UserInfo> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('uid')) {
      context.handle(
          _uidMeta, uid.isAcceptableOrUnknown(data['uid'], _uidMeta));
    } else if (isInserting) {
      context.missing(_uidMeta);
    }
    if (data.containsKey('email')) {
      context.handle(
          _emailMeta, email.isAcceptableOrUnknown(data['email'], _emailMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name'], _nameMeta));
    }
    if (data.containsKey('img_url')) {
      context.handle(_imgUrlMeta,
          imgUrl.isAcceptableOrUnknown(data['img_url'], _imgUrlMeta));
    }
    if (data.containsKey('refresh_token')) {
      context.handle(
          _refreshTokenMeta,
          refreshToken.isAcceptableOrUnknown(
              data['refresh_token'], _refreshTokenMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {uid};
  @override
  UserInfo map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return UserInfo.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $UserInfosTable createAlias(String alias) {
    return $UserInfosTable(_db, alias);
  }
}

abstract class _$LyricsGuruDB extends GeneratedDatabase {
  _$LyricsGuruDB(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  _$LyricsGuruDB.connect(DatabaseConnection c) : super.connect(c);
  $ArtistInfosTable _artistInfos;
  $ArtistInfosTable get artistInfos => _artistInfos ??= $ArtistInfosTable(this);
  $AlbumInfosTable _albumInfos;
  $AlbumInfosTable get albumInfos => _albumInfos ??= $AlbumInfosTable(this);
  $TrackInfosTable _trackInfos;
  $TrackInfosTable get trackInfos => _trackInfos ??= $TrackInfosTable(this);
  $UserInfosTable _userInfos;
  $UserInfosTable get userInfos => _userInfos ??= $UserInfosTable(this);
  ArtistInfoDao _artistInfoDao;
  ArtistInfoDao get artistInfoDao =>
      _artistInfoDao ??= ArtistInfoDao(this as LyricsGuruDB);
  AlbumInfoDao _albumInfoDao;
  AlbumInfoDao get albumInfoDao =>
      _albumInfoDao ??= AlbumInfoDao(this as LyricsGuruDB);
  TrackInfoDao _trackInfoDao;
  TrackInfoDao get trackInfoDao =>
      _trackInfoDao ??= TrackInfoDao(this as LyricsGuruDB);
  UserInfoDao _userInfoDao;
  UserInfoDao get userInfoDao =>
      _userInfoDao ??= UserInfoDao(this as LyricsGuruDB);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [artistInfos, albumInfos, trackInfos, userInfos];
}

// **************************************************************************
// DaoGenerator
// **************************************************************************

mixin _$ArtistInfoDaoMixin on DatabaseAccessor<LyricsGuruDB> {
  $ArtistInfosTable get artistInfos => attachedDatabase.artistInfos;
}
mixin _$AlbumInfoDaoMixin on DatabaseAccessor<LyricsGuruDB> {
  $AlbumInfosTable get albumInfos => attachedDatabase.albumInfos;
}
mixin _$TrackInfoDaoMixin on DatabaseAccessor<LyricsGuruDB> {
  $TrackInfosTable get trackInfos => attachedDatabase.trackInfos;
}
mixin _$UserInfoDaoMixin on DatabaseAccessor<LyricsGuruDB> {
  $UserInfosTable get userInfos => attachedDatabase.userInfos;
}
