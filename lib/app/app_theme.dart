import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppThemes {
  static const AppColor lightColor = AppColor(
    brightness: Brightness.light,
    primary: Colors.blue,
  );

  static const AppColor darkColor = AppColor(
    brightness: Brightness.dark,
    primary: Colors.blue,
  );
}

/// 颜色列表
class AppColor {
  final Brightness brightness;

  /// 主色调
  final Color primary;



  const AppColor(
      {
        required this.brightness,
        required this.primary,
      });

  /// System overlays should be drawn with a dark color. Intended for
  /// applications with a light background.
  SystemUiOverlayStyle get systemUiOverlayStyle => SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.transparent,
    systemNavigationBarIconBrightness: brightness == Brightness.light ? Brightness.dark : Brightness.light,
    statusBarIconBrightness: brightness == Brightness.light ? Brightness.dark : Brightness.light,
    statusBarColor: Colors.transparent,
    statusBarBrightness: brightness,
  );

  static AppColor lerp(AppColor color, AppColor color2, double t) {
    return AppColor(
      brightness: t < 0.5 ? color.brightness : color2.brightness,
      primary: Color.lerp(color.primary, color2.primary, t)!,
    );
  }

  static List<Color> lerpColors(
      List<Color> list1, List<Color> list2, double t) {
    return List.generate(list1.length, (index) {
      return Color.lerp(list1[index], list2[index], t)!;
    });
  }
}

class AppTheme extends ThemeExtension<AppTheme> {
  final AppColor color;

  AppTheme({
    required this.color,
  });

  @override
  ThemeExtension<AppTheme> copyWith() {
    return AppTheme(
      color: color,
    );
  }

  @override
  ThemeExtension<AppTheme> lerp(
      covariant ThemeExtension<AppTheme>? other, double t) {
    if (other == null) return this;
    if (other is AppTheme) {
      return AppTheme(
        color: AppColor.lerp(color, other.color, t),
      );
    }
    return this;
  }


  static ThemeData getThemeData(AppTheme appTheme) {
    final appColor = appTheme.color;
    final colorScheme = ColorScheme.fromSeed(
      seedColor: appColor.primary,
      brightness: appColor.brightness,
    );
    final bool isDark = colorScheme.brightness == Brightness.dark;

    return ThemeData(
      colorScheme: colorScheme,
      useMaterial3: true,
    );
  }
}

