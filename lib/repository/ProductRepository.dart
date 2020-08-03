import 'dart:convert';

import 'package:guitarfashion/model/FavoriteModel.dart';
import 'package:guitarfashion/model/Product.dart';
import 'package:guitarfashion/utils/Api.dart';
import 'package:http/http.dart' as http;

class ProductRepository {

  static Future<List<Product>> getProduction() async {
    var response = await http.get(Api.product + "?_sort=id:DESC");

    if(response.statusCode == 200) {
      //Request Success 200
      Iterable data = jsonDecode(response.body);
      List<Product> listProduct = data.map((item) => Product.fromJson(item)).toList();

      print(listProduct.length);
      return listProduct;
    }

    return [];
  }

  static onFavorite(String customerId, List<FavoriteModel> listFavorite) async {

    Map<String, String> headers = {
      'Accept': 'application/json',
      'Authorization': "Bearer",
    };

    String body = "";

    if(listFavorite.length > 0) {
      listFavorite.map((e){
//        body += "\"products__favorite\"" + ":\"${e.id}\",";
        body += "products__favorite=${e.id}&";
      }).toList();

      body = "${body.substring(0, body.length-1)}";

    }else {
      body = "{}";
    }

    print(body);
//    print(jsonDecode(body));
//    var submitBody = jsonDecode(body);

    var response = await http.put(Api.customer + "/$customerId", body: body);
    print(response.body);

    if(response.statusCode == 200) {

      return 'Success';
    }

    return 'Fail';
  }
}