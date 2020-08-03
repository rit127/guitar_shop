import 'package:flutter/material.dart';
import 'package:guitarfashion/res.dart';

class BoardThree extends StatefulWidget {
  @override
  _BoardThreeState createState() => _BoardThreeState();
}

class _BoardThreeState extends State<BoardThree> {
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
              Res.on_board3,
              height: 450,
            ),
          ),
          SizedBox(height: 30),
          Text(
            "សន្សំពិន្ទុដើម្បីប្ដូរយករង្វាន់",
            style: TextStyle(
              fontSize: 28,
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
            child: Text(
              "គ្រាន់តែធ្វើការបញ្ជាទិញនូវសម្លៀកបំពាក់ណាមួយលោកអ្នកនឹងទទួលបានពិន្ទុសន្សំសម្រាប់ប្តូរយករង្វាន់",
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
