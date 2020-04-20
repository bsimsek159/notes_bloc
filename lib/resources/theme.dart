import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum AppTheme {
  Light,
  Dark,
}

final appThemeData = {
  AppTheme.Light: ThemeData(
    brightness: Brightness.light,
    primaryColor: primaryColor,
  ),
  AppTheme.Dark: ThemeData(
    brightness: Brightness.dark,
    primaryColor: primaryColor,
  ),
};

Color primaryColor = Colors.orangeAccent;
Color redColor = Colors.redAccent;
Color lightGray = Colors.grey.shade400;
