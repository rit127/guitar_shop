import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:guitarfashion/utils/AppFont.dart';
import 'package:guitarfashion/utils/HexColor.dart';

import 'AppColor.dart';
final ThemeData AppThemeData = new ThemeData(
  primaryColor: AppColor.primaryColor,
  primaryColorDark: AppColor.primaryColorDark,
  accentColor: AppColor.accentColor,
  brightness: Brightness.light,
  backgroundColor: AppColor.appBg,
  scaffoldBackgroundColor: Colors.white,
  textSelectionColor: AppColor.primaryColor,
  unselectedWidgetColor: AppColor.grayText,
  indicatorColor: AppColor.primaryColor,
  appBarTheme: AppBarTheme(
    color: HexColor('#ECEFF0'),
  ),
  primaryTextTheme: TextTheme(
      caption: TextStyle(color: AppColor.accentColor,fontFamily: AppFont.mainFont,fontWeight: FontWeight.bold,fontSize: 22)
  ),
  textTheme: TextTheme(
    headline:TextStyle(color: AppColor.accentColor,fontFamily: AppFont.mainFont,fontWeight: FontWeight.bold,fontSize: 22),
    title: TextStyle(color: AppColor.normalText,fontFamily: AppFont.mainFont,fontSize: 14),
    subtitle: TextStyle(color: AppColor.grayText,fontFamily: AppFont.mainFont,fontSize: 12),
  ),
//  iconTheme: IconThemeData(color: AppColor.accentColor),
  fontFamily: AppFont.mainFont,
);