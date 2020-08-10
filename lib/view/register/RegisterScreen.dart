import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:guitarfashion/model/Customer.dart';
import 'package:guitarfashion/model/UserModel.dart';
import 'package:guitarfashion/repository/AuthRepository.dart';
import 'package:guitarfashion/res.dart';
import 'package:guitarfashion/utils/Api.dart';
import 'package:guitarfashion/utils/AppFont.dart';
import 'package:guitarfashion/utils/HexColor.dart';
import 'package:guitarfashion/utils/Utils.dart';
import 'package:guitarfashion/utils/Validation.dart';
import 'package:guitarfashion/view/home/HomeScreen.dart';
import 'package:http/http.dart' as http;

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;

  String _username;
  String _phoneNumber;
  String _password;
  String _confirmPassword;

  bool isShowPassword = true;
  bool isShowConfirmPassword = true;

  void _validateInputs() async {
    FocusScope.of(context).requestFocus(FocusNode());

    if (_formKey.currentState.validate()) {
//    If all data are correct then save data to out variables
      _formKey.currentState.save();
      loadingProgress(context);

      await Future.delayed(Duration(milliseconds: 300));

      print(_username);
      print(_phoneNumber);
      print(_password);
      onRegister();
//      Navigator.pushReplacement(
//          context,
//          MaterialPageRoute(
//              builder: (BuildContext context) => HomeScreen()));
    } else {
//    If all data are not valid then start auto validation.
      setState(() {
        _autoValidate = true;
      });
    }
  }

  onRegister() async {
    Map<String, String> body = {
      'username': _username.trim(),
      'email': _phoneNumber.trim() + "@kravanh.com",
      'password': _password.trim(),
    };

    var response = await http.post(Api.registerUser, body: body);

    if (response.statusCode == 200) {
      //Request Success 200
      var responseData = jsonDecode(response.body);
      AuthRepository.setUserToken(responseData['jwt']);

      onRegisterCustomer(responseData['user']['id'].toString());
    } else {
      var responseData = jsonDecode(response.body);

      Navigator.pop(context);

      String errorMSG = responseData["message"][0]["messages"][0]["message"];
      if(errorMSG == 'Email is already taken.')
        errorMSG = 'លេខទូរសព្ទរបស់អ្នកត្រូវបានចុះឈ្មោះរួចហើយ';
      _scaffoldKey.currentState
          .showSnackBar(showErrorSnackBar(errorMessage: errorMSG));
    }
  }

  onRegisterCustomer(String userId) async {
    Map<String, String> body = {
      'user': userId,
      'phone': _phoneNumber.trim(),
      'email': _phoneNumber.trim() + "@kravanh.com",
      'name': _username.trim(),
    };

    var response = await http.post(Api.registerCustomer, body: body);

    if (response.statusCode == 200) {
      //Request Success 200
      Navigator.pop(context);

      _scaffoldKey.currentState.showSnackBar(
          showSuccessSnackBar(successMessage: 'ប្រតិបត្តិការជោគជ័យ'));

      var myBody = jsonDecode(response.body);
      UserModel user = UserModel.fromJson(myBody['user'], 'register');
      AuthRepository.setUser(user);
      AuthRepository.setCurrentPassword(_password.trim());

      await Future.delayed(Duration(milliseconds: 500));

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => HomeScreen(),
        ),
      );
    }
  }

  onShowPassword (int index) {
    setState(() {
      if(index == 1) {
        isShowPassword = !isShowPassword;
      } else {
        isShowConfirmPassword = !isShowConfirmPassword;
      }
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
                  "ចុះឈ្មោះ",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 0),
                Form(
                  key: _formKey,
                  autovalidate: _autoValidate,
                  child: Container(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      children: <Widget>[
                        txtName(),
                        SizedBox(height: 15),
                        txtPhoneNumber(),
                        SizedBox(height: 15),
                        txtPassword(),
                        SizedBox(height: 15),
                        txtConfirmPassword(),
                        SizedBox(height: 30),
                        btnRegister(),
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
        )),
      ),
      bottomNavigationBar: Container(
        height: 60,
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("មានគណនីរួចហើយ ? "),
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, '/login');
              },
              child: Text(
                "ចូល",
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

  Widget txtName() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "ឈ្មោះ",
            style: TextStyle(
              fontSize: 16,
            ),
          ),
          SizedBox(height: 5),
          TextFormField(
            keyboardType: TextInputType.text,
            validator: (value) => Validation.validationUsername(value),
            onSaved: (String val) {
              _username = val;
            },
            maxLength: 30,
            maxLengthEnforced: true,
            decoration: InputDecoration(
              counterText: "",
              fillColor: Color(getColorHexFromStr('#ECEFF0')),
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide.none,
              ),
              prefixIcon: Icon(Icons.person,
                  color: Color(getColorHexFromStr('#8C8C8C')), size: 25.0),
              contentPadding: EdgeInsets.only(left: 15.0, top: 15.0),
//                  hintText: 'Phone',
//              hintStyle: TextStyle(color: Colors.grey, fontFamily: 'Quicksand'),
            ),
          ),
        ],
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
            keyboardType: TextInputType.phone,
            validator: (value) => Validation.validationPhoneNumber(value),
            onSaved: (String val) {
              _phoneNumber = val;
            },
            decoration: InputDecoration(
              fillColor: Color(getColorHexFromStr('#ECEFF0')),
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide.none,
              ),
              prefixIcon: Icon(Icons.phone,
                  color: Color(getColorHexFromStr('#8C8C8C')), size: 25.0),
              contentPadding: EdgeInsets.only(left: 15.0, top: 15.0),
