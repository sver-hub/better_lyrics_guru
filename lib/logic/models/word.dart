import 'package:flutter/material.dart';

class Word {
  final String word;
  final String definition;
  final double progress;
  final List<String> refTrackIds;

  Word({
    @required this.word,
    @required this.definition,
    this.progress = 0,
    this.refTrackIds = const [],
  });

  @override
  bool operator ==(other) => other is Word && other.word == word;

  @override
  int get hashCode => word.hashCode;
}
