import 'package:flutter/material.dart';

import '../theme/palette.dart';

class ProgressWidget extends StatelessWidget {
  final double progress;
  final double width;

  const ProgressWidget({Key key, this.progress = 0.5, this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 4.0,
      width: width,
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2.0),
              color: Colors.white,
              border: Border.all(color: Color(0xFFAAAAAA), width: 0.2),
              boxShadow: [
                BoxShadow(
                  blurRadius: 4.0,
                  offset: Offset(0, 1),
                  color: Colors.black.withOpacity(0.1),
                ),
              ],
            ),
          ),
          SizedBox(
            width: width,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(2.0),
              child: FractionallySizedBox(
                alignment: Alignment.topLeft,
                widthFactor: progress,
                heightFactor: 1,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    border: Border.all(color: Palette.green, width: 0.2),
                  ),
                  child: ColoredBox(color: Palette.green),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
