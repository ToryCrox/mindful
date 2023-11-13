import 'package:common/common.dart';
import 'package:mobx/mobx.dart';

import '../model/user_info.dart';
import '../utils/observable_prefs_value.dart';

part 'user_store.g.dart';

class UserStore = UserStoreBase with _$UserStore;

abstract class UserStoreBase with Store {
  final _userPrefs = ObservablePrefsValue<UserInfo>.by(
    'user_info',
    encode: (value) => TypeUtil.parseString(value.toJson()),
    decode: (value) => UserInfo.fromJson(TypeUtil.parseMap(value)),
  );

  @computed
  int get uid => _userPrefs.value.uid;

  @computed
  String get nickname => _userPrefs.value.nickname;

  @computed
  bool get isLogin => _userPrefs.value.token.isNotEmpty;
}
