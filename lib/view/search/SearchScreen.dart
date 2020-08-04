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

  TextEditingController _controller = new TextEditingController();

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
      isReady = true;
    });
  }

  onFilter(String value) {
    print("value $value");
    setState(() {
      isReady = false;
    });

    List<CategoryMenu> filterCategory = tmpResultCategory
        .where((element) =>
            element.name.toLowerCase().contains(value.toLowerCase()))
        .toList();

    print("filterCategory $filterCategory");

    List<CategoryMenu> filterBrand = tmpResultBrand
        .where((element) =>
            element.name.toLowerCase().contains(value.toLowerCase()))
        .toList();

    print("filterBrand $filterBrand");

    setState(() {
      value == ""
          ? resultCategory = tmpResultCategory
          : resultCategory = filterCategory;
      value == "" ? resultBrand = tmpResultBrand : resultBrand = filterBrand;
      isReady = true;
    });
  }

  onClearText () async {
    _controller.text = "";

    setState(() {
      resultCategory = tmpResultCategory;
      resultBrand = tmpResultBrand;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: HexColor('#ECEFF0'),
        elevation: 0,
        leading: null,
        automaticallyImplyLeading: false,
        title: Container(
          height: 45,
          child: TextFormField(
            controller: _controller,
            onChanged: (value) => onFilter(value),
            decoration: InputDecoration(
              fillColor: Colors.white,
              filled: true,
              hintText: "ស្វែករក",
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
        actions: <Widget>[
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              width: 100,
              child: Center(
                child: Text("បោះបង់"),
              ),
            ),
          )
        ],
      ),
      body: isReady
          ? ListView(
              children: <Widget>[
                listHeader("ប្រភេទ ​៖​"),
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
                Divider(
                  height: 1,
                  thickness: 1,
                  color: HexColor('#DCDCDC'),
                ),
                listHeader("ប្រេន ​៖​"),
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
            )
          : Center(
              child: Loading(),
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
