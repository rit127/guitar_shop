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
import 'package:guitarfashion/repository/FavoriteRepository.dart';
import 'package:guitarfashion/state/FavoriteState.dart';
import 'package:guitarfashion/utils/Api.dart';
import 'package:guitarfashion/utils/AppEnum.dart';
import 'package:guitarfashion/utils/HexColor.dart';
import 'package:guitarfashion/view/home/ProductDetail.dart';
import 'package:http/http.dart' as http;

class FavoriteCard extends StatefulWidget {
  String customerId;
  FavoriteModel data;
  FavoriteCard(this.data, this.customerId);

  @override
  _FavoriteCardState createState() => _FavoriteCardState();
}

class _FavoriteCardState extends State<FavoriteCard> {
//  onViewDetail () {
//    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => ProductDetail(widget.data.id, list)));
//  }

  onSubmitChange() async {
    Favorite favorite = await FavoriteRepository.updateFavorite(
        widget.data.id, widget.customerId);

    if (favorite == Favorite.unFavorite) {
      context.bloc<FavoriteBloc>().add(UnFavorite(widget.data));
      context
          .bloc<ProductBloc>()
          .add(UpdateFavorite(widget.data.id.toString(), false));
    } else {
      context.bloc<FavoriteBloc>().add(onFavorite(widget.data));
      context
          .bloc<ProductBloc>()
          .add(UpdateFavorite(widget.data.id.toString(), true));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoriteBloc, FavoriteState>(
        builder: (BuildContext context, FavoriteState state) {
      return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => ProductDetail(
                widget.data.id,
                state.listFavorite,
                onSubmitChange,
              ),
            ),
          );
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
                      '\$${widget.data.price}',
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
                            width: 1,
                            color: Color(getColorHexFromStr('#ECEFF0'))),
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                      ),
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: onSubmitChange,
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
    });
  }
}
