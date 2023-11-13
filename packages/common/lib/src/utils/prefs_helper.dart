import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../common.dart';

/// 本地存储帮助类，全部为空安全
class PrefsHelper {
  PrefsHelper._();

  static late SharedPreferences _prefs;

  static SharedPreferences get prefs => _prefs;

  static bool containsKey(String key) {
    return _prefs.containsKey(key);
  }

  static Future<bool> remove(String key) {
    return _prefs.remove(key);
  }

  static Future<bool> init() async {
    _prefs = await SharedPreferences.getInstance();
    return true;
  }

  static int getInt(String key, [int defaultValue = 0]) {
    return TypeUtil.parseInt(_prefs.get(key), defaultValue);
  }

  static Future<bool> setInt(String key, int value) {
    return _prefs.setInt(key, value);
  }

  static double getDouble(String key, [double defaultValue = 0]) {
    return TypeUtil.parseDouble(_prefs.get(key), defaultValue);
  }

  static Future<bool> setDouble(String key, double value) {
    return _prefs.setDouble(key, value);
  }

  static bool getBool(String key, [bool defaultValue = false]) {
    return TypeUtil.parseBool(_prefs.get(key), defaultValue);
  }

  static Future<bool> setBool(String key, bool value) {
    return _prefs.setBool(key, value);
  }

  static String getString(String key, [String defaultValue = '']) {
    return TypeUtil.parseString(_prefs.get(key), defaultValue);
  }

  static Future<bool> setString(String key, String value) {
    return _prefs.setString(key, value);
  }

  static List<String> getStringList(String key) {
    return TypeUtil.parseStringList(_prefs.get(key));
  }

  static Future<bool> setStringList(String key, List<String> value) {
    return _prefs.setStringList(key, value);
  }

  static List<T> getList<T>(String key, T Function(String s) fn) {
    return getStringList(key).map((e) => fn(e)).toList();
  }

  static Future<bool> setList<T>(String key, List<T> value,
      [String Function(T e) fn = TypeUtil.parseString]) {
    if (value is List<String>) return setStringList(key, value as List<String>);
    return _prefs.setStringList(key, value.map(fn).toList());
  }

  static Map<String, dynamic> getMap(String key) {
    return TypeUtil.parseMap(getString(key, ''));
  }

  static Future<bool> setMap(String key, Map<String, dynamic> value) {
    return _prefs.setString(key, jsonEncode(value));
  }

  /// 根据泛型自动获取值，只支持int、double、bool、String、List<String>、Map<String, dynamic>
  static T getValue<T>(String key, T defaultValue) {
    assert(defaultValue != null);
    assert(T == defaultValue.runtimeType,
        'type error: $T, ${defaultValue.runtimeType}');
    if (T == int) {
      return getInt(key, defaultValue as int) as T;
    } else if (T == double) {
      return getDouble(key, defaultValue as double) as T;
    } else if (T == bool) {
      return getBool(key, defaultValue as bool) as T;
    } else if (T == String) {
      return getString(key, defaultValue as String) as T;
    } else if (T == List<String>) {
      return getStringList(key) as T;
    } else if (T == Map<String, dynamic>) {
      return getMap(key) as T;
    } else {
      throw Exception('not support type: $T');
    }
  }

  /// 根据泛型自动设置值，只支持int、double、bool、String、List<String>、Map<String, dynamic>
  static Future<bool> setValue<T>(String key, T value) async {
    assert(value != null);
    assert(T == value.runtimeType, 'type error: $T, ${value.runtimeType}');
    if (T == int) {
      return setInt(key, value as int);
    } else if (T == double) {
      return setDouble(key, value as double);
    } else if (T == bool) {
      return setBool(key, value as bool);
    } else if (T == String) {
      return setString(key, value as String);
    } else if (T == List<String>) {
      return setStringList(key, value as List<String>);
    } else if (T == Map<String, dynamic>) {
      return setMap(key, value as Map<String, dynamic>);
    } else {
      throw Exception('not support type: $T');
    }
  }
}

/// 本地存储值，支持泛型，只支持int、double、bool、String、List<String>、Map<String, dynamic>
/// 可以通过PrefsValue.by来支持自定义类型，但是需要同时提供decode和encode
class PrefsValue<T> {
  PrefsValue(this.key, T defaultValue)
      : assert(key.isNotEmpty),
        assert(defaultValue != null),
        _encode = null,
        _value = PrefsHelper.getValue(key, defaultValue);

  PrefsValue.by(
    this.key, {
    required T Function(String value) decode,
    required String Function(T value) encode,
  })  : assert(key.isNotEmpty),
        _encode = encode,
        _value = _safeDecode(decode, key);

  final String key;
  T _value;
  final String Function(T value)? _encode;

  T get value => _value;

  set value(T newValue) {
    if (DynamicUtil.equal(value, newValue)) {
      return;
    }
    _value = newValue;
    if (_encode != null) {
      PrefsHelper.setString(key, _encode!.call(newValue));
    } else {
      PrefsHelper.setValue<T>(key, newValue);
    }
  }

  static T _safeDecode<T>(T Function(String value) decode, String key) {
    try {
      final v = decode.call(PrefsHelper.getString(key));
      return v;
    } catch (e) {
      FlutterError.reportError(FlutterErrorDetails(
        exception: e,
        stack: StackTrace.current,
        library: 'common',
        context: ErrorDescription(
            'while decode $key, Type: $T, value: ${PrefsHelper.getString(key)}'),
      ));
      // 删除掉错误的值
      PrefsHelper.remove(key);
      return decode.call(PrefsHelper.getString(key));
    }
  }
}

/// 本地存储的ValueNotifier，用于监听本地存储的变化
class PrefsValueNotifier<T> extends SafeValueNotifier<T> {
  PrefsValueNotifier(this.key, T defaultValue)
      : _encode = null, super(PrefsHelper.getValue(key, defaultValue));

  PrefsValueNotifier.by(
    this.key, {
    required T Function(String value) decode,
    required String Function(T value) encode,
  })  : _encode = encode,
        super(PrefsValue._safeDecode(decode, key));

  final String key;
  final String Function(T value)? _encode;

  @override
  set value(T newValue) {
    if (DynamicUtil.equal(value, newValue)) {
      return;
    }
    super.value = newValue;
    if (_encode != null) {
      PrefsHelper.setString(key, _encode!.call(newValue));
    } else {
      PrefsHelper.setValue<T>(key, newValue);
    }
  }
}
