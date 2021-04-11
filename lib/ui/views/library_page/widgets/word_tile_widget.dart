import 'package:flutter/material.dart';

import '../../../../logic/models/word.dart';
import '../../../widgets/progress_widget.dart';

class WordTileWidget extends StatelessWidget {
  final Word word;

  const WordTileWidget({Key key, this.word}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: ListTile(
        title: Text(
          word.word,
          style: TextStyle(color: Colors.black, fontSize: 16),
        ),
        trailing: ProgressWidget(
          progress: word.word.length / 10 <= 1.0 ? word.word.length / 10 : 1.0,
          width: 40.0,
        ),
      ),
    );
  }
}
