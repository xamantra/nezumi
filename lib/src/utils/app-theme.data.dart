import 'package:flutter/material.dart';

class AppThemeData {
  final Color primary;
  final Color secondary;
  final Color accent;
  final Color primaryBackground;
  final Color secondaryBackground;
  final Color text1;
  final Color text2;
  final Color text3;

  AppThemeData({
    @required this.primary,
    @required this.secondary,
    @required this.accent,
    @required this.primaryBackground,
    @required this.secondaryBackground,
    @required this.text1,
    @required this.text2,
    @required this.text3,
  });
}

final defaultTheme = AppThemeData(
  primary: Color(0xff2E51A2),
  secondary: Color(0xffEB6100),
  accent: Colors.teal,
  primaryBackground: Color(0xff282C34),
  secondaryBackground: Color(0xff21252B),
  text1: Colors.white,
  text2: Colors.white.withOpacity(0.8),
  text3: Colors.white.withOpacity(0.6),
);
