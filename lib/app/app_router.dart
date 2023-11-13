import 'package:flutter/material.dart';
import 'package:mindful/module/login/login_with_password_page.dart';

import '../module/home/home_page.dart';

///
class AppRouter {

  /// 跳转到指定页面
  static Future<T?> push<T>(BuildContext context, Widget page, {String? name}) {
    return Navigator.of(context, rootNavigator: true).push(
      MaterialPageRoute(
        builder: (context) => page,
        settings: RouteSettings(name: name),
      ),
    );
  }

  static Future<T?> pushAndRemoveUntil<T>(
    BuildContext context,
    Widget page, {
    String? name,
    RoutePredicate? predicate,
  }) {
    return Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => page,
        settings: RouteSettings(name: name),
      ),
      predicate ?? (route) => false,
    );
  }

  /// 跳转到首页
  static Future pushUntilHome(BuildContext context) async {
    return await pushAndRemoveUntil(
      context, const HomePage(title: 'Home',),
      name: RouterPaths.home,
    );
  }

  /// 跳转到登录页
  static Future pushUntilLogin(BuildContext context) async {
    return await pushAndRemoveUntil(
      context, const LoginWithPasswordPage(),
      name: RouterPaths.loginMain,
    );
  }

}

class RouterPaths {
  const RouterPaths._();

  static const String home = '/home';

  static const String loginMain = '/login/main';
  static const String loginWithPwd = '/login/withPwd';
}
