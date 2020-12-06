import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  const Logo({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 80),
      child: Material(
          elevation: 8.0,
          shape: CircleBorder(),
          child: CircleAvatar(
            backgroundColor: Colors.white,
            child: FlutterLogo(
              size: 50.0,
            ),
            radius: 50.0,
          )),
    );
  }
}
