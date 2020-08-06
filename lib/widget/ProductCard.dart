import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:guitarfashion/model/FavoriteModel.dart';
import 'package:guitarfashion/model/Product.dart';
import 'package:guitarfashion/model/UserModel.dart';
import 'package:guitarfashion/repository/ProductRepository.dart';
import 'package:guitarfashion/theme/style.dart';
import 'package:guitarfashion/utils/Api.dart';
import 'package:guitarfashion/utils/HexColor.dart';
import 'package:guitarfashion/view/home/ProductDetail.dart';

class ProductCard extends StatefulWidget {
  Product product;
  List<FavoriteModel> listFavorite;
  UserModel currentUser;
  ProductCard({this.product, this.listFavorite, this.currentUser});

  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  bool isFav = false;

  @override
  void initState() {
    super.initState();
    onFirstLoad();
  }

  onFirstLoad() async {
    if (widget.listFavorite != null){
      FavoriteModel myFavor = widget.listFavorite.firstWhere(
          (element) => widget.product.id == element.id,
          orElse: () => null);
      if (myFavor != null) {
        setState(() {
          isFav = true;
        });
      }
    }

  }

  onFavorite() async {
    if(isFav) {
      // change to false ( Unfavorite )
      widget.listFavorite.removeWhere((element) => element.id == widget.product.id);
    }else {
      // change to true ( Favorite )
      FavoriteModel newFavorite = new FavoriteModel(
        id: widget.product.id,
      );

      widget.listFavorite.add(newFavorite);
    }

    await transaction(widget.listFavorite);

    setState(() {
      isFav = !isFav;
    });
  }

  transaction(List<FavoriteModel> list) async {
    await ProductRepository.onFavorite(widget.currentUser.customer.toString(), widget.listFavorite);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => ProductDetail(widget.product.id),
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
                  imageUrl:
                      Api.mainUrl + widget.product.image[0].formats.medium.url,
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
                  onTap: onFavorite,
                  child: Icon(
                    Icons.favorite,
                    color: isFav ? HexColor('#E23B51') : Colors.grey,
                    size: 24,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
