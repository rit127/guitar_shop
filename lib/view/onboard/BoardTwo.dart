import 'package:flutter/material.dart';
import 'package:guitarfashion/enums/device_screen_type.dart';
import 'package:guitarfashion/res.dart';
import 'package:guitarfashion/utils/ui_utils.dart';

class BoardTwo extends StatefulWidget {
  @override
  _BoardTwoState createState() => _BoardTwoState();
}

class _BoardTwoState extends State<BoardTwo> {
  @override
  Widget build(BuildContext context) {

    var currentHeight = MediaQuery.of(context).size.height;
    var currentWidth = MediaQuery.of(context).size.width;

    double imageWidth = 0;

    DeviceScreenType screenType = getDeviceType(MediaQuery.of(context));

    if(screenType == DeviceScreenType.Mobile) {
      imageWidth = currentHeight * 0.4;
      if(currentWidth < 321) {
        imageWidth = currentHeight * 0.4;
      }
    } else {
      imageWidth = currentHeight * 0.5;
    }

    return Container(
      width: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            child: Image.asset(
              Res.on_board2,
              height: imageWidth,
            ),
          ),
          SizedBox(height: 30),
          Text(
            "ដឹកជញ្ជូន២៥ខេត្តក្រុង",
            style: TextStyle(
              fontSize: 28,
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
            child: Text(
              "ទោះបីជាអតិថិជននៅដល់ទីណាក៏អាចធ្វើការ បញ្ជាទិញពីពួកយើងបាន",
              style: TextStyle(
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
