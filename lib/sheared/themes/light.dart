import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:social_app/sheared/style/color/colors.dart';

ThemeData LightTheme = ThemeData(
  scaffoldBackgroundColor: White,
  appBarTheme: AppBarTheme(
    actionsIconTheme: IconThemeData(color: Black, size: 25.0),
    backgroundColor: White,
    titleTextStyle: TextStyle(
      color: Black,
      fontSize: 25,
      fontWeight: FontWeight.w600,
      fontFamily: 'font1',
    ),
    elevation: 0.0,
    iconTheme: IconThemeData(color: Colors.black),
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: White,
      statusBarIconBrightness: Brightness.dark,
    ),
    backwardsCompatibility: false,
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: White,
    elevation: 0.0,
    type: BottomNavigationBarType.fixed,
    selectedItemColor: mainColor,
    unselectedItemColor: Gray,
  ),
  textTheme: TextTheme(
    caption: TextStyle(
      fontSize: 14,
    ),
    bodyText1: TextStyle(
      fontSize: 22,
    ),
  ),
  fontFamily: 'font1',
);
