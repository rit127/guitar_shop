import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guitarfashion/bloc/HomeBloc.dart';
import 'package:guitarfashion/bloc/ProductBloc.dart';
import 'package:guitarfashion/enums/device_screen_type.dart';
import 'package:guitarfashion/event/HomeEvent.dart';
import 'package:guitarfashion/event/ProductEvent.dart';
import 'package:guitarfashion/model/FavoriteModel.dart';
import 'package:guitarfashion/model/UserModel.dart';
import 'package:guitarfashion/repository/AuthRepository.dart';
import 'package:guitarfashion/repository/FavoriteRepository.dart';
import 'package:guitarfashion/state/HomeState.dart';
import 'package:guitarfashion/state/ProductState.dart';
import 'package:guitarfashion/theme/style.dart';
import 'package:guitarfashion/utils/AppColor.dart';
import 'package:guitarfashion/utils/Loading.dart';
import 'package:guitarfashion/utils/ui_utils.dart';
import 'package:guitarfashion/widget/ProductCard.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin<HomePage> {
  List<FavoriteModel> listFavorite;
  UserModel currentUser;
  @override
  void initState() {
    super.initState();
    onFirstLoad();
  }

  onFirstLoad() async {
    await getFavorite();
  }

  getFavorite() async {
    UserModel myUser = await AuthRepository.getUser();

    if (myUser != null) {
      print("userModel");
//      List<FavoriteModel> tmpData =
//          await FavoriteRepository.getListFavorite(myUser.customer.toString());
//      print("tmpData ${jsonEncode(tmpData)}");
//
//      listFavorite = tmpData;
      currentUser = myUser;

      context.bloc<ProductBloc>().add(LoadFavoriteProduct());
    }

    context.bloc<ProductBloc>().add(LoadDataEvent());

  }

  Future<void> onRefresh () async {
    await Future.delayed(Duration(seconds: 1), () {
      context.bloc<ProductBloc>().add(LoadDataEvent());
    });
  }

  submitFavorite (List<FavoriteModel> listFav, String proId) async {
    bool isFavorite = false;

    if (listFav != null){
      FavoriteModel myFavor = listFav.firstWhere(
              (element) => proId == element.id.toString(),
          orElse: () => null);

      if (myFavor != null) {
        isFavorite = true;
      }
    }

    context.bloc<ProductBloc>().add(UpdateFavorite(proId, !isFavorite));
    await FavoriteRepository.updateFavorite(int.parse(proId), currentUser.customer.toString());
  }

  @override
  Widget build(BuildContext context) {

    var currentHeight = MediaQuery.of(context).size.height;
    var currentWidth = MediaQuery.of(context).size.width;

    double cardSize = 0;

    DeviceScreenType screenType = getDeviceType(MediaQuery.of(context));

    if(screenType == DeviceScreenType.Mobile) {
      cardSize =  1.4;
      if(currentWidth < 321) {
        cardSize = 1.2;
      }
    } else {
      cardSize = 1.3;
    }

    return BlocBuilder<ProductBloc, ProductState>(
        builder: (BuildContext context, ProductState state) {
      if (state.products == null) return Center(child: Loading());

      return NotificationListener<ScrollNotification>(
          onNotification: (ScrollNotification scrollInfo) {
            if (scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
//              context.bloc<ProductBloc>().add(LoadMoreEvent());
            }
            return null;
          },
          child: RefreshIndicator(
        onRefresh: onRefresh,
        child: ListView(
          children: <Widget>[
            listHeader("ទំនិញទើបមកដល់"),
            GridView.builder(
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: MediaQuery.of(context).size.width /
                    (MediaQuery.of(context).size.height / cardSize),
              ),
              shrinkWrap: true,
              padding: EdgeInsets.all(8),
              itemCount: state.products.length,
              itemBuilder: (BuildContext context, int index) {
                return ProductCard(
                  product: state.products[index],
                  listFavorite: state.listFavorite,
                  currentUser: currentUser,
                  onFavorite: () => submitFavorite(state.listFavorite, state.products[index].id.toString()),
                );
              },
            ),
            (state.isLoading)
                ? Container(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Center(
                child: Loading(),
              ),
            )
                : Container()
          ],
        ),
      ));
    });
  }

  Widget listHeader(String title) {
    return Container(
      padding: EdgeInsets.only(left: 15, right: 15, top: 10),
      child: Row(
//        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            'images/shopping-bag.png',
            height: 20,
            color: AppColor.guitarShopColor,
          ),
          SizedBox(width: 8),
          Container(
            padding: EdgeInsets.only(top: 6),
            child: Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
