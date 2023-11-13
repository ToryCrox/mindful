
import 'package:common/common.dart';
import 'package:mobx/mobx.dart';

import '../../utils/observable_prefs_value.dart';

part 'login_with_password_store.g.dart';

class  LoginWithPasswordStore = LoginWithPasswordStoreBase with _$LoginWithPasswordStore;

abstract class LoginWithPasswordStoreBase with Store {

  final _cachePhoneNumber =
  ObservablePrefsValue<String>('cache_login_phone_number', '');

  @readonly
  String _phoneNumber = '';

  LoginWithPasswordStoreBase() {
    _phoneNumber = _cachePhoneNumber.value;
  }

  @action
  void setPhoneNumber(String phoneNumber) {
    _phoneNumber = phoneNumber;
  }

  @readonly
  String _password = '';

  @action
  void setPassword(String password) {
    _password = password;
  }

  @computed
  bool get isLoginEnable => TextUtil.isMobile(_phoneNumber) && _password.length >= 6;

  @action
  Future<bool> login() async {
    _cachePhoneNumber.value = _phoneNumber;
    await Future.delayed(const Duration(seconds: 2));
    return true;
  }
}