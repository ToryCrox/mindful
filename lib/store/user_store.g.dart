// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$UserStore on UserStoreBase, Store {
  Computed<int>? _$uidComputed;

  @override
  int get uid => (_$uidComputed ??=
          Computed<int>(() => super.uid, name: 'UserStoreBase.uid'))
      .value;
  Computed<String>? _$nicknameComputed;

  @override
  String get nickname =>
      (_$nicknameComputed ??= Computed<String>(() => super.nickname,
              name: 'UserStoreBase.nickname'))
          .value;
  Computed<bool>? _$isLoginComputed;

  @override
  bool get isLogin => (_$isLoginComputed ??=
          Computed<bool>(() => super.isLogin, name: 'UserStoreBase.isLogin'))
      .value;

  @override
  String toString() {
    return '''
uid: ${uid},
nickname: ${nickname},
isLogin: ${isLogin}
    ''';
  }
}
