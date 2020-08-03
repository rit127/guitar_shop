import 'dart:convert';

import 'package:guitarfashion/model/Product.dart';
import 'package:guitarfashion/utils/Api.dart';
import 'package:http/http.dart' as http;
import 'package:guitarfashion/model/CategoryMenu.dart';
import 'package:guitarfashion/view/menu/MenuScreen.dart';

class BrandsRepository {
  static Future<List<CategoryMenu>> fetchBrand() async {
    var response = await http.get(Api.brands);

    if(response.statusCode == 200) {
      //Request Success 200
      Iterable list = jsonDecode(response.body);
      List<CategoryMenu> listBrand = list.map((e) => CategoryMenu.fromJson(e)).toList();

      return listBrand;
    }

    return null;
  }

  static Future<List<Product>> fetchCategoryOfBrands(int categoryId, Map<int, int> selectedBrands) async {
    if(selectedBrands.length > 0) {
      String txtWhereIn = "";

      selectedBrands.forEach((key, value) {
        txtWhereIn += "&brand.id_in=$value";
      });

      var response = await http.get(Api.product + "?category.id=$categoryId$txtWhereIn");

      if(response.statusCode == 200) {
        //Request Status 200
        print(response.body);
        Iterable list = jsonDecode(response.body);
        List<Product> listCategoryOfBrands = list.map((e) => Product.fromJson(e)).toList();

        return listCategoryOfBrands;
      }
    }
    return null;
  }
}