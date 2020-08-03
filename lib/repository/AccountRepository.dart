import 'dart:convert';

import 'package:guitarfashion/model/Customer.dart';
import 'package:guitarfashion/model/UserModel.dart';
import 'package:guitarfashion/repository/AuthRepository.dart';
import 'package:guitarfashion/utils/Api.dart';
import 'package:http/http.dart' as http;
class AccountRepository {

  static Future<Customer> fetchCustomer (String customerId) async {
    var response = await http.get(Api.customer + "/$customerId");

    if(response.statusCode == 200) {
      var responseData = jsonDecode(response.body);
      Customer myCustomer = Customer.fromJson(responseData);

      return myCustomer;
    }
    return null;
  }

  static onChangeUsername(String username, String customerId) async {
    Map<String, String> body = {
      'name': username.toString(),
    };

    String requestUrl = Api.customer + "/$customerId";

    print(requestUrl);

    var response = await http.put(requestUrl, body: body);

    print(response.body);

    if(response.statusCode == 200) {
      return 'Done';
    }

    return 'False';
  }

  static onChangePassword(String newPassword) async {
    UserModel userModel = await AuthRepository.getUser();
    String userToken = await AuthRepository.getUserToken();

    Map<String, String> headers = {
      'Accept': 'application/json',
      'Authorization': "Bearer $userToken",
    };

    Map<String, String> body = {
      'password': newPassword.trim(),
    };

    var response = await http.put(Api.user + "/${userModel.id}", headers: headers, body: body);

    if(response.statusCode == 200) {
      AuthRepository.setCurrentPassword(newPassword);

      print(response.body);

      return 'Done';
    }

    print(response.body);

    return response.body;
  }
}