// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_with_password_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$LoginWithPasswordStore on LoginWithPasswordStoreBase, Store {
  Computed<bool>? _$isLoginEnableComputed;

  @override
  bool get isLoginEnable =>
      (_$isLoginEnableComputed ??= Computed<bool>(() => super.isLoginEnable,
              name: 'LoginWithPasswordStoreBase.isLoginEnable'))
          .value;

  late final _$_phoneNumberAtom =
      Atom(name: 'LoginWithPasswordStoreBase._phoneNumber', context: context);

  String get phoneNumber {
    _$_phoneNumberAtom.reportRead();
    return super._phoneNumber;
  }

  @override
  String get _phoneNumber => phoneNumber;

  @override
  set _phoneNumber(String value) {
    _$_phoneNumberAtom.reportWrite(value, super._phoneNumber, () {
      super._phoneNumber = value;
    });
  }

  late final _$_passwordAtom =
      Atom(name: 'LoginWithPasswordStoreBase._password', context: context);

  String get password {
    _$_passwordAtom.reportRead();
    return super._password;
  }

  @override
  String get _password => password;

  @override
  set _password(String value) {
    _$_passwordAtom.reportWrite(value, super._password, () {
      super._password = value;
    });
  }

  late final _$loginAsyncAction =
      AsyncAction('LoginWithPasswordStoreBase.login', context: context);

  @override
  Future<bool> login() {
    return _$loginAsyncAction.run(() => super.login());
  }

  late final _$LoginWithPasswordStoreBaseActionController =
      ActionController(name: 'LoginWithPasswordStoreBase', context: context);

  @override
  void setPhoneNumber(String phoneNumber) {
    final _$actionInfo = _$LoginWithPasswordStoreBaseActionController
        .startAction(name: 'LoginWithPasswordStoreBase.setPhoneNumber');
    try {
      return super.setPhoneNumber(phoneNumber);
    } finally {
      _$LoginWithPasswordStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setPassword(String password) {
    final _$actionInfo = _$LoginWithPasswordStoreBaseActionController
        .startAction(name: 'LoginWithPasswordStoreBase.setPassword');
    try {
      return super.setPassword(password);
    } finally {
      _$LoginWithPasswordStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isLoginEnable: ${isLoginEnable}
    ''';
  }
}
