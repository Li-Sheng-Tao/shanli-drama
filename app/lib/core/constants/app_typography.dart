import 'package:flutter/material.dart';

class AppTypography {
  AppTypography._();

  // 字体大小
  static const double fontSize10 = 10.0;
  static const double fontSize12 = 12.0;
  static const double fontSize14 = 14.0;
  static const double fontSize16 = 16.0;
  static const double fontSize18 = 18.0;
  static const double fontSize20 = 20.0;
  static const double fontSize24 = 24.0;
  static const double fontSize28 = 28.0;
  static const double fontSize32 = 32.0;

  // 字重
  static const FontWeight fontWeightRegular = FontWeight.w400;
  static const FontWeight fontWeightMedium = FontWeight.w500;
  static const FontWeight fontWeightSemiBold = FontWeight.w600;
  static const FontWeight fontWeightBold = FontWeight.w700;

  // 行高
  static const double lineHeight1_2 = 1.2;
  static const double lineHeight1_4 = 1.4;
  static const double lineHeight1_6 = 1.6;

  // 文字样式
  static const TextStyle headline1 = TextStyle(
    fontSize: fontSize32,
    fontWeight: fontWeightBold,
    height: lineHeight1_2,
  );

  static const TextStyle headline2 = TextStyle(
    fontSize: fontSize28,
    fontWeight: fontWeightBold,
    height: lineHeight1_2,
  );

  static const TextStyle headline3 = TextStyle(
    fontSize: fontSize24,
    fontWeight: fontWeightSemiBold,
    height: lineHeight1_2,
  );

  static const TextStyle headline4 = TextStyle(
    fontSize: fontSize20,
    fontWeight: fontWeightSemiBold,
    height: lineHeight1_4,
  );

  static const TextStyle bodyLarge = TextStyle(
    fontSize: fontSize16,
    fontWeight: fontWeightRegular,
    height: lineHeight1_6,
  );

  static const TextStyle bodyMedium = TextStyle(
    fontSize: fontSize14,
    fontWeight: fontWeightRegular,
    height: lineHeight1_6,
  );

  static const TextStyle bodySmall = TextStyle(
    fontSize: fontSize12,
    fontWeight: fontWeightRegular,
    height: lineHeight1_6,
  );

  static const TextStyle caption = TextStyle(
    fontSize: fontSize10,
    fontWeight: fontWeightRegular,
    height: lineHeight1_4,
  );

  static const TextStyle button = TextStyle(
    fontSize: fontSize16,
    fontWeight: fontWeightSemiBold,
    height: lineHeight1_2,
  );
}