//              hintText: '+855',
//              hintStyle: TextStyle(color: Colors.grey, fontFamily: 'Quicksand'),
            ),
          ),
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
              keyboardType: TextInputType.text,
              obscureText: isShowPassword,
              validator: (value) => Validation.validationPassword(value),
              onSaved: (String val) {
                _password = val;
              },
              onChanged: (String val) {
                _password = val;
              },
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
                      TextStyle(color: Colors.grey, fontFamily: 'Quicksand'),suffixIcon: IconButton(
                icon: Icon(
                  isShowPassword
                      ? Icons.visibility
                      : Icons.visibility_off,
                  color: Color(getColorHexFromStr('#8C8C8C')),
                  size: 25.0,
                ),
                onPressed: () => onShowPassword(1),
              ),)),
        ],
      ),
    );
  }

  Widget txtConfirmPassword() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "បញ្ជាក់ពាក្យសម្ងាត់",
            style: TextStyle(
              fontSize: 16,
            ),
          ),
          SizedBox(height: 5),
          TextFormField(
              keyboardType: TextInputType.text,
              obscureText: isShowConfirmPassword,
              validator: (value) => Validation.validationConfirmPassword(_password, value),
              onSaved: (String val) {
                _confirmPassword = val;
              },
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
                    isShowConfirmPassword
                        ? Icons.visibility
                        : Icons.visibility_off,
                    color: Color(getColorHexFromStr('#8C8C8C')),
                    size: 25.0,
                  ),
                  onPressed: () => onShowPassword(2),
                ),)),
        ],
      ),
    );
  }

  Widget btnRegister() {
    return Container(
      child: ButtonTheme(
        height: 50.0,
        minWidth: MediaQuery.of(context).size.width,
        child: RaisedButton.icon(
          shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(15.0),
          ),
          elevation: 0.0,
          color: Color(getColorHexFromStr('#0097A2')),
          icon: new Text(''),
          label: new Text(
            'ចុះឈ្មោះ',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              fontFamily: AppFont.mainFont,
            ),
          ),
          onPressed: _validateInputs,
        ),
      ),
    );
  }
}
