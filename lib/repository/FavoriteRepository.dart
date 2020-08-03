import 'dart:convert';

import 'package:guitarfashion/model/FavoriteModel.dart';
import 'package:guitarfashion/utils/Api.dart';
import 'package:http/http.dart' as http;

class FavoriteRepository {

  static Future<List<FavoriteModel>> getListFavorite (String customerId) async {
    String requestUrl = Api.customer + "/" + customerId.toString();

    var response = await http.get(requestUrl);

    if(response.statusCode == 200) {
      //Request Success
      var responseCustomer = jsonDecode(response.body);
      Iterable list = responseCustomer['products__favorite'];
      List<FavoriteModel> myFavorite = list.map((e) => FavoriteModel.fromJson(e)).toList();

      return myFavorite;
    }

    return null;
  }
}