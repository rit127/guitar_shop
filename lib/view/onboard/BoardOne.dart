import 'package:flutter/material.dart';
import 'package:guitarfashion/res.dart';
import 'package:guitarfashion/utils/HexColor.dart';

class BoardOne extends StatefulWidget {
  @override
  _BoardOneState createState() => _BoardOneState();
}

class _BoardOneState extends State<BoardOne> {
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
              Res.on_board1,
              height: 450,
            ),
          ),
          SizedBox(height: 30),
          Text(
            "បញ្ជាទិញតាមអ៊ីនធឺណិត",
            style: TextStyle(
              fontSize: 28,
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
            child: Text(
              "លោកអ្នកអាចមើលទំនិញដោយផ្ទាល់នៅលើ ទូរស័ព្ទដៃនិងអាចធ្វើការបញ្ជាទិញផងដែរ",
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
