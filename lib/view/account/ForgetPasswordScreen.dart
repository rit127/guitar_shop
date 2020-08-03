import 'package:flutter/material.dart';
import 'package:guitarfashion/res.dart';

class ForgetPasswordScreen extends StatefulWidget {
  @override
  _ForgetPasswordScreenState createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack(
            children: <Widget>[
              Column(
                children: <Widget>[
                  SizedBox(height: 50),
                  Container(
                    height: 130,
                    alignment: Alignment.center,
                    child: Image.asset(Res.logo),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 50),
                    child: Text(
                      "ភ្លេចពាក្យសម្ងាត់",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20,
                    ),
                    child: Text(
                      "សូមធ្វើការទំនាក់ទំនងទៅកាន់លេខទូរស័ព្ទខាងក្រោមក្រុមការងារយើងខ្ញុំនឹងធ្វើការដោះស្រាយជូន",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 30),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20,
                    ),
                    child: Text(
                      "លេខទូរស័ព្ទសម្រាប់ទំនាក់ទំនង:",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              width: 40,
                              child: Icon(
                                Icons.phone_in_talk,
                                color: Colors.red,
                              ),
                            ),
                            SizedBox(width: 12),
                            Text(
                              "012/016 733 567",
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                            SizedBox(width: 30),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              width: 40,
                            ),
                            SizedBox(width: 12),
                            Text(
                              "0888 733 567     ",
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                            SizedBox(width: 30),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              width: 40,
                            ),
                            SizedBox(width: 12),
                            Text(
                              "098/092 995 500",
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                            SizedBox(width: 30),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
              Positioned(
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back_ios,
                    size: 30,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
