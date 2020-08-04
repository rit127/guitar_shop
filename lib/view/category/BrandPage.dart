import 'package:flutter/material.dart';
import 'package:guitarfashion/model/CategoryMenu.dart';
import 'package:guitarfashion/model/FavoriteModel.dart';
import 'package:guitarfashion/model/Product.dart';
import 'package:guitarfashion/model/UserModel.dart';
import 'package:guitarfashion/repository/AuthRepository.dart';
import 'package:guitarfashion/repository/BrandsRepository.dart';
import 'package:guitarfashion/repository/FavoriteRepository.dart';
import 'package:guitarfashion/res.dart';
import 'package:guitarfashion/utils/HexColor.dart';
import 'package:guitarfashion/widget/ProductCard.dart';

class BrandPage extends StatefulWidget {
  final CategoryMenu brandItem;

  BrandPage({this.brandItem});

  @override
  _BrandPageState createState() => _BrandPageState();
}

class _BrandPageState extends State<BrandPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();

  List<CategoryMenu> listBrands = [];
  List<Product> listProduct = [];
  List<FavoriteModel> listFavorite;
  UserModel currentUser;

  @override
  void initState() {
    super.initState();
    getProductByBrandId();
    getFavorite();
  }

  getProductByBrandId () async {
    List<Product> myProduct = await BrandsRepository.fetchProductByBrandId(widget.brandItem.id.toString());

    if(myProduct != null) {
      setState(() {
        listProduct = myProduct;
      });
    }
  }

  getFavorite () async {
    UserModel myUser = await AuthRepository.getUser();

    if(myUser != null) {
      print("userModel");
      List<FavoriteModel> tmpData = await FavoriteRepository.getListFavorite(myUser.customer.toString());

      listFavorite = tmpData;
      currentUser = myUser;
    }
  }

  getListBrands() async {
    List<CategoryMenu> list = await BrandsRepository.fetchBrand();

    setState(() {
      listBrands = list;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: HexColor('#ECEFF0'),
        centerTitle: true,
        title: Container(
          height: 55,
          child: Image.asset(Res.logo),
        ),
      ),
      body: ListView(
        children: <Widget>[
          SizedBox(height: 12),
          listHeader(widget.brandItem.name),
//          state.isFilter
//              ? filterHeader(state.categoryName)
//              : Container(),
          GridView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: MediaQuery.of(context).size.width /
                  (MediaQuery.of(context).size.height / 1.5),
            ),
            padding: EdgeInsets.all(8),
            itemCount: listProduct.length,
            itemBuilder: (BuildContext context, int index) {
              return ProductCard(
                product: listProduct[index],
                listFavorite: listFavorite,
                currentUser: currentUser,
              );
            },
          ),
        ],
      ),
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
