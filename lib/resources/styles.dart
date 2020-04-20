import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notesbloc/resources/theme.dart';

class Styles{
  static final appBarTitleStyle = const TextStyle(
    fontFamily: 'RobotoMono',
    fontWeight: FontWeight.w600,
    fontSize: 24,
  );

  static final noteItemHeaderStyle = const TextStyle(
    fontFamily: 'RobotoMono',
    fontSize: 20,
    fontWeight: FontWeight.w500,
  );

  static final noteItemContentStyle = const TextStyle(
    fontFamily: 'RobotoMono',
    fontSize: 14,
    color: Colors.grey,
    fontWeight: FontWeight.w500,
  );

  static final noteItemDateStyle = const TextStyle(
    fontFamily: 'RobotoMono',
    fontSize: 12,
    color: Colors.grey,
    fontWeight: FontWeight.w400,
  );

  static final noteItemRegularBoxShadow =  BoxShadow(
      color: primaryColor.withAlpha(25),
      blurRadius: 8,
      offset: Offset(0, 8)
  );

  static final noteItemFlaggedBoxShadow =  BoxShadow(
      color:redColor.withAlpha(50),
      blurRadius: 8,
      offset: Offset(0, 8)
  );

  static final noteItemDismissBackground =  LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      tileMode: TileMode.repeated,
      colors: [Colors.red[500],Colors.red[300]]
  );

  static final positiveButtonStyle = const TextStyle(
      color: Colors.greenAccent,
      fontWeight: FontWeight.w400,
      letterSpacing: 1
  );

  static final negativeButtonStyle = const TextStyle(
      fontWeight: FontWeight.w400,
      letterSpacing: 1);
}