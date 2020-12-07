part of '../moor_database.dart';

class UserInfos extends Table {
  TextColumn get uid => text()();
  TextColumn get email => text().nullable()();
  TextColumn get name => text().nullable()();
  TextColumn get imgUrl => text().nullable()();
  TextColumn get refreshToken => text().nullable()();

  Set<Column> get primaryKey => {uid};
}

extension UserInfoExtension on UserInfo {
  UserData get asUserData => UserData(
        uid: uid,
        email: email,
        name: name,
        imgUrl: imgUrl,
        refreshToken: refreshToken,
      );
}

extension UserExtension on UserData {
  UserInfosCompanion get asUserInfo => UserInfosCompanion(
        uid: uid != null ? Value(uid) : Value.absent(),
        email: email != null ? Value(email) : Value.absent(),
        name: name != null ? Value(name) : Value.absent(),
        imgUrl: imgUrl != null ? Value(imgUrl) : Value.absent(),
        refreshToken:
            refreshToken != null ? Value(refreshToken) : Value.absent(),
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

  Future saveUserData(UserData user) =>
      into(userInfos).insertOnConflictUpdate(user.asUserInfo);

  Future deleteUserInfo(UserData user) =>
      delete(userInfos).delete(user.asUserInfo);
}
