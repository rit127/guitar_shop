import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guitarfashion/bloc/AccountBloc.dart';
import 'package:guitarfashion/repository/AccountRepository.dart';
import 'package:guitarfashion/repository/AuthRepository.dart';
import 'package:guitarfashion/res.dart';
import 'package:guitarfashion/state/AccountState.dart';
import 'package:guitarfashion/utils/HexColor.dart';
import 'package:guitarfashion/utils/Utils.dart';
import 'package:guitarfashion/utils/Validation.dart';

class ChangePasswordScreen extends StatefulWidget {
  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;

  String oldPassword;
  String newPassword;
  String confirmPassword;

  String currentPassword;

  bool isShowOldPassword = true;
  bool isShowNewPassword = true;
  bool isShowConfirmPassword = true;

  @override
  void initState() {
    super.initState();
    onFirstLoad();
  }

  onFirstLoad() async {
    currentPassword = await AuthRepository.getCurrentPassword();
    print("currentPassword $currentPassword");
  }

  void _validateInputs() async {
    FocusScope.of(context).requestFocus(FocusNode());

    if (_formKey.currentState.validate()) {
//    If all data are correct then save data to out variables
      _formKey.currentState.save();
      loadingProgress(context);

      await Future.delayed(Duration(milliseconds: 300));

      onChangePassword();
    } else {
//    If all data are not valid then start auto validation.
      setState(() {
        _autoValidate = true;
      });
    }
  }

  onChangePassword() async {
    if (oldPassword.trim() != currentPassword.trim()) {
      //Invalid Old Password
      await Future.delayed(Duration(milliseconds: 300));

      Navigator.pop(context);

      _scaffoldKey.currentState.showSnackBar(
          showErrorSnackBar(errorMessage: 'Old Password Not Match.'));
    } else {
      print("test");
      await AccountRepository.onChangePassword(newPassword);

      await Future.delayed(Duration(milliseconds: 300));

      Navigator.pop(context);
      Navigator.pop(context);
    }
  }

  onShowPassword(int index) {
    if (index == 1) {
      //Old
      isShowOldPassword = !isShowOldPassword;
    } else if (index == 2) {
      //New
      isShowNewPassword = !isShowNewPassword;
    } else {
      //Confirm
      isShowConfirmPassword = !isShowConfirmPassword;
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AccountBloc, AccountState>(
      builder: (BuildContext context, AccountState state) {
        return Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
            centerTitle: true,
            title: Container(
              height: 55,
              child: Image.asset(Res.logo),
            ),
          ),
          body: ListView(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(top: 30),
                width: double.infinity,
                child: Form(
                  key: _formKey,
                  autovalidate: _autoValidate,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        child: Text(
                          "ប្តូរពាក្យសម្ងាត់",
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ),
                      SizedBox(height: 50),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "ពាក្យសម្ងាត់ចាស់",
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(height: 5),
                            TextFormField(
                              obscureText: isShowOldPassword,
                              keyboardType: TextInputType.text,
                              validator: (value) =>
                                  Validation.validationPassword(value),
                              onSaved: (value) {
                                oldPassword = value;
                              },
                              decoration: InputDecoration(
                                fillColor: HexColor('#ECEFF0'),
                                filled: true,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: BorderSide.none),
                                contentPadding:
                                    EdgeInsets.only(left: 15.0, top: 15.0),
                                prefixIcon: Icon(
                                  Icons.lock_open,
                                  color: Color(getColorHexFromStr('#8C8C8C')),
                                  size: 25.0,
                                ),
                                hintStyle: TextStyle(
                                  color: Colors.grey,
                                  fontFamily: 'Quicksand',
                                ),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    isShowOldPassword
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: Color(getColorHexFromStr('#8C8C8C')),
                                    size: 25.0,
                                  ),
                                  onPressed: () => onShowPassword(1),
                                ),
                              ),
                            ),
                            SizedBox(height: 30),
                            Text(
                              "ពាក្យសម្ងាត់ថ្មី",
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(height: 5),
                            TextFormField(
                              obscureText: isShowNewPassword,
                              keyboardType: TextInputType.text,
                              validator: (value) =>
                                  Validation.validationPassword(value),
                              onChanged: (value) {
                                setState(() {
                                  newPassword = value.trim();
                                });
                              },
                              decoration: InputDecoration(
                                fillColor: HexColor('#ECEFF0'),
                                filled: true,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: BorderSide.none,
                                ),
                                contentPadding:
                                    EdgeInsets.only(left: 15.0, top: 15.0),
                                prefixIcon: Icon(
                                  Icons.lock_open,
                                  color: Color(getColorHexFromStr('#8C8C8C')),
                                  size: 25.0,
                                ),
                                hintStyle: TextStyle(
                                  color: Colors.grey,
                                  fontFamily: 'Quicksand',
                                ),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    isShowNewPassword
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: Color(getColorHexFromStr('#8C8C8C')),
                                    size: 25.0,
                                  ),
                                  onPressed: () => onShowPassword(2),
                                ),
                              ),
                            ),
                            SizedBox(height: 30),
                            Text(
                              "បញ្ជាក់សម្ងាត់ថ្មី",
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(height: 5),
                            TextFormField(
                              obscureText: isShowConfirmPassword,
                              keyboardType: TextInputType.text,
                              validator: (value) =>
                                  Validation.validationConfirmPassword(
                                      value, newPassword),
                              decoration: InputDecoration(
                                fillColor: HexColor('#ECEFF0'),
                                filled: true,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: BorderSide.none,
                                ),
                                contentPadding:
                                    EdgeInsets.only(left: 15.0, top: 15.0),
                                prefixIcon: Icon(
                                  Icons.lock_open,
                                  color: Color(getColorHexFromStr('#8C8C8C')),
                                  size: 25.0,
                                ),
                                hintStyle: TextStyle(
                                  color: Colors.grey,
                                  fontFamily: 'Quicksand',
                                ),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    isShowConfirmPassword
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: Color(getColorHexFromStr('#8C8C8C')),
                                    size: 25.0,
                                  ),
                                  onPressed: () => onShowPassword(3),
                                ),
                              ),
                            ),
                            SizedBox(height: 50),
                            btnEdit(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget btnEdit() {
    return Container(
      child: ButtonTheme(
        height: 50.0,
        minWidth: MediaQuery.of(context).size.width,
        child: RaisedButton.icon(
          shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(5.0),
          ),
//          elevation: 0.0,
          color: Color(getColorHexFromStr('#0097A2')),
          icon: new Text(''),
          label: new Text(
            'កែប្រែ',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              fontFamily: "OpenSans",
            ),
          ),
          onPressed: _validateInputs,
        ),
      ),
    );
  }
}
