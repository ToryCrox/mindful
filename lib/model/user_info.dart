

import 'package:common/common.dart';

class UserInfo {
  final int uid;
  final String nickname;
  final String avatar;
  final String token;

  const UserInfo({
    required this.uid,
    required this.nickname,
    required this.avatar,
    required this.token,
  });

  UserInfo copyWith({
    int? uid,
    String? nickname,
    String? avatar,
    String? token,
  }) {
    return UserInfo(
      uid: uid ?? this.uid,
      nickname: nickname ?? this.nickname,
      avatar: avatar ?? this.avatar,
      token: token ?? this.token,
    );
  }

  factory UserInfo.fromMap(Map<String, dynamic> map) {
    return UserInfo(
      uid: TypeUtil.parseInt(map['uid']),
      nickname: TypeUtil.parseString(map['nickname']),
      avatar: TypeUtil.parseString(map['avatar']),
      token: TypeUtil.parseString(map['token']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'nickname': nickname,
      'avatar': avatar,
      'token': token,
    };
  }

  factory UserInfo.fromJson(Map<String, dynamic> json) =>
      UserInfo.fromMap(json);

  Map<String, dynamic> toJson() => toMap();

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserInfo &&
          runtimeType == other.runtimeType &&
          uid == other.uid &&
          nickname == other.nickname &&
          avatar == other.avatar &&
          token == other.token);

  @override
  int get hashCode =>
      uid.hashCode ^ nickname.hashCode ^ avatar.hashCode ^ token.hashCode;

  @override
  String toString() {
    return 'UserInfo${TypeUtil.parseString(toMap())}';
  }
}