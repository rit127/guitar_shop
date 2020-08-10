import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guitarfashion/bloc/AccountBloc.dart';
import 'package:guitarfashion/event/AccountEvent.dart';
import 'package:guitarfashion/model/Customer.dart';
import 'package:guitarfashion/model/UserModel.dart';
import 'package:guitarfashion/repository/AccountRepository.dart';
import 'package:guitarfashion/repository/AuthRepository.dart';
import 'package:guitarfashion/res.dart';
import 'package:guitarfashion/state/AccountState.dart';
import 'package:guitarfashion/utils/Api.dart';
import 'package:guitarfashion/utils/HexColor.dart';
import 'package:guitarfashion/utils/Utils.dart';
import 'package:guitarfashion/utils/Validation.dart';
import 'package:http/http.dart' as http;

class EditScreen extends StatefulWidget {
  final String username;

  EditScreen(this.username);

  @override
  _EditScreenState createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  TextEditingController _tabUsername = new TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;

  String _username;

  @override
  void initState() {
    super.initState();
    setState(() {
      _tabUsername.text = widget.username;
    });
  }

  void _validateInputs() async {
    FocusScope.of(context).requestFocus(FocusNode());

    if (_formKey.currentState.validate()) {
//    If all data are correct then save data to out variables
      _formKey.currentState.save();
      loadingProgress(context);

      await Future.delayed(Duration(milliseconds: 300));

      print(_username);

      onUpdateUsername();
    } else {
//    If all data are not valid then start auto validation.
      setState(() {
        _autoValidate = true;
      });
    }
  }

  onUpdateUsername() async {
    UserModel myUser = await AuthRepository.getUser();

    await AccountRepository.onChangeUsername(_username, myUser.customer.toString());

    context.bloc<AccountBloc>().add(LoadCustomer(myUser.customer.toString()));

    await Future.delayed(Duration(milliseconds: 500));

    Navigator.pop(context);
    Navigator.pop(context);
//    var response = await http.put(Api.customer, body: body);
//
//    if(response.statusCode == 200) {
//
//      var responseData = jsonDecode(response.body);
//      Customer myCustomer = Customer.fromJson(responseData);
//      AuthRepository.setCustomer(myCustomer);
//
//      Navigator.pop(context);
//
//      await Future.delayed(Duration(milliseconds: 300));
//
//    }

    //      Navigator.pushReplacement(
//          context,
//          MaterialPageRoute(
//              builder: (BuildContext context) => HomeScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AccountBloc, AccountState>(
      builder: (BuildContext context, AccountState state) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Container(
              height: 55,
              child: Image.asset(Res.logo),
            ),
          ),
          body: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(top: 30),
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      child: Text(
                        "កែប្រែគណនី",
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),
                    SizedBox(height: 25),
                    Container(
                      height: 150,
                      child: Stack(
                        children: <Widget>[
                          Container(
                            height: 120,
//                          width: 100,
                            child: Image.asset(
                              Res.account,
                            ),
                          ),
                          Positioned(
                            bottom: 35,
                            right: 0,
                            child: Container(
                              height: 40,
                              child: Image.asset(Res.change_image),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Form(
                      key: _formKey,
                      autovalidate: _autoValidate,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "ឈ្មោះ",
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                            SizedBox(height: 5),
                            TextFormField(
                              keyboardType: TextInputType.text,
                              controller: _tabUsername,
                              validator: (value) =>
                                  Validation.validationUsername(value),
                              onSaved: (value) {
                                _username = value.trim();
                              },
                              maxLength: 30,
                              decoration: InputDecoration(
                                counterText: "",
                                fillColor: HexColor('#ECEFF0'),
                                filled: true,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: BorderSide.none),
                                contentPadding:
                                EdgeInsets.only(left: 15.0, top: 15.0),
                                prefixIcon: Icon(Icons.person,
                                    color: Color(getColorHexFromStr('#8C8C8C')),
                                    size: 25.0),
                                hintText: 'Username',
                                hintStyle: TextStyle(
                                  color: Colors.grey,
                                  fontFamily: 'Quicksand',
                                ),
                              ),
                            ),
                            SizedBox(height: 30),
                            btnEdit(),
                          ],
                        ),
                      ),
                    ),
                  ],
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
