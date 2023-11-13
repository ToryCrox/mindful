
import 'dart:ui';

import '../utils/type_util.dart';

/// String的扩展，String是可空的
extension StringExtension on String? {
  /// 是否为空
  bool get isNullOrEmpty => this == null || this!.isEmpty;

  /// 是否不为空
  bool get isNotNullOrEmpty => !isNullOrEmpty;

  /// 是否为空白
  bool get isNullOrBlank => this == null || this!.trim().isEmpty;

  /// 是否不为空白
  bool get isNotNullOrBlank => !isNullOrBlank;

  /// 是否为数字
  bool get isNumber =>
      isNotNullOrEmpty && RegExp(r'^-?\d+\.?\d*$').hasMatch(this!);

  /// 是否为整数
  bool get isInt => isNotNullOrEmpty && RegExp(r'^-?\d+$').hasMatch(this!);

  /// 是否为浮点数
  bool get isDouble => isNotNullOrEmpty && RegExp(r'^-?\d+\.\d+$').hasMatch(this!);

  /// 是否是Url
  bool get isUrl => isNotNullOrEmpty && RegExp(r'^https?://').hasMatch(this!);


  /// 转换成int
  /// 如果value是bool，则true转换成1， false为0
  int get toInt => TypeUtil.parseInt(this);

  /// 解析bool类型
  /// - 如果为bool类型，则直接返回
  /// - 如果为num类型，则为0表示false，否则为true
  /// - 如果为String类型，则'true'表示true，否则转换Int类型， 判断是否为0
  bool get toBool => TypeUtil.parseBool(this);

  /// 转换成double
  /// 如果value是bool，则true转换成1.0， false为0.0
  /// 如果value是String，则转换成double
  /// 如果value是int，则转换成double
  /// 如果value是double，则直接返回
  /// 如果value是其他类型，则返回0.0
  double get toDouble => TypeUtil.parseDouble(this);

  /// 转换成Map
  /// 如果value是Map，则直接返回
  /// 如果value是List，则转换成Map
  /// 如果value是Set，则转换成Map
  /// 如果value是其他类型，则返回空Map
  Map<String, dynamic> get toMap => TypeUtil.parseMap(this);

  /// 转换成Color
  /// 如果value是Color，则直接返回
  /// 如果value是String，则转换成Color
  Color get toColor => TypeUtil.parseColor(this);
}