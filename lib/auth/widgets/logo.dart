import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  const Logo({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 80),
      child: Material(
          elevation: 8.0,
          shape: CircleBorder(),
          child: CircleAvatar(
            backgroundColor: Colors.white,
            child: Container(
              child: Image.asset('assets/icon/logo.png'),
              padding: const EdgeInsets.all(15),
            ),
            radius: 50.0,
          )),
    );
  }
}
