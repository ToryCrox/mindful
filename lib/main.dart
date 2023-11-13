import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import 'app.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  /// logger 初始化
  /// logger 初始化
  logger = Logger(
    printer: LoggerPrettyPrinter(
      methodCount: 1,
      printEmojis: false,
      lineLength: 160,
      printTime: true,
    ),
  );
  final t1 = DateTime.now().millisecondsSinceEpoch;
  await Future.wait([
    PrefsHelper.init(),
  ]);
  logger.d('init cost: ${DateTime.now().millisecondsSinceEpoch - t1}ms');

  runApp(const App());
}

