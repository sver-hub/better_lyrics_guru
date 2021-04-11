import 'package:lemmatizer/lemmatizer.dart';

import '../../database/db.dart';
import '../../database/moor_database.dart';
import '../../logic/models/track.dart';
import '../../logic/models/word.dart';
import 'words_service.dart';

extension on String {
  String capitalize() =>
      '${this[0].toUpperCase()}${this.substring(1).toLowerCase()}';
}

class WordsServiceImplementation extends WordsService {
  static final wordPattern = RegExp(r"[A-Za-z']+");
  static final filterWords =
      'i he she it we you they the a an at to of and but do did have has had that then would '
              'your me my mine his her its their our us them will out can cant so this not very these those '
              'is are am shall oh what in by be for been all there what where when why how just '
              'on was or as up if with like too from no yeah hi get yes'
          .split(' ');

  final _lemmatizer = Lemmatizer();
  final _wordDao = db<WordDao>();

  @override
  Future<List<Word>> analyseLyrics(Track track) async {
    if (track.lyrics == null) return null;

    final uniques = _normalizeAndGetUniques(track.lyrics);
    final words = [for (final word in uniques) await _addToDb(word, track)];
    //TODO: add definition
    return words;
  }

  List<String> _normalizeAndGetUniques(String lyrics) {
    final words = Set<String>.from(
        wordPattern.allMatches(lyrics).map((e) => e.group(0).toLowerCase()));
    final filtered = Set<String>();
    for (var word in words) {
      if (WordsService.CONTRACTIONS.containsKey(word)) {
        final subs = WordsService.CONTRACTIONS[word].split(' ');
        for (var sub in subs) {
          sub = sub.trim();
          if (!filterWords.contains(sub)) filtered.add(_lemmatizer.lemma(sub));
        }
      } else {
        word = word.replaceAll('\'', '');
        if (!filterWords.contains(word)) {
          try {
            filtered.add(_lemmatizer.lemma(word));
          } catch (e) {}
        }
      }
    }
    return filtered.map((e) => e.capitalize()).toList();
  }

  Future<Word> _addToDb(String w, Track track) async {
    final word = Word(word: w);
    final inDb = await _wordDao.getWord(word.word);
    if (inDb == null) {
      await _wordDao.saveWord(word);
      return word.copyWith(refTrackIds: [track.id]);
    } else {
      await _wordDao.addTrackRefs(word, [track]);
      return inDb.copyWith(refTrackIds: [...inDb.refTrackIds, track.id]);
    }
  }
}
