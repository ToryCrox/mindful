
import '../../common.dart';

/// map扩展
extension ExtendedMap on Map<dynamic, dynamic> {

  /// 获取int类型的值
  /// 如果key不存在，则返回默认值
  int optInt(String key, [int defaultValue = 0]) {
    return TypeUtil.parseInt(this[key], defaultValue);
  }

  /// 获取double类型的值
  /// 如果key不存在，则返回默认值
  double optDouble(String key, [double defaultValue = 0]) {
    return TypeUtil.parseDouble(this[key], defaultValue);
  }

  /// 获取bool类型的值
  bool optBool(String key, [bool  defaultValue = false]) {
    return TypeUtil.parseBool(this[key], defaultValue);
  }

  /// 获取String类型的值
  String optString(String key, [String  defaultValue = '']) {
    return TypeUtil.parseString(this[key], defaultValue);
  }

  /// 获取List类型的值
  List<T> optList<T>(String key, T Function(dynamic e) f) {
    return TypeUtil.parseList(this[key], f);
  }

  /// 获取List类型的值
  List<int> optIntList(String key) {
    return optList(key, (e) => TypeUtil.parseInt(key));
  }

  /// 获取List类型的值
  List<String> getStringList(String key) {
    return optList(key, (e) => TypeUtil.parseString(key));
  }

  /// 获取Map类型的值
  Map<String, dynamic> optMap(String key) {
    return TypeUtil.parseMap(this[key]);
  }
}
