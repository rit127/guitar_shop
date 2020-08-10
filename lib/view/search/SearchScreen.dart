import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:guitarfashion/model/CategoryMenu.dart';
import 'package:guitarfashion/repository/BrandsRepository.dart';
import 'package:guitarfashion/repository/CategoryRepository.dart';
import 'package:guitarfashion/theme/style.dart';
import 'package:guitarfashion/utils/Api.dart';
import 'package:guitarfashion/utils/HexColor.dart';
import 'package:guitarfashion/utils/Loading.dart';
import 'package:http/http.dart' as http;

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<CategoryMenu> listSearch = [];
  List<CategoryMenu> allData = [];

  List<CategoryMenu> resultCategory = [];
  List<CategoryMenu> tmpResultCategory = [];
  List<CategoryMenu> resultBrand = [];
  List<CategoryMenu> tmpResultBrand = [];

  bool isReady = false;
  bool isFirst = false;

  TextEditingController _controller = new TextEditingController();
  FocusNode fSearch = FocusNode();
  @override
  void initState() {
    super.initState();
    onFirstLoad();
  }

  onFirstLoad() async {
    List<CategoryMenu> listCategory =
        await CategoryRepository.fetchAllCategory();
    List<CategoryMenu> listBrand = await BrandsRepository.fetchBrand();

    if (listCategory != null) {
      resultCategory = listCategory;
      tmpResultCategory = listCategory;
    }

    if (listBrand != null) {
      resultBrand = listBrand;
      tmpResultBrand = listBrand;
    }

    setState(() {
      fSearch.requestFocus();
      isReady = true;
    });
  }

  onFilter(String value) {

    if(value.trim() == ""){
      setState(() {
        isFirst = false;
      });

      return;
    }

    setState(() {
      isReady = false;
    });

    List<CategoryMenu> filterCategory = tmpResultCategory
        .where((element) =>
            element.name.toLowerCase().contains(value.toLowerCase()))
        .toList();

    List<CategoryMenu> filterBrand = tmpResultBrand
        .where((element) =>
            element.name.toLowerCase().contains(value.toLowerCase()))
        .toList();

    setState(() {
      value == ""
          ? resultCategory = tmpResultCategory
          : resultCategory = filterCategory;
      value == "" ? resultBrand = tmpResultBrand : resultBrand = filterBrand;
      isFirst = true;
      isReady = true;
    });
  }

  onClearText() async {
    _controller.text = "";

    setState(() {
      resultCategory = tmpResultCategory;
      resultBrand = tmpResultBrand;
      isFirst = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  SafeArea(
        child: Column(
                children: <Widget>[
                  searchBar(),
                  isFirst ? isReady ? Expanded(
                    child: ListView(
                      children: <Widget>[
                        ListView.separated(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          separatorBuilder: (BuildContext context, int index) {
                            return Divider(
                              height: 1,
                              thickness: 1,
                              color: HexColor('#DCDCDC'),
                            );
                          },
                          itemCount: resultCategory.length,
                          itemBuilder: (BuildContext context, int index) {
                            return _searchCard(resultCategory[index]);
                          },
                        ),
                        ListView.separated(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          separatorBuilder: (BuildContext context, int index) {
                            return Divider(
                              height: 1,
                              thickness: 1,
                              color: HexColor('#DCDCDC'),
                            );
                          },
                          itemCount: resultBrand.length,
                          itemBuilder: (BuildContext context, int index) {
                            return _brandCard(resultBrand[index]);
                          },
                        ),
                      ],
                    ),
                  ) : Expanded(
                    child: Center(
                      child: Loading(),
                    ),
                  ) : Container(),
                ],
              ),
      ),
    );
  }

  Widget searchBar() {
    return Container(
      height: 70,
      width: double.infinity,
      color: HexColor('#ECEFF0'),
      padding: EdgeInsets.only(left: 12),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Container(
              height: 45,
              child: TextFormField(
                focusNode: fSearch,
                controller: _controller,
                onChanged: (value) => onFilter(value),
                textInputAction: TextInputAction.search,
                onFieldSubmitted: (value) {
                  if (resultCategory.length > 0) {
                    Navigator.pushNamed(context, '/cate',
                        arguments: resultCategory[0]);
                  } else {
                    if (resultBrand.length > 0) {
                      Navigator.pushNamed(context, '/brand',
                          arguments: resultBrand[0]);
                    }
                  }
                },
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  hintText: "ស្វែងរកតាម អាវ&ប្រេន",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide.none,
                  ),
                  prefixIcon: Container(
                    margin: EdgeInsets.only(bottom: 5),
                    child: Icon(
                      Icons.search,
                      color: HexColor('#8E8E93'),
                    ),
                  ),
                  suffixIcon: GestureDetector(
                    onTap: onClearText,
                    child: Icon(
                      Icons.close,
                      color: HexColor('#8E8E93'),
                    ),
                  ),
                  contentPadding: EdgeInsets.zero,
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: Center(
                child: Text("បោះបង់"),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget listHeader(String title) {
    return Column(
      children: <Widget>[
        Container(
          height: 50,
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          child: Text(
            title,
            style: TextStyle(fontSize: 16),
          ),
        ),
        Divider(
          height: 1,
          thickness: 1,
          color: HexColor('#DCDCDC'),
        ),
      ],
    );
  }

  Widget _searchCard(CategoryMenu item) {

    return ListTile(
      onTap: () {
        Navigator.pushNamed(context, '/cate', arguments: item);
      },
      title: Container(
        height: 50,
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.only(left: 15),
        child: Text("${item.name}"),
      ),
    );
//
//    if (item.categories.length == 0) {
//      return ListTile(
//        onTap: () {
//          Navigator.pushNamed(context, '/cate', arguments: item);
//        },
//        title: Container(
//          height: 50,
//          alignment: Alignment.centerLeft,
//          padding: EdgeInsets.only(left: 15),
//          child: Text("${item.name}"),
//        ),
//      );
//    }
//
//    return ExpansionTile(
//      title: Container(
//        height: 50,
//        alignment: Alignment.centerLeft,
//        padding: EdgeInsets.only(left: 15),
//        child: Text(
//          "${item.name}",
//          style: TextStyle(
//            color: Colors.black,
//          ),
//        ),
//      ),
//      children: <Widget>[
//        ListView.builder(
//          padding: EdgeInsets.only(left: 20),
//          itemCount: item.categories.length,
//          itemBuilder: (BuildContext context, int index) {
//            Categories items = item.categories[index];
//
//            CategoryMenu currentCate = new CategoryMenu(
//              id: items.id,
//              name: items.name,
//              iconImage: items.icon,
//            );
//
//            return GestureDetector(
//              onTap: () {
//                Navigator.pop(context);
//                Navigator.pushNamed(
//                  context,
//                  '/cate',
//                  arguments: currentCate,
//                );
//              },
//              child: Container(
//                alignment: Alignment.center,
//                margin: EdgeInsets.only(top: 8),
//                color: whiteColor,
//                child: Row(
//                  mainAxisAlignment: MainAxisAlignment.center,
//                  crossAxisAlignment: CrossAxisAlignment.center,
//                  children: <Widget>[
//                    Expanded(
//                      flex: 1,
//                      child: Container(
//                        height: 35,
//                        child: items.icon != null
//                            ? Image.network(Api.mainUrl + items.icon.url)
//                            : Icon(Icons.error),
//                      ),
//                    ),
//                    Expanded(
//                      flex: 4,
//                      child: Text(
//                        '${items.name}',
//                        style: TextStyle(
//                          fontSize: 16,
//                        ),
//                      ),
//                    ),
//                  ],
//                ),
//              ),
//            );
//          },
//          shrinkWrap: true,
//          physics: NeverScrollableScrollPhysics(),
//        ),
//      ],
//    );
  }

  Widget _brandCard(CategoryMenu item) {
    return ListTile(
      onTap: () {
        Navigator.pushNamed(context, '/brand', arguments: item);
      },
      title: Container(
        height: 50,
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.only(left: 15),
        child: Text("${item.name}"),
      ),
    );
  }
}
