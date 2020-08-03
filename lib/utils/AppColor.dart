import 'package:flutter/material.dart';

import 'HexColor.dart';

class AppColor{

  static  Color primaryColor =  HexColor("#ECEFF0");
  static  Color primaryColorDark = HexColor("#03541B");
  static  Color accentColor = HexColor("#FFFFFF");
  static  Color appBg = Color(0xFFF6F6F6);
  static  Color grayText = HexColor("#747575");
  static  Color normalText = HexColor("#262626");
  static  Color mainText = HexColor("#000000");

  static  Color guitarShopColor = HexColor("#0097A2");


  static const Gradient btnFbGradient = LinearGradient(
      begin: Alignment(-1.0, 0.0),
      end: Alignment(0.0, 1.0),
      colors: [
        Color(0xFF2c539e),
        Color(0xFF244386),
      ]);

}