import 'package:flutter/material.dart';

import '../../ui/widgets/custom_flat_button.dart';

class SocialSignInButton extends CustomFlatButton {
  SocialSignInButton({
    Key key,
    String assetName,
    String text,
    Color color,
    Color textColor,
    VoidCallback onTap,
  }) : super(
          key: key,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Image.asset(assetName, height: 30),
              Text(
                text,
                style: TextStyle(color: textColor, fontSize: 15.0),
              ),
              Opacity(
                opacity: 0.0,
                child: Image.asset(assetName, height: 30),
              ),
            ],
          ),
          color: color,
          onTap: onTap,
        );
}

class SignInButton extends CustomFlatButton {
  SignInButton({
    Key key,
    @required String text,
    @required Color color,
    @required VoidCallback onTap,
    Color textColor = Colors.black87,
    double height = 50.0,
  }) : super(
          key: key,
          child: Text(text, style: TextStyle(color: textColor, fontSize: 15.0)),
          color: color,
          textColor: textColor,
          height: height,
          onTap: onTap,
        );
}
