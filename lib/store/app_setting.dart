// ignore_for_file: library_private_types_in_public_api

import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../app/app_theme.dart';

part 'app_setting.g.dart';

/// app相关设置
class AppSetting = AppSettingBase with _$AppSetting;

abstract class AppSettingBase with Store {
  void init() {
    reloadTheme();
  }

  @observable
  late ThemeMode themeMode = ThemeMode.values
      .byName(PrefsHelper.getString('app_theme_mode', ThemeMode.system.name));

  @action
  Future setThemeMode(ThemeMode themeMode) {
    this.themeMode = themeMode;
    return PrefsHelper.setString('app_theme_mode', themeMode.name);
  }

  @action
  Future resetThemeMode() async {
    await PrefsHelper.remove('app_theme_mode');
  }

  @observable
  AppTheme appTheme = AppTheme(color: AppThemes.lightColor);

  @observable
  AppTheme dartAppTheme = AppTheme(color: AppThemes.darkColor);

  // @computed
  // ThemeData get darkTheme => _generateThemeData(darkColorScheme, primaryColor);
  @computed
  ThemeData get darkTheme => ThemeData(
        colorSchemeSeed: appTheme.color.primary,
        brightness: Brightness.dark,
      );

  @action
  Future setThemeName(String themeName) async {
    await PrefsHelper.setString('app_theme_name', themeName);
  }

  @action
  Future reloadTheme() async {
    appTheme = AppTheme(color: AppThemes.lightColor);
    dartAppTheme = AppTheme(color: AppThemes.darkColor);
  }


}


