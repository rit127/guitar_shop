import 'dart:convert';

import 'package:guitarfashion/model/CategoryMenu.dart';
import 'package:guitarfashion/model/Product.dart';
import 'package:guitarfashion/utils/Api.dart';
import 'package:http/http.dart' as http;

class CategoryRepository {

  static Future<List<CategoryMenu>> fetchAllCategory () async {
    var response = await http.get(Api.category);

    if(response.statusCode == 200) {
      Iterable data = jsonDecode(response.body);
      List<CategoryMenu> listCategory = data.map((e) => CategoryMenu.fromJson(e)).toList();

      return listCategory;
    }
    return null;
  }

   static Future<Brand> getCategoryById (String catId) async {
    String requestUrl = Api.category + "/$catId";
    var response = await http.get(requestUrl);

    if(response.statusCode == 200) {
      //Request Success 200
      var responseData = jsonDecode(response.body);
      Brand category = Brand.fromJson(responseData);
      return category;
    }

    return null;
  }
}