import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:guitarfashion/model/FavoriteModel.dart';
import 'package:guitarfashion/model/Product.dart';
import 'package:guitarfashion/utils/Api.dart';
import 'package:guitarfashion/utils/HexColor.dart';
import 'package:guitarfashion/view/home/ProductDetail.dart';

class FavoriteCard extends StatefulWidget {
  FavoriteModel data;

  FavoriteCard(this.data);

  @override
  _FavoriteCardState createState() => _FavoriteCardState();
}

class _FavoriteCardState extends State<FavoriteCard> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => ProductDetail(widget.data.id)));
      },
      child: Container(
        height: 150,
        padding: EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
          border: Border.symmetric(
              vertical: BorderSide(width: 0.5, color: HexColor('#ECEFF0'))),
        ),
        child: Row(
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width * 0.4,
              height: 150,
              padding: EdgeInsets.all(8),
              child: Image.network(
                Api.mainUrl + widget.data.images[0].formats.medium.url,
                height: 120,
              ),
            ),
            Container(
              height: 150,
              width: MediaQuery.of(context).size.width * 0.4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "លេខកូដ: ${widget.data.code}",
                  ),
                  Text(
                    '\$52',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Container(
                    height: 35,
                    width: 35,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
//                  color: Colors.red,
                      border: Border.all(
                          width: 1, color: Color(getColorHexFromStr('#ECEFF0'))),
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                    ),
                    child: IconButton(
                      padding: EdgeInsets.zero,
                      onPressed: () {
                        print("test");
                      },
                      icon: Icon(Icons.favorite),
                      color: Colors.red,
                      iconSize: 24,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
