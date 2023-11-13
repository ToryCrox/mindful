// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_setting.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AppSetting on AppSettingBase, Store {
  Computed<ThemeData>? _$darkThemeComputed;

  @override
  ThemeData get darkTheme =>
      (_$darkThemeComputed ??= Computed<ThemeData>(() => super.darkTheme,
              name: 'AppSettingBase.darkTheme'))
          .value;

  late final _$themeModeAtom =
      Atom(name: 'AppSettingBase.themeMode', context: context);

  @override
  ThemeMode get themeMode {
    _$themeModeAtom.reportRead();
    return super.themeMode;
  }

  @override
  set themeMode(ThemeMode value) {
    _$themeModeAtom.reportWrite(value, super.themeMode, () {
      super.themeMode = value;
    });
  }

  late final _$appThemeAtom =
      Atom(name: 'AppSettingBase.appTheme', context: context);

  @override
  AppTheme get appTheme {
    _$appThemeAtom.reportRead();
    return super.appTheme;
  }

  @override
  set appTheme(AppTheme value) {
    _$appThemeAtom.reportWrite(value, super.appTheme, () {
      super.appTheme = value;
    });
  }

  late final _$dartAppThemeAtom =
      Atom(name: 'AppSettingBase.dartAppTheme', context: context);

  @override
  AppTheme get dartAppTheme {
    _$dartAppThemeAtom.reportRead();
    return super.dartAppTheme;
  }

  @override
  set dartAppTheme(AppTheme value) {
    _$dartAppThemeAtom.reportWrite(value, super.dartAppTheme, () {
      super.dartAppTheme = value;
    });
  }

  late final _$resetThemeModeAsyncAction =
      AsyncAction('AppSettingBase.resetThemeMode', context: context);

  @override
  Future<dynamic> resetThemeMode() {
    return _$resetThemeModeAsyncAction.run(() => super.resetThemeMode());
  }

  late final _$setThemeNameAsyncAction =
      AsyncAction('AppSettingBase.setThemeName', context: context);

  @override
  Future<dynamic> setThemeName(String themeName) {
    return _$setThemeNameAsyncAction.run(() => super.setThemeName(themeName));
  }

  late final _$reloadThemeAsyncAction =
      AsyncAction('AppSettingBase.reloadTheme', context: context);

  @override
  Future<dynamic> reloadTheme() {
    return _$reloadThemeAsyncAction.run(() => super.reloadTheme());
  }

  late final _$AppSettingBaseActionController =
      ActionController(name: 'AppSettingBase', context: context);

  @override
  Future<dynamic> setThemeMode(ThemeMode themeMode) {
    final _$actionInfo = _$AppSettingBaseActionController.startAction(
        name: 'AppSettingBase.setThemeMode');
    try {
      return super.setThemeMode(themeMode);
    } finally {
      _$AppSettingBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
themeMode: ${themeMode},
appTheme: ${appTheme},
dartAppTheme: ${dartAppTheme},
darkTheme: ${darkTheme}
    ''';
  }
}
