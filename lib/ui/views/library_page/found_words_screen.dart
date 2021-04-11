import 'package:flutter/material.dart';

import '../../../logic/models/word.dart';
import '../../widgets/return_widget.dart';
import 'widgets/word_tile_widget.dart';

class FoundWordsScreen extends StatelessWidget {
  final String trackName;
  final String artistName;
  final List<Word> words;

  const FoundWordsScreen({Key key, this.trackName, this.artistName, this.words})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          ReturnWidget(title: 'Go back'),
          _buildName(),
          const Divider(),
          ...[
            for (Word word
                in words
                  ..sort((word, other) => word.word.compareTo(other.word)))
              WordTileWidget(word: word),
          ]
        ],
      ),
    );
  }

  Widget _buildName() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: SizedBox(
            width: double.infinity,
            child: Text(
              trackName,
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.8,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(30, 10, 20, 0),
          child: SizedBox(
            width: double.infinity,
            child: Text(
              'By ' + artistName,
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 17,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
