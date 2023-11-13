
import 'package:intl/intl.dart';

class TimeUtil {

  TimeUtil._();

  /// 当前时间戳
  static int get millisecondsSinceEpoch => DateTime.now().millisecondsSinceEpoch;

  /// 当前时间戳
  static DateTime fromTimeStamp(int timeStamp) {
    /// 判断是否是毫秒
    if (timeStamp < 10000000000) {
      timeStamp *= 1000;
    }
    return DateTime.fromMillisecondsSinceEpoch(timeStamp);
  }

  static String formatTimeStamp(int timeStamp, {String format = 'yyyy-MM-dd HH:mm:ss'}) {
    return DateFormat(format).format(fromTimeStamp(timeStamp));
  }


  /// 格式化时间
  /// 如果是今天，只显示小时分钟，例如： 12:00
  /// 如果是昨天，显示昨天+小时分钟，例如： 昨天 12:00
  /// 如果是前天，显示前天+小时分钟，例如： 前天 12:00
  /// 如果是更早之前，但是是今年， 显示月日，例如： 01月01日
  /// 如果是更早之前，显示年月日，例如： 2021年01月01日
  static String formatLatestTime(int? time) {
    if (time == null) {
      return '';
    }
    final DateTime dateTime = TimeUtil.fromTimeStamp(time);
    final DateTime now = DateTime.now();
    final DateTime today = DateTime(now.year, now.month, now.day);

    if (dateTime.isAfter(today)) {
      return '${dateTime.hour}:${dateTime.minute}';
    }
    final DateTime yesterday = DateTime(now.year, now.month, now.day - 1);
    if (dateTime.isAfter(yesterday)) {
      return '昨天 ${dateTime.hour}:${dateTime.minute}';
    }
    final DateTime beforeYesterday = DateTime(now.year, now.month, now.day - 2);
    if (dateTime.isAfter(beforeYesterday)) {
      return '前天 ${dateTime.hour}:${dateTime.minute}';
    }
    if (dateTime.year == now.year) {
      return '${dateTime.month}月${dateTime.day}日';
    }
    return '${dateTime.year}年${dateTime.month}月${dateTime.day}日';
  }
}