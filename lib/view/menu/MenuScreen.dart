import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:guitarfashion/model/CategoryMenu.dart';
import 'package:guitarfashion/res.dart';
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
    print("length ${widget.listMenu.length}");
    if (widget.listMenu == null) return Container();

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
                    return drawerItem(context, widget.listMenu[index]);
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
  }

  Widget drawerItem(BuildContext context, CategoryMenu category) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
        if (category.name == 'ទំព័រដើម') {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => HomeScreen()));
        } else {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) =>
                      CategoryScreen(categoryItem: category)));
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
                child: category.iconImage != null
                    ? Image.network(Api.mainUrl + category.iconImage.url)
                    : Icon(Icons.error),
              ),
            ),
            Expanded(
              flex: 4,
              child: Text(
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
            ),
          ],
        ),
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
