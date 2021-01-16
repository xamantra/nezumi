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
  final Color text4;
  final Color text5;
  final Color text6;
  final Color text7;

  AppThemeData({
    @required this.primary,
    @required this.secondary,
    @required this.accent,
    @required this.primaryBackground,
    @required this.secondaryBackground,
    @required this.text1,
    @required this.text2,
    @required this.text3,
    @required this.text4,
    @required this.text5,
    @required this.text6,
    @required this.text7,
  });
}

final defaultTheme = AppThemeData(
  primary: Color(0xff2E51A2),
  secondary: Color(0xffEB6100),
  accent: Colors.blueAccent,
  primaryBackground: Color(0xff222222),
  secondaryBackground: Color(0xff333333),
  text1: Colors.white,
  text2: Colors.white.withOpacity(0.8),
  text3: Colors.white.withOpacity(0.6),
  text4: Colors.white.withOpacity(0.5),
  text5: Colors.white.withOpacity(0.4),
  text6: Colors.white.withOpacity(0.3),
  text7: Colors.white.withOpacity(0.2),
);
