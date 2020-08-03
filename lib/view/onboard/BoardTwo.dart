import 'package:flutter/material.dart';
import 'package:guitarfashion/res.dart';

class BoardTwo extends StatefulWidget {
  @override
  _BoardTwoState createState() => _BoardTwoState();
}

class _BoardTwoState extends State<BoardTwo> {
  @override
  Widget build(BuildContext context) {
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
              height: 450,
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
