import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guitarfashion/bloc/CategoryBloc.dart';
import 'package:guitarfashion/event/CategoryEvent.dart';
import 'package:guitarfashion/event/FavoriteEvent.dart';
import 'package:guitarfashion/model/CategoryMenu.dart';
import 'package:guitarfashion/model/FavoriteModel.dart';
import 'package:guitarfashion/model/UserModel.dart';
import 'package:guitarfashion/repository/AuthRepository.dart';
import 'package:guitarfashion/repository/BrandsRepository.dart';
import 'package:guitarfashion/repository/FavoriteRepository.dart';
import 'package:guitarfashion/res.dart';
import 'package:guitarfashion/state/CategoryState.dart';
import 'package:guitarfashion/utils/HexColor.dart';
import 'package:guitarfashion/utils/Loading.dart';
import 'package:guitarfashion/view/menu/FilterBrand.dart';
import 'package:guitarfashion/widget/ProductCard.dart';
import 'package:http/http.dart' as http;

class CategoryPage extends StatefulWidget {
  final CategoryMenu categoryItem;

  CategoryPage(this.categoryItem);

  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();
  List<CategoryMenu> listBrands = [];
  List<FavoriteModel> listFavorite;
  UserModel currentUser;
  @override
  void initState() {
    super.initState();
    getFavorite();
    getListBrands();
    context.bloc<CategoryBloc>().add(LoadFavoriteProduct());
    context.bloc<CategoryBloc>().add(LoadCategory(widget.categoryItem.id));
  }

  getListBrands() async {
    List<CategoryMenu> list = await BrandsRepository.fetchBrandByCategoryId(widget.categoryItem.id.toString());

    setState(() {
      listBrands = list;
    });
  }

  getFavorite () async {
    UserModel myUser = await AuthRepository.getUser();

    if(myUser != null) {
      print("userModel");
      List<FavoriteModel> tmpData = await FavoriteRepository.getListFavorite(myUser.customer.toString());

      setState(() {
        listFavorite = tmpData;
        currentUser = myUser;
      });
    }
  }

  onFavorite (List<FavoriteModel> listFav, String proId) async {
    bool isFavorite = false;

    if (listFav != null){
      FavoriteModel myFavor = listFav.firstWhere(
              (element) => proId == element.id.toString(),
          orElse: () => null);

      if (myFavor != null) {
        isFavorite = true;
      }
    }

    context.bloc<CategoryBloc>().add(UpdateFavorite(proId, !isFavorite));
    await FavoriteRepository.updateFavorite(int.parse(proId), currentUser.customer.toString());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryBloc, CategoryState>(
      builder: (BuildContext context, CategoryState state) {
        return Scaffold(
          key: _scaffoldKey,
          endDrawer: FilterBrand(widget.categoryItem.id, listBrands),
          body: state.listProduct != null
              ? ListView(
                  children: <Widget>[
                    SizedBox(height: 12),
                    listHeader(widget.categoryItem.name),
                    state.isFilter
                        ? filterHeader(state.categoryName)
                        : Container(),
                    GridView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: MediaQuery.of(context).size.width /
                            (MediaQuery.of(context).size.height / 1.5),
                      ),
                      padding: EdgeInsets.all(8),
                      itemCount: state.listProduct.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ProductCard(
                          product: state.listProduct[index],
                          listFavorite: state.listFavorite,
                          currentUser: currentUser,
                          onFavorite: () => onFavorite(state.listFavorite, state.listProduct[index].id.toString()),
                        );
                      },
                    ),
                  ],
                )
              : Column(
                  children: <Widget>[
                    SizedBox(height: 12),
                    listHeader(widget.categoryItem.name),
                    Expanded(
                      child: Center(
                        child: Loading(),
                      ),
                    ),
                  ],
                ),
        );
      },
    );
  }

  Widget listHeader(String title) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          InkWell(
            onTap: () {
              _scaffoldKey.currentState.openEndDrawer();
            },
            child: Image.asset(
              'images/filter.png',
              height: 23,
              color: Colors.grey,
            ),
          )
        ],
      ),
    );
  }

  Widget filterHeader(
    String title,
  ) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        children: <Widget>[
          Text(
            "$title",
            style: TextStyle(
              fontSize: 15,
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(left: 12),
              child: Divider(
                thickness: 2,
                color: HexColor('#DCDCDC'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
