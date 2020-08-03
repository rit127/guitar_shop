import 'package:flutter/material.dart';
import 'package:guitarfashion/utils/AppColor.dart';

circularProgress() => Container(
  child: CircularProgressIndicator(
    valueColor: new AlwaysStoppedAnimation<Color>(AppColor.guitarShopColor),
  ),
);

loadingProgress(BuildContext context) => showDialog(
  barrierDismissible: false,
  context: context,
  child: Center(
    child: Container(
      height: 50,
      width: 50,
      child: circularProgress(),
    ),
  ),
);

showSuccessSnackBar({String successMessage}) => SnackBar(
  backgroundColor: Colors.green,
  content: Row(
    children: <Widget>[
      Icon(Icons.check_circle_outline),
      SizedBox(width: 20),
      Text(successMessage),
    ],
  ),
);

showErrorSnackBar({String errorMessage}) => SnackBar(
  backgroundColor: Colors.red,
  content: Row(
    children: <Widget>[
      Icon(Icons.error),
      SizedBox(width: 20),
      Expanded(
        child: Text(errorMessage),
      ),
    ],
  ),
);