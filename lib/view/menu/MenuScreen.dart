import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:guitarfashion/bloc/ProductBloc.dart';
import 'package:guitarfashion/model/CategoryMenu.dart';
import 'package:guitarfashion/res.dart';
import 'package:guitarfashion/state/ProductState.dart';
import 'package:guitarfashion/theme/style.dart';
import 'package:guitarfashion/utils/Api.dart';
import 'package:guitarfashion/utils/Trans.dart';
import 'package:guitarfashion/view/category/CategoryPage.dart';
import 'package:guitarfashion/view/category/CategoryScreen.dart';
import 'package:guitarfashion/view/home/HomeScreen.dart';
import 'package:guitarfashion/view/menu/FilterBrand.dart';

class MenuItems {
  String name;
  IconData icon;
  MenuItems({this.icon, this.name});
}

class MenuScreen extends StatefulWidget {
  final String activeScreenName;
  final List<CategoryMenu> listMenu;

  MenuScreen({
    this.activeScreenName,
    this.listMenu,
  });

  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  @override
  Widget build(BuildContext context) {
    if (widget.listMenu == null) return Container();

    return BlocBuilder<ProductBloc, ProductState>(
      builder: (BuildContext context, ProductState state) {
        return Drawer(
          child: SafeArea(
            child: Container(
              color: Colors.white,
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
//                SizedBox(height: 25),
                    Container(
                      height: 120,
                      padding: EdgeInsets.only(top: 30),
                      child: Image.asset(Res.logo),
                    ),
                    Divider(thickness: 1, height: 2),
                    SizedBox(height: 30),
                    eachTab(context,
                        screenName: "ទំព័រដើម", iconPath: Res.hot_coming),
                    ListView.builder(
                      itemCount: widget.listMenu.length,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        if (widget.listMenu[index].category == null) {
                          return drawerItem(context, widget.listMenu[index]);
                        }

                        return Container();
                      },
                    ),

//                eachTab(context,
//                    screenName: Trans.hot_coming, iconPath: Res.hot_coming),
//                eachTab(context,
//                    screenName: Trans.t_shirt, iconPath: Res.t_shirt),
//                eachTab(context, screenName: Trans.shirt, iconPath: Res.shirt),
//                eachTab(context,
//                    screenName: Trans.out_shirt, iconPath: Res.out_shirt),
//                eachTab(context,
//                    screenName: Trans.khor_kr_nat, iconPath: Res.khor_kr_nat),
//                eachTab(context,
//                    screenName: Trans.khor_ka_boy, iconPath: Res.khor_ka_boy),
//                eachTab(context, screenName: Trans.bag, iconPath: Res.bag),
//                eachTab(context, screenName: Trans.belt, iconPath: Res.belt),
//                eachTab(context, screenName: Trans.hat, iconPath: Res.hat),
//                eachTab(context, screenName: Trans.shoe, iconPath: Res.shoe),
                    SizedBox(height: 12),
                    Divider(thickness: 1, height: 2),
                    eachTab(context,
                        screenName: Trans.share_app, iconPath: Res.share_app),
                    SizedBox(height: 12),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget drawerItem(BuildContext context, CategoryMenu category) {
    if (category.categories.length == 0) {
      return ListTile(
        onTap: () {
          Navigator.pop(context);

          Navigator.pushReplacementNamed(
            context,
            '/cate',
            arguments: category,
          );
        },
        leading: Container(
          height: 35,
          child: category.iconImage != null
              ? Image.network(Api.mainUrl + category.iconImage.url)
              : Icon(Icons.error),
        ),
        title: Text(
          '${category.name}',
          style: TextStyle(
            fontSize: 16,
            color: this.widget.activeScreenName.compareTo(category.name) != 0
                ? Color(
                    getColorHexFromStr('#929292'),
                  )
                : Color(
                    getColorHexFromStr('#0097A2'),
                  ),
          ),
        ),
      );
    }

    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(top: 8, bottom: 8),
      color: whiteColor,
      child: ExpansionTile(
        leading: Container(
          height: 35,
          child: category.iconImage != null
              ? Image.network(Api.mainUrl + category.iconImage.url)
              : Icon(Icons.error),
        ),
        title: Text(
          '${category.name}',
          style: TextStyle(
            fontSize: 16,
            color:
                this.widget.activeScreenName.compareTo(category.name) != 0
                    ? Color(
                        getColorHexFromStr('#929292'),
                      )
                    : Color(
                        getColorHexFromStr('#0097A2'),
                      ),
          ),
        ),
        children: <Widget>[
          ListView.builder(
            padding: EdgeInsets.only(left: 20),
            itemCount: category.categories.length,
            itemBuilder: (BuildContext context, int index) {
              Categories item = category.categories[index];

              CategoryMenu currentCate = new CategoryMenu(
                id: item.id,
                name: item.name,
                iconImage: item.icon,
              );

              return ListTile(
                onTap: () {
                  Navigator.pop(context);

                  Navigator.pushNamed(
                    context,
                    '/cate',
                    arguments: currentCate,
                  );
                },
                leading: item.icon != null
                    ? Image.network(
                        Api.mainUrl + item.icon.url,
                        height: 35,
                        fit: BoxFit.contain,
                      )
                    : Icon(Icons.error),
                title: Text(
                  '${item.name}',
                  style: TextStyle(
                    fontSize: 16,
                    color:
                        this.widget.activeScreenName.compareTo(item.name) !=
                                0
                            ? Color(
                                getColorHexFromStr('#929292'),
                              )
                            : Color(
                                getColorHexFromStr('#0097A2'),
                              ),
                  ),
                ),
              );
            },
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
          ),
        ],
      ),
    );
  }

  Widget eachTab(BuildContext context, {String screenName, String iconPath}) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
        if (screenName == 'ទំព័រដើម') {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => HomeScreen()));
        }
      },
      child: Container(
        alignment: Alignment.center,
        height: 50.0,
        margin: EdgeInsets.only(top: 3),
        color: whiteColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
                flex: 1,
                child: Container(
                  height: 35,
                  child: Image.asset(iconPath),
                )),
            Expanded(
              flex: 4,
              child: Text(
                '$screenName',
                style: TextStyle(
                  fontSize: 16,
                  color: this.widget.activeScreenName.compareTo(screenName) != 0
                      ? Color(getColorHexFromStr('#929292'))
                      : Color(getColorHexFromStr('#0097A2')),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
