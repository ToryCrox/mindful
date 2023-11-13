import 'package:flutter/material.dart';

import 'app/app_theme.dart';

/// 存放一些基本的全局变量
class R {
  static BuildContext? _context;
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static BuildContext get context {
    assert(_context != null,
        'R.context is null, please call R.setup(context) first.');
    return navigatorKey.currentState?.context ?? _context!;
  }

  static set context(BuildContext context) {
    _context = context;
  }

  @Deprecated('Use context.color instead')
  static AppColor get color => theme.extension<AppTheme>()!.color;

  static ThemeData get theme => Theme.of(context);

  static ColorScheme get colorScheme => theme.colorScheme;


}

extension ContextExtension on BuildContext {


  MediaQueryData get mediaQuery => MediaQuery.of(this);

  ThemeData get theme => Theme.of(this);

  ColorScheme get colorScheme => theme.colorScheme;

  AppTheme get appTheme => theme.extension<AppTheme>()!;

  AppColor get color => appTheme.color;

  bool get isDark => theme.brightness == Brightness.dark;

}
