// ignore_for_file: overridden_fields, annotate_overrides

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';

const kThemeModeKey = '__theme_mode__';
Box? _userPrefsBox;

abstract class FFTheme {
  static Future initialize() async =>
      _userPrefsBox = await Hive.openBox('userPrefs');

  static ThemeMode get themeMode {
    final darkMode = _userPrefsBox?.get(kThemeModeKey) as bool?;
    return darkMode == null
        ? ThemeMode.system
        : darkMode
            ? ThemeMode.dark
            : ThemeMode.light;
  }

  static void saveThemeMode(ThemeMode mode) => mode == ThemeMode.system
      ? _userPrefsBox?.delete(kThemeModeKey)
      : _userPrefsBox?.put(kThemeModeKey, mode == ThemeMode.dark);

  static FFTheme of(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
          ? DarkModeTheme()
          : LightModeTheme();

  late Color primaryColor;
  late Color secondaryColor;
  late Color tertiaryColor;
  late Color alternate;
  late Color primaryBackground;
  late Color secondaryBackground;
  late Color primaryText;
  late Color secondaryText;

  late Color primaryBtnText;
  late Color lineColor;
  late Color grayIcon;
  late Color tertiary400;
  late Color customColor3;
  late Color customColor1;
  late Color backgroundComponents;
  late Color awesomeOrange;

  String get title1Family => typography.title1Family;
  TextStyle get title1 => typography.title1;
  String get title2Family => typography.title2Family;
  TextStyle get title2 => typography.title2;
  String get title3Family => typography.title3Family;
  TextStyle get title3 => typography.title3;
  String get subtitle1Family => typography.subtitle1Family;
  TextStyle get subtitle1 => typography.subtitle1;
  String get subtitle2Family => typography.subtitle2Family;
  TextStyle get subtitle2 => typography.subtitle2;
  String get bodyText1Family => typography.bodyText1Family;
  TextStyle get bodyText1 => typography.bodyText1;
  String get bodyText2Family => typography.bodyText2Family;
  TextStyle get bodyText2 => typography.bodyText2;

  Typography get typography => ThemeTypography(this);
}

class LightModeTheme extends FFTheme {
  late Color primaryColor = const Color(0xFF4B39EF);
  late Color secondaryColor = const Color(0xFF4B39EF);
  late Color tertiaryColor = const Color(0xFFDBE2E7);
  late Color alternate = const Color(0xFFDBE2E7);
  late Color primaryBackground = const Color(0xFFF1F4F8);
  late Color secondaryBackground = const Color(0xFFFFFFFF);
  late Color primaryText = const Color(0xFF14181B);
  late Color secondaryText = const Color(0xFF57636C);

  late Color primaryBtnText = const Color(0xFFFFFFFF);
  late Color lineColor = const Color(0xFFE0E3E7);
  late Color grayIcon = const Color(0xFF95A1AC);
  late Color tertiary400 = const Color(0xFF39D2C0);
  late Color customColor3 = const Color(0xFFDF3F3F);
  late Color customColor1 = const Color(0xFF2FB73C);
  late Color backgroundComponents = const Color(0xFF1D2428);
  late Color awesomeOrange = const Color(0xFFD64C06);
}

abstract class Typography {
  String get title1Family;
  TextStyle get title1;
  String get title2Family;
  TextStyle get title2;
  String get title3Family;
  TextStyle get title3;
  String get subtitle1Family;
  TextStyle get subtitle1;
  String get subtitle2Family;
  TextStyle get subtitle2;
  String get bodyText1Family;
  TextStyle get bodyText1;
  String get bodyText2Family;
  TextStyle get bodyText2;
}

class ThemeTypography extends Typography {
  ThemeTypography(this.theme);

  final FFTheme theme;

  String get title1Family => 'Outfit';
  TextStyle get title1 => GoogleFonts.getFont(
        'Outfit',
        color: theme.primaryText,
        fontWeight: FontWeight.w500,
        fontSize: 34,
      );
  String get title2Family => 'Outfit';
  TextStyle get title2 => GoogleFonts.getFont(
        'Outfit',
        color: theme.primaryText,
        fontWeight: FontWeight.normal,
        fontSize: 28,
      );
  String get title3Family => 'Outfit';
  TextStyle get title3 => GoogleFonts.getFont(
        'Outfit',
        color: theme.primaryText,
        fontWeight: FontWeight.w500,
        fontSize: 20,
      );
  String get subtitle1Family => 'Outfit';
  TextStyle get subtitle1 => GoogleFonts.getFont(
        'Outfit',
        color: Colors.white,
        fontWeight: FontWeight.normal,
        fontSize: 17,
      );
  String get subtitle2Family => 'Space Grotesk';
  TextStyle get subtitle2 => GoogleFonts.getFont(
        'Space Grotesk',
        color: theme.primaryText,
        fontWeight: FontWeight.w500,
        fontSize: 16,
      );
  String get bodyText1Family => 'Space Grotesk';
  TextStyle get bodyText1 => GoogleFonts.getFont(
        'Space Grotesk',
        color: theme.primaryText,
        fontWeight: FontWeight.normal,
        fontSize: 14,
      );
  String get bodyText2Family => 'Space Grotesk';
  TextStyle get bodyText2 => GoogleFonts.getFont(
        'Space Grotesk',
        color: theme.secondaryText,
        fontWeight: FontWeight.normal,
        fontSize: 14,
      );
}

class DarkModeTheme extends FFTheme {
  late Color primaryColor = const Color(0xFF4B39EF);
  late Color secondaryColor = const Color(0xFFFFFFFF);
  late Color tertiaryColor = const Color(0xFF262D34);
  late Color alternate = const Color(0xFF262D34);
  late Color primaryBackground = const Color(0xFF1A1F24);
  late Color secondaryBackground = const Color(0xFF0F1316);
  late Color primaryText = const Color(0xFFFFFFFF);
  late Color secondaryText = const Color(0xFF95A1AC);

  late Color primaryBtnText = const Color(0xFFFFFFFF);
  late Color lineColor = const Color(0xFF22282F);
  late Color grayIcon = const Color(0xFF95A1AC);
  late Color tertiary400 = const Color(0xFF39D2C0);
  late Color customColor3 = const Color(0xFFDF3F3F);
  late Color customColor1 = const Color(0xFF452FB7);
  late Color backgroundComponents = const Color(0xFF1D2428);
  late Color awesomeOrange = const Color(0xFFD64C06);
}

extension TextStyleHelper on TextStyle {
  TextStyle override({
    String? fontFamily,
    Color? color,
    double? fontSize,
    FontWeight? fontWeight,
    double? letterSpacing,
    FontStyle? fontStyle,
    bool useGoogleFonts = true,
    TextDecoration? decoration,
    double? lineHeight,
  }) =>
      useGoogleFonts
          ? GoogleFonts.getFont(
              fontFamily!,
              color: color ?? this.color,
              fontSize: fontSize ?? this.fontSize,
              letterSpacing: letterSpacing ?? this.letterSpacing,
              fontWeight: fontWeight ?? this.fontWeight,
              fontStyle: fontStyle ?? this.fontStyle,
              decoration: decoration,
              height: lineHeight,
            )
          : copyWith(
              fontFamily: fontFamily,
              color: color,
              fontSize: fontSize,
              letterSpacing: letterSpacing,
              fontWeight: fontWeight,
              fontStyle: fontStyle,
              decoration: decoration,
              height: lineHeight,
            );
}
