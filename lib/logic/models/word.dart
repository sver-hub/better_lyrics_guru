import 'package:flutter/material.dart';
import 'package:moor/moor.dart';

class Word {
  final String word;
  final String definition;
  final double progress;
  final List<String> refTrackIds;

  Word({
    @required this.word,
    @required this.definition,
    @required this.progress,
    @required this.refTrackIds,
  });
}
