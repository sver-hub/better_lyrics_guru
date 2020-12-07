import 'package:flutter/foundation.dart';

class UserData {
  final uid;
  final email;
  final name;
  final imgUrl;
  final refreshToken;

  const UserData({
    @required this.uid,
    this.email,
    this.name,
    this.imgUrl,
    this.refreshToken,
  });

  UserData copyWith(
          {String uid,
          String email,
          String name,
          String imgUrl,
          String refreshToken}) =>
      UserData(
        uid: uid ?? this.uid,
        email: email ?? this.email,
        name: name ?? this.name,
        imgUrl: imgUrl ?? this.imgUrl,
        refreshToken: refreshToken ?? this.refreshToken,
      );
}
