part of '../moor_database.dart';

class UserInfos extends Table {
  TextColumn get uid => text()();
  TextColumn get email => text().nullable()();
  TextColumn get name => text().nullable()();
  TextColumn get imgUrl => text().nullable()();
  TextColumn get refreshToken => text().nullable()();

  Set<Column> get primaryKey => {uid};
}

extension UserExtension on UserInfo {
  UserData get asUserData => UserData(
        uid: uid,
        email: email,
        name: name,
        imgUrl: imgUrl,
        refreshToken: refreshToken,
      );
}

@UseDao(tables: [UserInfos])
class UserInfoDao extends DatabaseAccessor<LyricsGuruDB>
    with _$UserInfoDaoMixin {
  final LyricsGuruDB db;

  UserInfoDao(this.db) : super(db);

  Future<UserData> getUser(String uid) async {
    final query = select(userInfos)..where((u) => u.uid.equals(uid));

    final user = await query.getSingle();
    return user != null ? user.asUserData : null;
  }

  Future insertUserInfo(Insertable<UserInfo> userInfo) =>
      into(userInfos).insert(userInfo);

  Future updateUserInfo(Insertable<UserInfo> userInfo) =>
      update(userInfos).replace(userInfo);

  Future deleteUserInfo(Insertable<UserInfo> userInfo) =>
      delete(userInfos).delete(userInfo);
}
