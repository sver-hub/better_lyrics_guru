import 'package:flutter/foundation.dart';
import 'package:moor/moor.dart';

import '../../database/moor_database.dart';

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

  UserInfosCompanion get asUserInfo => UserInfosCompanion(
        uid: uid != null ? Value(uid) : Value.absent(),
        email: email != null ? Value(email) : Value.absent(),
        name: name != null ? Value(name) : Value.absent(),
        imgUrl: imgUrl != null ? Value(imgUrl) : Value.absent(),
        refreshToken:
            refreshToken != null ? Value(refreshToken) : Value.absent(),
      );

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
