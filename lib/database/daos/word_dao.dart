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

  Future<Word> getWord(String word) async {
    final wordQuery = select(wordInfos)..where((w) => w.word.equals(word));
    final res = await wordQuery.getSingle();
    if (res == null) return null;

    final refQuery = select(wordTrackRefs)
      ..where((wtr) => wtr.word.equals(word));
    final trackIds = (await refQuery.get()).map((ref) => ref.trackId).toList();
    return res.asWord(trackIds);
  }

  Future<List<Word>> getWordsOfTrack(Track track) async {
    final wordsQuery = select(wordTrackRefs)
      ..where((wtr) => wtr.trackId.equals(track.id));
    final words = (await wordsQuery.get()).map((ref) => ref.word);
    return [for (final word in words) await getWord(word)];
  }

  Future addTrackRefs(Word word, List<Track> tracks) async {
    final wordDb = await getWord(word.word);
    if (wordDb == null) throw Exception('No such word in db');

    final trackIds = tracks.map((track) => track.id);
    return transaction(() async {
      for (final trackId in trackIds) {
        await into(wordTrackRefs).insertOnConflictUpdate(
          _asWordTrackRef(word.word, trackId),
        );
      }
    });
  }

  Future saveWord(Word word) => transaction(() async {
        await into(wordInfos).insertOnConflictUpdate(word.asWordInfo);
        for (String trackId in word.refTrackIds) {
          await into(wordTrackRefs).insertOnConflictUpdate(
            _asWordTrackRef(word.word, trackId),
          );
        }
      });

  Future deleteWord(Word word) => transaction(() async {
        await delete(wordInfos).delete(word.asWordInfo);
        for (String trackId in word.refTrackIds) {
          await delete(wordTrackRefs).delete(
            _asWordTrackRef(word.word, trackId),
          );
        }
      });

  WordTrackRefsCompanion _asWordTrackRef(String word, String trackId) =>
      WordTrackRefsCompanion(word: Value(word), trackId: Value(trackId));
}
