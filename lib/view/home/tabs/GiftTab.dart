import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guitarfashion/bloc/ProductBloc.dart';
import 'package:guitarfashion/event/FavoriteEvent.dart';
import 'package:guitarfashion/event/ProductEvent.dart';
import 'package:guitarfashion/model/FavoriteModel.dart';
import 'package:guitarfashion/model/Product.dart';
import 'package:guitarfashion/model/RewardModel.dart';
import 'package:guitarfashion/model/UserModel.dart';
import 'package:guitarfashion/repository/AuthRepository.dart';
import 'package:guitarfashion/repository/FavoriteRepository.dart';
import 'package:guitarfashion/state/ProductState.dart';
import 'package:guitarfashion/utils/Api.dart';
import 'package:guitarfashion/utils/Loading.dart';
import 'package:guitarfashion/widget/GiftCard.dart';
import 'package:http/http.dart' as http;

class GiftTab extends StatefulWidget {
  List<FavoriteModel> listFavorite;
  UserModel currentUser;

  GiftTab(this.listFavorite, this.currentUser);

  @override
  _GiftTabState createState() => _GiftTabState();
}

class _GiftTabState extends State<GiftTab> {
  List<RewardModel> listReward;

  bool isReady = false;

  @override
  void initState() {
    super.initState();

    onFirstLoad();
    context.bloc<ProductBloc>().add(LoadFavoriteProduct());
  }

  onFirstLoad() async {
//    onRequestProductGift();
    onRequestReward();
  }

  onRequestReward() async {
    var response = await http.get(Api.reward);

    if (response.statusCode == 200) {
      Iterable list = jsonDecode(response.body);
      List<RewardModel> rewardList =
          list.map((e) => RewardModel.fromJson(e)).toList();

      setState(() {
        listReward = rewardList;
        isReady = true;
      });
    } else {
      print("StatusCode ${response.statusCode}");
    }
  }

  submitFavorite(List<FavoriteModel> listFav, String proId) async {
    bool isFavorite = false;

    if (listFav != null) {
      FavoriteModel myFavor = listFav.firstWhere(
          (element) => proId == element.id.toString(),
          orElse: () => null);


      if (myFavor != null) {
        isFavorite = true;
      }
    }

    print("listFav $isFavorite");

    context.bloc<ProductBloc>().add(UpdateFavorite(proId, !isFavorite));
    await FavoriteRepository.updateFavorite(
        int.parse(proId), widget.currentUser.customer.toString());
  }

  Future<void> onRefresh() async {}

  onSubmit() async {}

  @override
  Widget build(BuildContext context) {
    if (!isReady) {
      return Container(
        height: 300,
        child: Center(child: Loading()),
      );
    }

    return BlocBuilder<ProductBloc, ProductState>(
        builder: (BuildContext context, ProductState state) {
      if (state.products == null) return Center(child: Loading());

      return NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification scrollInfo) {
          if (scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
//                  context.bloc<ProductBloc>().add(LoadMoreEvent());
          }
          return null;
        },
        child: RefreshIndicator(
          onRefresh: onRefresh,
          child: ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: listReward.length,
            itemBuilder: (BuildContext context, int index) {
              return GiftCard(
                listReward[index],
                state.listFavorite,
                () => submitFavorite(
                  state.listFavorite,
                  listReward[index].product.id.toString(),
                ),
              );
            },
          ),
        ),
      );
    });
  }
}
