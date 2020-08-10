import 'package:flutter/material.dart';
import 'package:guitarfashion/utils/AppColor.dart';

class UnAuthorize extends StatefulWidget {
  @override
  _UnAuthorizeState createState() => _UnAuthorizeState();
}

class _UnAuthorizeState extends State<UnAuthorize> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text("សូមធ្វើការចូល ដើម្បីប្រើប្រាស់មុខងារនេះ"),
        SizedBox(height: 8),
        Center(
          child: FlatButton(
            color: AppColor.guitarShopColor,
            onPressed: () {
              Navigator.pushNamed(context, '/login');
            },
            child: Text(
              "ចូល",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
