import 'package:intl/intl.dart';

class AppDateUtils {
  AppDateUtils._();

  static const String formatDefault = 'yyyy-MM-dd HH:mm:ss';
  static const String formatDate = 'yyyy-MM-dd';
  static const String formatTime = 'HH:mm';
  static const String formatMonthDay = 'MM-dd';
  static const String formatChinese = 'yyyy年MM月dd日';

  /// 格式化日期时间
  static String format(DateTime dateTime, [String pattern = formatDefault]) {
    return DateFormat(pattern).format(dateTime);
  }

  /// 格式化为友好时间（刚刚、几分钟前、几小时前等）
  static String formatFriendly(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inSeconds < 60) {
      return '刚刚';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes}分钟前';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}小时前';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}天前';
    } else if (difference.inDays < 30) {
      return '${(difference.inDays / 7).floor()}周前';
    } else if (difference.inDays < 365) {
      return '${(difference.inDays / 30).floor()}个月前';
    } else {
      return format(dateTime, formatDate);
    }
  }

  /// 格式化时长（秒数转为 mm:ss 或 hh:mm:ss）
  static String formatDuration(int totalSeconds) {
    final hours = totalSeconds ~/ 3600;
    final minutes = (totalSeconds % 3600) ~/ 60;
    final seconds = totalSeconds % 60;

    if (hours > 0) {
      return '${hours.toString().padLeft(2, '0')}:'
          '${minutes.toString().padLeft(2, '0')}:'
          '${seconds.toString().padLeft(2, '0')}';
    }
    return '${minutes.toString().padLeft(2, '0')}:'
        '${seconds.toString().padLeft(2, '0')}';
  }

  /// 解析日期字符串
  static DateTime? parse(String dateString, [String pattern = formatDefault]) {
    try {
      return DateFormat(pattern).parse(dateString);
    } catch (_) {
      return null;
    }
  }
}
