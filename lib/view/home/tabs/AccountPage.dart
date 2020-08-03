import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guitarfashion/bloc/AccountBloc.dart';
import 'package:guitarfashion/event/AccountEvent.dart';
import 'package:guitarfashion/model/Customer.dart';
import 'package:guitarfashion/model/UserModel.dart';
import 'package:guitarfashion/repository/AuthRepository.dart';
import 'package:guitarfashion/res.dart';
import 'package:guitarfashion/state/AccountState.dart';
import 'package:guitarfashion/utils/Api.dart';
import 'package:guitarfashion/utils/HexColor.dart';
import 'package:guitarfashion/utils/Loading.dart';
import 'package:guitarfashion/utils/Utils.dart';
import 'package:guitarfashion/view/auth/UnAuthorize.dart';
import 'package:guitarfashion/view/home/HomeScreen.dart';
import 'package:http/http.dart' as http;

class AccountPage extends StatefulWidget {
  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  UserModel currentUser;
  Customer currentCustomer;
  String userToken;

  bool isReady = false;
  @override
  void initState() {
    super.initState();
    onFirstLoad();
  }

  onFirstLoad() async {
    String token = await AuthRepository.getUserToken();

    if(token != null) {
      UserModel myUser = await AuthRepository.getUser();
      currentUser = myUser;
      context.bloc<AccountBloc>().add(LoadCustomer(myUser.customer.toString()));
    } else {
      //UnAuth
      context.bloc<AccountBloc>().add(FinishLoadData());
    }

    setState(() {
      userToken = token;
    });

//    await onRequestCustomer();
  }

  onRequestCustomer() async {
    String requestUrl = Api.customer + "/" + currentUser.customer.toString();
    print(requestUrl);
    var customer = await http.get(requestUrl);

    if (customer.statusCode == 200) {
      //Request Success 200
      var responseCustomer = jsonDecode(customer.body);
      Customer myCustomer = Customer.fromJson(responseCustomer);

      setState(() {
        currentCustomer = myCustomer;
        isReady = true;
      });
    } else {
      print("StatusCode ${customer.statusCode}");
    }
  }

  onLogout() async {
    loadingProgress(context);

    await AuthRepository.clearUserToken();
    await AuthRepository.clearUser();
    await AuthRepository.clearCurrentPassword();
    await AuthRepository.clearCustomer();

    await Future.delayed(Duration(milliseconds: 300));

    Navigator.pop(context);

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => HomeScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
//    if(!isReady) {
//      return Center(
//        child: Loading(),
//      );
//    }

    return BlocBuilder<AccountBloc, AccountState>(
      builder: (BuildContext context, AccountState state) {
        if (state.isLoading) {
          return Center(
            child: Loading(),
          );
        }

        if (userToken == null) {
          return UnAuthorize();
        }

        return Column(
          children: <Widget>[
            Container(
              height: 250,
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    height: 120,
                    child: Stack(
                      children: <Widget>[
                        Container(
                          height: 100,
//                          width: 100,
                          child: Image.asset(
                            Res.account,
                          ),
                        ),
                        Positioned(
                          bottom: 12,
                          right: 0,
                          child: Container(
                            height: 40,
                            child: Image.asset(Res.change_image),
                          ),
                        ),
                      ],
                    ),
                  ),
                  state.customer != null
                      ? Container(
                          child: Text(
                            state.customer.name,
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        )
                      : Container(),
                  SizedBox(height: 8),
                  state.customer != null
                      ? Container(
                          child: Text(
                            state.customer.phone,
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        )
                      : Container(),
                ],
              ),
            ),
            ListTile(
              onTap: () {
                Navigator.pushNamed(context, '/edit',
                    arguments: state.customer.name);
              },
              leading: Icon(Icons.edit),
              title: Text(
                "កែប្រែព័ត៌មានគណនី",
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              trailing: Icon(Icons.arrow_forward_ios),
            ),
            underLine(),
            ListTile(
              onTap: () {
                Navigator.pushNamed(context, '/change_password');
              },
              leading: Icon(Icons.vpn_key),
              title: Text(
                "ប្តូលេខសំងាត់",
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              trailing: Icon(Icons.arrow_forward_ios),
            ),
            underLine(),
            ListTile(
              onTap: onLogout,
              leading: Icon(Icons.exit_to_app),
              title: Text(
                "ចាកចេញ",
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              trailing: Icon(Icons.arrow_forward_ios),
            ),
            underLine(),
          ],
        );
      },
    );
  }

  Widget underLine() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Divider(
        height: 2,
        thickness: 1,
      ),
    );
  }
}
