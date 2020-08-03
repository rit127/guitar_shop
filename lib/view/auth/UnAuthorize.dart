import 'package:flutter/material.dart';
import 'package:guitarfashion/utils/AppColor.dart';

class UnAuthorize extends StatefulWidget {
  @override
  _UnAuthorizeState createState() => _UnAuthorizeState();
}

class _UnAuthorizeState extends State<UnAuthorize> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: FlatButton(
        color: AppColor.guitarShopColor,
        onPressed: () {
          Navigator.pushNamed(context, '/login');
        },
        child: Text(
          "Login",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
