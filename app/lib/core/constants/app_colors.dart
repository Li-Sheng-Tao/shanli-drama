import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // 品牌主色
  static const Color primary = Color(0xFFFF6B35); // 活力橙
  static const Color secondary = Color(0xFFFFB800); // 金黄

  // 背景色
  static const Color backgroundDark = Color(0xFF1A1A2E); // 深蓝黑（视频播放区）
  static const Color backgroundLight = Color(0xFFFFF8F0); // 暖白
  static const Color scaffoldBackground = Color(0xFFF5F5F5);
  static const Color cardBackground = Color(0xFFFFFFFF);

  // 文字色
  static const Color textPrimary = Color(0xFF333333);
  static const Color textSecondary = Color(0xFF999999);
  static const Color textHint = Color(0xFFCCCCCC);
  static const Color textWhite = Color(0xFFFFFFFF);

  // 功能色
  static const Color success = Color(0xFF4CAF50);
  static const Color error = Color(0xFFF44336);
  static const Color warning = Color(0xFFFF9800);
  static const Color info = Color(0xFF2196F3);

  // VIP
  static const Color vipGold = Color(0xFFFFD700);
  static const Color vipGradientStart = Color(0xFFFFD700);
  static const Color vipGradientEnd = Color(0xFFFFA000);

  // 分割线
  static const Color divider = Color(0xFFEEEEEE);

  // 遮罩
  static const Color overlay = Color(0x80000000);

  // 渐变
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primary, secondary],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient vipGradient = LinearGradient(
    colors: [vipGradientStart, vipGradientEnd],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
