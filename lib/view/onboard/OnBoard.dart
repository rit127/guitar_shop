import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:guitarfashion/enums/device_screen_type.dart';
import 'package:guitarfashion/repository/AuthRepository.dart';
import 'package:guitarfashion/res.dart';
import 'package:guitarfashion/utils/HexColor.dart';
import 'package:guitarfashion/utils/ui_utils.dart';
import 'package:guitarfashion/view/home/HomeScreen.dart';
import 'package:guitarfashion/view/onboard/BoardOne.dart';
import 'package:guitarfashion/view/onboard/BoardThree.dart';
import 'package:guitarfashion/view/onboard/BoardTwo.dart';
import 'package:guitarfashion/view/register/RegisterScreen.dart';

class OnBoard extends StatefulWidget {
  @override
  _OnBoardState createState() => _OnBoardState();
}

class _OnBoardState extends State<OnBoard> {
  SwiperController _controller;
  int currentIndex = 0;

  List<Widget> listOnBoard = [];

  bool isReady = false;

  @override
  void initState() {
    super.initState();
    _controller = new SwiperController();

    listOnBoard = [
      BoardOne(),
      BoardTwo(),
      BoardThree(),
    ];

    onFirstLoad();
  }

  onFirstLoad() async {
    bool isFirstLoad = await AuthRepository.getFirstLoad();

    if(isFirstLoad != null) {
      onFinish();
    }else {
      setState(() {
        isReady = true;
      });
    }
  }

  void _onNextBoard() {
    _controller.next(animation: true);
  }

  onFinish() async {
    await AuthRepository.setFirstLoad(true);

    Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => HomeScreen()));
  }

  @override
  Widget build(BuildContext context) {
    var currentHeight = MediaQuery.of(context).size.height;
    var currentWidth = MediaQuery.of(context).size.width;

    double imageWidth = 0;
    int addOne = 0;
    DeviceScreenType screenType = getDeviceType(MediaQuery.of(context));

    if(screenType == DeviceScreenType.Mobile) {
      imageWidth = 500;
      if(currentWidth < 321) {
        imageWidth = 400;
        addOne = 50;
      }
    } else {
      imageWidth = 500;
    }

    if(!isReady) {
      return Scaffold();
    }

    return Scaffold(
      body: Stack(
        children: <Widget>[
          Positioned(
            right: -250,
            top: -150,
            child: Container(
              height: imageWidth,
              width: imageWidth,
              decoration: BoxDecoration(
                color: currentIndex != 1 ? HexColor('#B3E6E9') : HexColor('#ECBBC0'),
                borderRadius: BorderRadius.all(
                  Radius.circular(250),
                ),
              ),
            ),
          ),
          Positioned(
            left: -350,
            bottom: -350,
            child: Container(
              height: imageWidth + addOne,
              width: imageWidth + addOne,
              decoration: BoxDecoration(
                color: currentIndex != 1 ? HexColor('#ECBBC0') : HexColor('#B3E7E9'),
                borderRadius: BorderRadius.all(
                  Radius.circular(200),
                ),
              ),
            ),
          ),
          customPagination(currentIndex),
          Align(
            child: Swiper(
              curve: Curves.easeInOut,
              controller: _controller,
              itemCount: 3,
              loop: false,
              outer: true,
              index: currentIndex,
              onIndexChanged: (int index) {
                setState(() {
                  currentIndex = index;
                });
              },
              itemBuilder: (BuildContext context, int index) {
                return listOnBoard[index];
              },
            ),
          ),
          Positioned(
            top: 50,
            right: 0,
            child: FlatButton(
              onPressed: onFinish,
              child: Text(
                "រំលង",
                style: TextStyle(fontSize: 18),
              ),
            ),
          ),
          Positioned(
            bottom: 40,
            right: 10,
            child: FlatButton(
              onPressed: currentIndex == 2 ? onFinish : _onNextBoard,
              child: Row(
                children: <Widget>[
                  Text(
                    "បន្ទាប់",
                    style: TextStyle(fontSize: 18),
                  ),
                  Icon(Icons.arrow_forward),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget customPagination (int index) {
    var currentHeight = MediaQuery.of(context).size.height;
    var currentWidth = MediaQuery.of(context).size.width;

    return Positioned(
      bottom: currentWidth < 321 ? currentHeight * 0.1 : currentHeight * 0.15,
      left: MediaQuery.of(context).size.width / 2- 30,
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 10,
              width: 10,
              decoration: BoxDecoration(
                color: index == 0 ? HexColor('#06AEB7') : HexColor('#CDEFF1'),
                borderRadius: BorderRadius.all(Radius.circular(5))
              ),
            ),
            SizedBox(width: 15),
            Container(
              height: 10,
              width: 10,
              decoration: BoxDecoration(
                  color: index == 1 ? HexColor('#06AEB7') : HexColor('#CDEFF1'),
                  borderRadius: BorderRadius.all(Radius.circular(5))
              ),
            ),
            SizedBox(width: 15),
            Container(
              height: 10,
              width: 10,
              decoration: BoxDecoration(
                  color: index == 2 ? HexColor('#06AEB7') : HexColor('#CDEFF1'),
                  borderRadius: BorderRadius.all(Radius.circular(5))
              ),
            ),
          ],
        ),
      ),
    );
  }
}
