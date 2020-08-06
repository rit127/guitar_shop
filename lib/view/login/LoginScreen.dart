import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:guitarfashion/model/Customer.dart';
import 'package:guitarfashion/model/UserModel.dart';
import 'package:guitarfashion/repository/AuthRepository.dart';
import 'package:guitarfashion/repository/FavoriteRepository.dart';
import 'package:guitarfashion/res.dart';
import 'package:guitarfashion/utils/Api.dart';
import 'package:guitarfashion/utils/HexColor.dart';
import 'package:guitarfashion/utils/Utils.dart';
import 'package:guitarfashion/utils/Validation.dart';
import 'package:guitarfashion/view/home/HomeScreen.dart';
import 'package:http/http.dart' as http;

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  String phone = "";
  String password = "";

  bool isShowPassword = true;

  onLogin() async {

    FocusScope.of(context).requestFocus(FocusNode());

    loadingProgress(context);

    await Future.delayed(Duration(milliseconds: 300));

    Map<String, String> body = {
      'identifier': phone.trim() + "@kravanh.com",
      'password': password.toString(),
    };

    var response = await http.post(Api.login, body: body);

    if (response.statusCode == 200) {
      var responseData = jsonDecode(response.body);

      Navigator.pop(context);

      if(responseData['user']['customer'] == null) {

        _scaffoldKey.currentState.showSnackBar(showErrorSnackBar(errorMessage: 'ប្រតិបត្តិការបរាជ័យ'));
        return;
      } else {
        //get list favorite product of customer
        int customerId = responseData['user']['customer']['id'];
        FavoriteRepository.getFavoriteProductAndSetToPref(customerId);

      }

      AuthRepository.setUserToken(responseData['jwt']);
      UserModel myUser = UserModel.fromJson(responseData['user'], 'login');

      AuthRepository.setUser(myUser);

      AuthRepository.setCurrentPassword(password.trim());

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => HomeScreen(),
        ),
      );
    } else {
      print(response.body);

      Navigator.pop(context);

      String errorMessage = "ប្រតិបត្តិការបរាជ័យ";
      _scaffoldKey.currentState
          .showSnackBar(showErrorSnackBar(errorMessage: errorMessage));
    }
  }

  onShowPassword () {
    setState(() {
      isShowPassword = !isShowPassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack(
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  SizedBox(height: 50),
                  Container(
//              color: Colors.red,
                    height: 120,
                    width: double.infinity,
                    child: Image.asset(Res.logo),
                  ),
                  Text(
                    "ហាងលក់សម្លៀកបំពាក់ហ្គីតា សូមស្វាគមន៍",
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    "ចូលប្រើ",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 0),
                  Form(
                    child: Container(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        children: <Widget>[
                          txtPhoneNumber(),
                          SizedBox(height: 15),
                          txtPassword(),
                          SizedBox(height: 15),
                          btnForgetPassword(),
                          SizedBox(height: 15),
                          btnLogin(),
                          SizedBox(height: 15),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              Positioned(
                top: 12,
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.arrow_back_ios),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 60,
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("មិនទាន់មានគណនី ? "),
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, '/register');
              },
              child: Text(
                "ចុះឈ្មោះ",
                style: TextStyle(
                  color: Color(getColorHexFromStr('#0097A2')),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget txtPhoneNumber() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "លេខទូរសព្ទ",
            style: TextStyle(
              fontSize: 16,
            ),
          ),
          SizedBox(height: 5),
          TextFormField(
              onChanged: (value) {
                setState(() {
                  phone = value;
                });
              },
              keyboardType: TextInputType.phone,
//          validator: validations.validateMobile,
              decoration: InputDecoration(
                  fillColor: Color(getColorHexFromStr('#ECEFF0')),
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: EdgeInsets.only(left: 15.0, top: 15.0),
                  hintText: '+855',
                  hintStyle:
                      TextStyle(color: Colors.grey, fontFamily: 'Quicksand'))),
        ],
      ),
    );
  }

  Widget txtPassword() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "ពាក្យសម្ងាត់",
            style: TextStyle(
              fontSize: 16,
            ),
          ),
          SizedBox(height: 5),
          TextFormField(
              onChanged: (value) {
                setState(() {
                  password = value;
                });
              },
              keyboardType: TextInputType.text,
              obscureText: isShowPassword,
              validator: (value) => Validation.validationPassword(value),
              decoration: InputDecoration(
                  fillColor: Color(getColorHexFromStr('#ECEFF0')),
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide.none,
                  ),
                  prefixIcon: Icon(Icons.lock_open,
                      color: Color(getColorHexFromStr('#8C8C8C')), size: 25.0),
                  contentPadding: EdgeInsets.only(left: 15.0, top: 15.0),
//                  hintText: 'Phone',
                  hintStyle:
                      TextStyle(color: Colors.grey, fontFamily: 'Quicksand'),
                suffixIcon: IconButton(
                  icon: Icon(
                    isShowPassword
                        ? Icons.visibility
                        : Icons.visibility_off,
                    color: Color(getColorHexFromStr('#8C8C8C')),
                    size: 25.0,
                  ),
                  onPressed: () => onShowPassword(),
                ),)),
        ],
      ),
    );
  }

  Widget btnForgetPassword() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 6),
      alignment: Alignment.centerRight,
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, '/forget_password');
        },
        child: Text(
          "ភ្លេចពាក្យសម្ងាត់ ?",
          style: TextStyle(
            color: Color(getColorHexFromStr('#0097A2')),
          ),
        ),
      ),
    );
  }

  Widget btnLogin() {
    return Container(
      child: ButtonTheme(
        height: 50.0,
        minWidth: MediaQuery.of(context).size.width,
        child: RaisedButton.icon(
          shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(15.0)),
          elevation: 0.0,
          color: Color(getColorHexFromStr('#0097A2')),
          icon: new Text(''),
          label: new Text(
            'ចូល',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              fontFamily: "OpenSans",
            ),
          ),
          onPressed: onLogin,
//          onPressed: () {
//            print("Phone $phone");
//            print("Password $password");
//            Navigator.pushReplacement(
//              context,
//              MaterialPageRoute(
//                builder: (BuildContext context) => HomeScreen(),
//              ),
//            );
//          },
        ),
      ),
    );
  }
}
