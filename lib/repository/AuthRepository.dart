import 'dart:convert';

import 'package:guitarfashion/model/Customer.dart';
import 'package:guitarfashion/model/UserModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepository {

  static setUserToken(String userToken) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('userToken', userToken);
    return 'Done';
  }

  static Future<String> getUserToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('userToken');
  }

  static Future<bool> clearUserToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.remove('userToken');
  }

  static setCustomer(Customer customer) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setString('customer', jsonEncode(customer));
    return 'Done';
  }

  static Future<Customer> getCustomer () async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String customer = prefs.getString('customer');
    print("getCustomer $customer");
    Customer currentCustomer = Customer.fromJson( jsonDecode(customer));

    return currentCustomer;
  }

  static Future<bool> clearCustomer() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.remove('customer');
  }

  static setUser(UserModel customer) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setString('user', jsonEncode(customer));
    return 'Done';
  }

  static Future<UserModel> getUser () async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String user = prefs.getString('user');

    if(user != null) {
      UserModel currentUser = UserModel.fromJson(jsonDecode(user),'register');

      return currentUser;
    }

    return null;
  }

  static Future<bool> clearUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.remove('user');
  }

  static Future<String> getCurrentPassword() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('currentPassword');
  }

  static setCurrentPassword(String isFirstLoad) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('currentPassword', isFirstLoad);
    return 'Done';
  }

  static Future<bool> clearCurrentPassword() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.remove('currentPassword');
  }

  static Future<bool> getFirstLoad() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('first_load');
  }

  static setFirstLoad(bool isFirstLoad) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('first_load', isFirstLoad);
    return 'Done';
  }

}