import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:mindful/module/login/login_with_password_page.dart';
import 'package:mindful/store/stores.dart';

import 'app/app_theme.dart';
import 'module/home/home_page.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {


  @override
  void initState() {
    super.initState();
    appSetting.init();
  }

  @override
  void reassemble() {
    super.reassemble();

    /// 热重载的时候重新加载主题
    appSetting.reloadTheme();
    logger.d('App reassemble...');
  }


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      themeMode: appSetting.themeMode,
      theme: AppTheme.getThemeData(appSetting.appTheme),
      darkTheme: AppTheme.getThemeData(appSetting.dartAppTheme),
      home: userStore.isLogin ? const HomePage(title: 'Flutter Demo Home Page') : const LoginWithPasswordPage(),
    );
  }
}