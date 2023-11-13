import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class FileUtil {

  FileUtil._();

  static Future<bool> deleteFile(String path) async {
    try {
      final file = File(path);
      await file.delete();
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<bool> fileExists(String path) async {
    try {
      final file = File(path);
      return await file.exists();
    } catch (e) {
      return false;
    }
  }

  /// 文件大小
  static Future<int> fileSize(String path) async {
    try {
      final file = File(path);
      return await file.length();
    } catch (e) {
      return 0;
    }
  }

  static String fileSizeFormatedBySize(int size) {
    if (size < 1024) {
      return '$size B';
    } else if (size < 1024 * 1024) {
      return '${(size / 1024).toStringAsFixed(2)} KB';
    } else if (size < 1024 * 1024 * 1024) {
      return '${(size / 1024 / 1024).toStringAsFixed(2)} MB';
    } else {
      return '${(size / 1024 / 1024 / 1024).toStringAsFixed(2)} GB';
    }
  }

  /// 文件大小，格式化
  ///
  static Future<String> fileSizeFormat(String path) async {
    final fileLength = await fileSize(path);
    return fileSizeFormatedBySize(fileLength);
  }

  ///读取本地的JSON文件
  static Future<String> readJson(String path) async {
    try {
      final jsonString = await rootBundle.loadString(path);
      return jsonString;
    } catch (e) {
      debugPrint('Error reading JSON: $e');
      return ''; // 或者返回其他默认值或错误标志，具体根据需要来定
    }
  }

}