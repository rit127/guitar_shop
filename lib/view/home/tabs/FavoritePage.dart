import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:guitarfashion/model/FavoriteModel.dart';
import 'package:guitarfashion/model/Product.dart';
import 'package:guitarfashion/model/UserModel.dart';
import 'package:guitarfashion/repository/AuthRepository.dart';
import 'package:guitarfashion/repository/CategoryRepository.dart';
import 'package:guitarfashion/res.dart';
import 'package:guitarfashion/utils/Api.dart';
import 'package:guitarfashion/utils/AppColor.dart';
import 'package:guitarfashion/utils/HexColor.dart';
import 'package:guitarfashion/utils/Loading.dart';
import 'package:guitarfashion/view/auth/UnAuthorize.dart';
import 'package:guitarfashion/widget/FavoriteCard.dart';
import 'package:http/http.dart' as http;

class FavoritePage extends StatefulWidget {
  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> with AutomaticKeepAliveClientMixin<FavoritePage> {
  String userToken;
  List<FavoriteModel> listFavorite = new List<FavoriteModel>();
  bool isReady = false;

  @override
  void initState() {
    super.initState();
    onFirstLoad();
  }

  onFirstLoad() async {
    String token = await AuthRepository.getUserToken();

    userToken = token;

    if(token != null) {
      await onRequestFavorite();
    }else {
      setState(() {
        isReady = true;
      });
    }
  }

  onRequestFavorite() async {
    UserModel currentUser = await AuthRepository.getUser();
    String requestUrl = Api.customer + "/" + currentUser.customer.toString();
    print(requestUrl);
    var customer = await http.get(requestUrl);

    if (customer.statusCode == 200) {
      //Request Success 200
      var responseCustomer = jsonDecode(customer.body);
      Iterable list = responseCustomer['products__favorite'];
            List<FavoriteModel> myFavorite = list.map((e) => FavoriteModel.fromJson(e)).toList();
//      List<Product> myFavorite = list.map((e) async {
//        Brand cate = await CategoryRepository.getCategoryById(e.toString());
////        Product.fromJson(e);
//      }).toList();

      setState(() {
        listFavorite = myFavorite;
        isReady = true;
      });
    } else {
      print("StatusCode ${customer.statusCode}");
      setState(() {
        isReady = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!isReady) {
      return Center(
        child: Loading(),
      );
    }

    if (userToken == null) {
      return UnAuthorize();
    }

    return ListView.builder(
      itemCount: listFavorite.length,
      itemBuilder: (BuildContext context, int index) {
        return Column(
          children: <Widget>[
            index == 0 ? favoriteHeader() : Container(),
            FavoriteCard(listFavorite[index]),
          ],
        );
      },
    );
  }

  Widget favoriteHeader() {
    return Container(
      padding: EdgeInsets.all(12),
      child: Row(
        children: <Widget>[
          Icon(
            Icons.favorite_border,
            color: AppColor.guitarShopColor,
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            "ចូលចិត្ត",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => false;
}
