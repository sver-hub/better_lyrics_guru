import 'package:flutter/material.dart';

class Word {
  final String word;
  final String definition;
  final double progress;
  final List<String> refTrackIds;

  Word({
    @required this.word,
    this.definition,
    this.progress = 0,
    this.refTrackIds = const [],
  });

  Word copyWith({
    String word,
    String definition,
    double progress,
    List<String> refTrackIds,
  }) =>
      Word(
        word: word ?? this.word,
        definition: definition ?? this.definition,
        progress: progress ?? this.progress,
        refTrackIds: refTrackIds ?? this.refTrackIds,
      );

  @override
  bool operator ==(other) => other is Word && other.word == word;

  @override
  int get hashCode => word.hashCode;
}
