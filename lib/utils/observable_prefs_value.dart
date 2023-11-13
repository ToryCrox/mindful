import 'package:common/common.dart';
import 'package:mobx/mobx.dart';

/// 自定义mobx观察者，并且可以存储到shared_preferences
/// 定义的观察对象不要使用@observable
class ObservablePrefsValue<T> extends PrefsValue<T> {

  /// 通过key和默认值构造, 只支持基本类型
  ObservablePrefsValue(super.key, super.defaultValue);

  /// 用来支持自定义类型，需要传入解码和编码函数
  ObservablePrefsValue.by(
    String key, {
    required T Function(String value) decode,
    required String Function(T value) encode,
  }) : super.by(key, decode: decode, encode: encode);


  late final _$atom = Atom(name: '_$key.token', context: mainContext);

  @override
  set value(T newValue) {
    _$atom.reportWrite(newValue, super.value, () {
      super.value = newValue;
    });
  }

  @override
  T get value {
    _$atom.reportRead();
    return super.value;
  }

}
