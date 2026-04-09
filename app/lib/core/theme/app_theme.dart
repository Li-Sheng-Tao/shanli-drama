import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_typography.dart';
import '../constants/app_dimens.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get lightTheme => ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        colorSchemeSeed: AppColors.primary,
        scaffoldBackgroundColor: AppColors.scaffoldBackground,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: AppColors.textPrimary,
          elevation: 0,
          centerTitle: true,
          titleTextStyle: TextStyle(
            color: AppColors.textPrimary,
            fontSize: AppTypography.fontSize18,
            fontWeight: AppTypography.fontWeightSemiBold,
          ),
        ),
        cardTheme: CardThemeData(
          color: AppColors.cardBackground,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          margin: EdgeInsets.zero,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.white,
            minimumSize: const Size(double.infinity, 48),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            textStyle: AppTypography.button,
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            foregroundColor: AppColors.primary,
            minimumSize: const Size(double.infinity, 48),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            side: const BorderSide(color: AppColors.primary),
            textStyle: AppTypography.button,
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: AppColors.primary,
            textStyle: AppTypography.bodyMedium,
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: const Color(0xFFF5F5F5),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 14,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: AppColors.error),
          ),
          hintStyle: const TextStyle(
            color: AppColors.textHint,
            fontSize: AppTypography.fontSize14,
          ),
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Colors.white,
          selectedItemColor: AppColors.primary,
          unselectedItemColor: AppColors.textSecondary,
          type: BottomNavigationBarType.fixed,
          elevation: 8,
          selectedLabelStyle: TextStyle(
            fontSize: AppTypography.fontSize12,
            fontWeight: AppTypography.fontWeightMedium,
          ),
          unselectedLabelStyle: TextStyle(
            fontSize: AppTypography.fontSize12,
          ),
        ),
        dividerTheme: const DividerThemeData(
          color: AppColors.divider,
          thickness: AppDimens.dividerHeight,
          space: 0,
        ),
        textTheme: const TextTheme(
          headlineLarge: AppTypography.headline1,
          headlineMedium: AppTypography.headline2,
          headlineSmall: AppTypography.headline3,
          titleLarge: AppTypography.headline4,
          bodyLarge: AppTypography.bodyLarge,
          bodyMedium: AppTypography.bodyMedium,
          bodySmall: AppTypography.bodySmall,
          labelSmall: AppTypography.caption,
        ),
      );

  static ThemeData get darkTheme => ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorSchemeSeed: AppColors.primary,
        scaffoldBackgroundColor: AppColors.backgroundDark,
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.backgroundDark,
          foregroundColor: AppColors.textWhite,
          elevation: 0,
          centerTitle: true,
          titleTextStyle: TextStyle(
            color: AppColors.textWhite,
            fontSize: AppTypography.fontSize18,
            fontWeight: AppTypography.fontWeightSemiBold,
          ),
        ),
        cardTheme: CardThemeData(
          color: const Color(0xFF252540),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          margin: EdgeInsets.zero,
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Color(0xFF12122A),
          selectedItemColor: AppColors.primary,
          unselectedItemColor: AppColors.textSecondary,
          type: BottomNavigationBarType.fixed,
          elevation: 8,
        ),
        textTheme: const TextTheme(
          headlineLarge: TextStyle(
            fontSize: AppTypography.fontSize32,
            fontWeight: AppTypography.fontWeightBold,
            color: AppColors.textWhite,
          ),
          headlineMedium: TextStyle(
            fontSize: AppTypography.fontSize28,
            fontWeight: AppTypography.fontWeightBold,
            color: AppColors.textWhite,
          ),
          headlineSmall: TextStyle(
            fontSize: AppTypography.fontSize24,
            fontWeight: AppTypography.fontWeightSemiBold,
            color: AppColors.textWhite,
          ),
          titleLarge: TextStyle(
            fontSize: AppTypography.fontSize20,
            fontWeight: AppTypography.fontWeightSemiBold,
            color: AppColors.textWhite,
          ),
          bodyLarge: TextStyle(
            fontSize: AppTypography.fontSize16,
            color: AppColors.textWhite,
          ),
          bodyMedium: TextStyle(
            fontSize: AppTypography.fontSize14,
            color: AppColors.textWhite,
          ),
          bodySmall: TextStyle(
            fontSize: AppTypography.fontSize12,
            color: AppColors.textSecondary,
          ),
          labelSmall: TextStyle(
            fontSize: AppTypography.fontSize10,
            color: AppColors.textSecondary,
          ),
        ),
      );
}
