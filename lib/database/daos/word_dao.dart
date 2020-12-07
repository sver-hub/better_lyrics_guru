part of '../moor_database.dart';

class WordInfos extends Table {
  TextColumn get word => text()();
  TextColumn get definition => text().nullable()();
  IntColumn get progress => integer()();

  Set<Column> get primaryKey => {word};
}

class WordTrackRefs extends Table {
  TextColumn get word => text()();
  TextColumn get trackId => text()();

  Set<Column> get primaryKey => {word, trackId};
}

extension WordInfoExtension on WordInfo {
  Word asWord(List<String> refTrackIds) => Word(
        word: word,
        definition: definition,
        progress: progress / 100,
        refTrackIds: refTrackIds,
      );
}

extension WordExtension on Word {
  WordInfosCompanion get asWordInfo => WordInfosCompanion(
        word: word != null ? Value(word) : Value.absent(),
        definition: definition != null ? Value(definition) : Value.absent(),
        progress:
            progress != null ? Value((progress * 100).toInt()) : Value.absent(),
      );
}

@UseDao(tables: [WordInfos, WordTrackRefs])
class WordDao extends DatabaseAccessor<LyricsGuruDB> with _$WordDaoMixin {
  final LyricsGuruDB db;

  WordDao(this.db) : super(db);

  WordTrackRefsCompanion _asWordTrackRef(String word, String trackId) =>
      WordTrackRefsCompanion(word: Value(word), trackId: Value(trackId));

  Future saveWordInfo(Word word) => transaction(() async {
        await into(wordInfos).insertOnConflictUpdate(word.asWordInfo);
        for (String ref in word.refTrackIds) {
          await into(wordTrackRefs).insertOnConflictUpdate(
            _asWordTrackRef(word.word, ref),
          );
        }
      });

  Future deleteWordInfo(Word word) => transaction(() async {
        await delete(wordInfos).delete(word.asWordInfo);
        for (String ref in word.refTrackIds) {
          await delete(wordTrackRefs).delete(
            _asWordTrackRef(word.word, ref),
          );
        }
      });
}
