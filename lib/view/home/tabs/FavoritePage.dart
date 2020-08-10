import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guitarfashion/bloc/FavoriteBloc.dart';
import 'package:guitarfashion/bloc/ProductBloc.dart';
import 'package:guitarfashion/event/FavoriteEvent.dart';
import 'package:guitarfashion/event/ProductEvent.dart';
import 'package:guitarfashion/model/FavoriteModel.dart';
import 'package:guitarfashion/model/Product.dart';
import 'package:guitarfashion/model/UserModel.dart';
import 'package:guitarfashion/repository/AuthRepository.dart';
import 'package:guitarfashion/repository/CategoryRepository.dart';
import 'package:guitarfashion/res.dart';
import 'package:guitarfashion/state/FavoriteState.dart';
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

class _FavoritePageState extends State<FavoritePage>
    with AutomaticKeepAliveClientMixin<FavoritePage> {
  String userToken;
  List<FavoriteModel> listFavorite = new List<FavoriteModel>();
  bool isReady = false;
  UserModel currentUser;
  @override
  void initState() {
    super.initState();
    onFirstLoad();
  }

  onFirstLoad() async {
    String token = await AuthRepository.getUserToken();
    UserModel myUser = await AuthRepository.getUser();

    userToken = token;
    currentUser = myUser;

    if (token != null) {
      context.bloc<FavoriteBloc>().add(LoadData());
      context.bloc<ProductBloc>().add(LoadFavoriteProduct());
      setState(() {});
    } else {
      setState(() {
        isReady = true;
      });
    }
  }

  onRequestFavorite() async {
    UserModel currentUser = await AuthRepository.getUser();
    String requestUrl = Api.customer + "/" + currentUser.customer.toString();
    var customer = await http.get(requestUrl);
//    print("customer ${customer.body} ");

    if (customer.statusCode == 200) {
      //Request Success 200
      var responseCustomer = jsonDecode(customer.body);
      Iterable list = responseCustomer['products__favorite'];
      print("list $list");
      List<FavoriteModel> myFavorite =
          list.map((e) => FavoriteModel.fromJson(e)).toList();
      print('myFavorite $myFavorite');
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

  Future<void> onRefresh () async {
    await Future.delayed(Duration(seconds: 1), () async {
      context.bloc<ProductBloc>().add(LoadFavoriteProduct());
    });
  }

  @override
  Widget build(BuildContext context) {
    if (userToken == null) {
      return UnAuthorize();
    }

    return BlocBuilder<FavoriteBloc, FavoriteState>(
      builder: (BuildContext context, FavoriteState state) {
        if (state.listFavorite == null) {
          return Center(
            child: Loading(),
          );
        }
        return RefreshIndicator(
          onRefresh: onRefresh,
          child: ListView(
            children: <Widget>[
              favoriteHeader(),
              ListView.builder(
                reverse: true,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: state.listFavorite.length,
                itemBuilder: (BuildContext context, int index) {
                  return FavoriteCard(
                      state.listFavorite[index], currentUser.customer.toString());
                },
              ),
            ],
          ),
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
