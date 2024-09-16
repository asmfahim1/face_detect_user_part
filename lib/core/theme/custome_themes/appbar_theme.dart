import 'package:flutter/material.dart';
import 'package:mict_final_project/core/utils/colors.dart';

class FAppBarTheme {
  FAppBarTheme._();

  static AppBarTheme lightAppBarTheme = const AppBarTheme(
    centerTitle: false,
    elevation: 0,
    scrolledUnderElevation: 0,
    backgroundColor: primaryColor,
    surfaceTintColor: Colors.transparent,
    iconTheme: IconThemeData(color: Colors.black, size: 24),
    actionsIconTheme: IconThemeData(color: Colors.black, size: 24),
    titleTextStyle: TextStyle(
        fontSize: 18, fontWeight: FontWeight.w600, color: Colors.black),
  );

  static AppBarTheme darkAppBarTheme = const AppBarTheme(
    centerTitle: false,
    elevation: 0,
    scrolledUnderElevation: 0,
    backgroundColor: primaryColor,
    surfaceTintColor: Colors.transparent,
    iconTheme: IconThemeData(color: Colors.white, size: 24),
    actionsIconTheme: IconThemeData(color: Colors.white, size: 24),
    titleTextStyle: TextStyle(
        fontSize: 18, fontWeight: FontWeight.w600, color: Colors.white),
  );
}
