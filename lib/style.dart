import 'package:flutter/material.dart';

final themeData = ThemeData(
  scaffoldBackgroundColor: Colors.white,
  useMaterial3: true,
  primaryColor: const Color(0xffe60412),
  primarySwatch: Colors.grey,
  appBarTheme: const AppBarTheme(
    //titlebar設定
    centerTitle: true,
    backgroundColor: Colors.white,
    titleTextStyle: TextStyle(
      color: Color(0xff200e0c),
      fontSize: 20.0,
      fontWeight: FontWeight.w700,
    ),
  ),
  tabBarTheme: const TabBarTheme(
    //titlebar 滾動tab設定
    indicatorColor: Color(0xffe60412),
    labelStyle: TextStyle(
      fontSize: 18.0,
      color: Color(0xffe60412),
      fontWeight: FontWeight.w700,
    ),
    unselectedLabelStyle: TextStyle(fontWeight: FontWeight.w400),
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      //置底bar設定
      selectedItemColor: Color(0xffe60412),
      selectedLabelStyle: TextStyle(
        fontSize: 15.0,
      ),
      unselectedLabelStyle: TextStyle(
        fontSize: 15.0,
      )),
);
