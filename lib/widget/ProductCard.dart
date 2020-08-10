import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guitarfashion/bloc/FavoriteBloc.dart';
import 'package:guitarfashion/bloc/ProductBloc.dart';
import 'package:guitarfashion/event/ProductEvent.dart';
import 'package:guitarfashion/model/FavoriteModel.dart';
import 'package:guitarfashion/model/Product.dart';
import 'package:guitarfashion/model/UserModel.dart';
import 'package:guitarfashion/repository/FavoriteRepository.dart';
import 'package:guitarfashion/repository/ProductRepository.dart';
import 'package:guitarfashion/state/FavoriteState.dart';
import 'package:guitarfashion/state/ProductState.dart';
import 'package:guitarfashion/theme/style.dart';
import 'package:guitarfashion/utils/Api.dart';
import 'package:guitarfashion/utils/AppEnum.dart';
import 'package:guitarfashion/utils/HexColor.dart';
import 'package:guitarfashion/view/home/ProductDetail.dart';

class ProductCard extends StatefulWidget {
  Product product;
  List<FavoriteModel> listFavorite;
  UserModel currentUser;
  Function onFavorite;
  ProductCard(
      {this.product, this.listFavorite, this.currentUser, this.onFavorite});

  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  bool isFav = false;

  @override
  void initState() {
    super.initState();
  }

  getFavorite(int id) {
    if (widget.listFavorite != null) {
      FavoriteModel myFavor = widget.listFavorite
          .firstWhere((element) => id == element.id, orElse: () => null);

      if (myFavor != null) {
        return true;
      }
    }
    return false;
  }

  unAuth () async {
    Navigator.pushNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (BuildContext context, ProductState state) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => ProductDetail(
                  widget.product.id,
                  widget.listFavorite,
                  widget.onFavorite,
                ),
              ),
            );
          },
          child: Container(
            margin: EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(width: 1, color: HexColor('#ECEFF0')),
            ),
            child: Stack(
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    CachedNetworkImage(
                      imageUrl: Api.mainUrl +
                          widget.product.image[0].formats.medium.url,
                      imageBuilder: (context, imageProvider) => Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Image.network(Api.mainUrl +
                            widget.product.image[0].formats.medium.url),
                      ),
                      placeholder: (context, url) => Container(
                        width: double.infinity,
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(height: 3),
                          Text(
                            "លេខកូដ: ${widget.product.code}",
                            style: TextStyle(
                              fontSize: 12,
                            ),
                          ),
                          Text(
                            '\$${widget.product.price.toString()}',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: HexColor('#E23B51'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Positioned(
                  right: 12,
                  top: 12,
                  child: Container(
                    height: 35,
                    width: 35,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
//                  color: Colors.red,
                      border: Border.all(width: 1, color: HexColor('#ECEFF0')),
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                    ),
                    child: GestureDetector(
//                  padding: EdgeInsets.zero,
                      onTap: widget.currentUser != null ? widget.onFavorite : unAuth,
                      child: Icon(
                        Icons.favorite,
                        color: getFavorite(widget.product.id)
                            ? HexColor('#E23B51')
                            : Colors.grey,
                        size: 24,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
