import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guitarfashion/bloc/HomeBloc.dart';
import 'package:guitarfashion/model/CategoryMenu.dart';
import 'package:guitarfashion/res.dart';
import 'package:guitarfashion/state/HomeState.dart';
import 'package:guitarfashion/utils/HexColor.dart';
import 'package:guitarfashion/view/category/CategoryPage.dart';
import 'package:guitarfashion/view/menu/MenuScreen.dart';
import 'package:guitarfashion/widget/ProductCard.dart';

class CategoryScreen extends StatefulWidget {
  final CategoryMenu categoryItem;

  CategoryScreen({this.categoryItem});

  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder:(BuildContext context, HomeState state) {
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: HexColor('#ECEFF0'),
            centerTitle: true,
            title: Container(
              height: 55,
              child: Image.asset(Res.logo),
            ),
            actions: <Widget>[
              IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/notification');
                },
                icon: Icon(Icons.notifications),
              ),
            ],
          ),
          drawer: MenuScreen(
            activeScreenName: widget.categoryItem.name,
            listMenu: state.drawerMenu,
          ),
          body: CategoryPage(widget.categoryItem),
        );
      },
    );
  }
}
