import 'dart:convert';

import 'package:guitarfashion/model/FavoriteModel.dart';
import 'package:guitarfashion/utils/Api.dart';
import 'package:guitarfashion/utils/AppEnum.dart';
import 'package:http/http.dart' as http;

import 'AuthRepository.dart';

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

  static Future<List<FavoriteModel>> getListFavoritePagination ({String customerId, int start, int end}) async {
    String requestUrl = Api.customer + "/" + customerId.toString() + "?_start=$start&_end=$end";

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

  static Future<Favorite> updateFavorite(int productId, String customerId) async {
    Favorite favorite;
    List<int> customerFavorite  = await AuthRepository.getFavorite();
    print("before $customerFavorite");
    /// unFavorite
    if (customerFavorite.contains(productId)){
        customerFavorite.remove(productId);
        favorite = Favorite.unFavorite;
        await AuthRepository.setFavorite(customerFavorite);
    } else {
      /// favorite
      customerFavorite.add(productId);
      favorite = Favorite.favorite;
      await AuthRepository.setFavorite(customerFavorite);
    }

    var proId = customerFavorite.join(",");
    var body = "{\"products__favorite\": [$proId]}";
    print("body: $body");

    String customerInfoEndpoint = "${Api.customer}/$customerId";
    var res = await http.put(customerInfoEndpoint, body: body);

    // return res.statusCode == 200 ? true : false;
    return favorite;
  }

  static getFavoriteProductAndSetToPref(int customerId) async {
    //get list favorite product of customer
    String customerInfoEndpoint = "${Api.customer}/$customerId";
    var customerInfo = await http.get(customerInfoEndpoint);
    if (customerInfo.statusCode == 200){
      var customerDecode = jsonDecode(customerInfo.body);

      List<dynamic> productsFavorite = customerDecode['products__favorite'];
      List<int> productId = List();
      productsFavorite.forEach((item) => productId.add(item['id']));
      var setResult = await AuthRepository.setFavorite(productId);
      print("setResult $setResult");
    }
  }


}