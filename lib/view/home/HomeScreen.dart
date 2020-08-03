import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guitarfashion/bloc/HomeBloc.dart';
import 'package:guitarfashion/event/HomeEvent.dart';
import 'package:guitarfashion/model/UserModel.dart';
import 'package:guitarfashion/repository/AuthRepository.dart';
import 'package:guitarfashion/repository/ProductRepository.dart';
import 'package:guitarfashion/res.dart';
import 'package:guitarfashion/state/HomeState.dart';
import 'package:guitarfashion/utils/HexColor.dart';
import 'package:guitarfashion/view/home/tabs/AccountPage.dart';
import 'package:guitarfashion/view/home/tabs/FavoritePage.dart';
import 'package:guitarfashion/view/home/tabs/GiftPage.dart';
import 'package:guitarfashion/view/home/tabs/HomePage.dart';
import 'package:guitarfashion/view/menu/FilterBrand.dart';
import 'package:guitarfashion/view/menu/MenuScreen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with TickerProviderStateMixin<HomeScreen>, AutomaticKeepAliveClientMixin {
  int _currentIndex = 0;
  TabController _tabs;
  UserModel currentUser;
  @override
  void initState() {
    super.initState();
    _tabs = TabController(length: 4, vsync: this);
    onFirstLoad();
    context.bloc<HomeBloc>().add(LoadDrawerMenu());
  }

  onFirstLoad () async {
    UserModel myUser = await AuthRepository.getUser();

    if(myUser != null) {
      setState(() {
        currentUser = myUser;
      });
    }
  }

  onChangeTab(int index) {
    _tabs.animateTo(index);
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc,HomeState>(
      builder : (BuildContext context, HomeState state)  {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            elevation: 0,
            centerTitle: true,
            title: Container(
              height: 55,
              child: Image.asset(Res.logo),
            ),
            actions: <Widget>[
              IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/search');
                },
                icon: Icon(Icons.search),
              ),
              IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/notification');
                },
                icon: Icon(Icons.notifications_none),
              ),
            ],
          ),
          drawer: MenuScreen(
            activeScreenName: 'ទំព័រដើម',
            listMenu: state.drawerMenu,
          ),
          body: TabBarView(
            physics: NeverScrollableScrollPhysics(),
            controller: _tabs,
            children: <Widget>[
              HomePage(),
              GiftPage(),
              FavoritePage(),
              AccountPage(),
            ],
          ),
          bottomNavigationBar: ClipRRect(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(25),
              topLeft: Radius.circular(25),
            ),
            child: BottomNavigationBar(
              currentIndex: _currentIndex,
              type: BottomNavigationBarType.fixed,
              onTap: onChangeTab,
              backgroundColor: HexColor('#ECEFF0'),
              selectedItemColor: HexColor('#0097A2'),
              unselectedItemColor: HexColor('#00161F'),
              items: [
                BottomNavigationBarItem(
                  icon: tabIcon(Res.tab_shopping),
                  activeIcon: tabIcon(Res.tab_shopping_focus),
                  title: tabTitle('ទំនិញ'),
                ),
                BottomNavigationBarItem(
                  icon: tabIcon(Res.tab_gift),
                  activeIcon: tabIcon(Res.tab_gift_focus),
                  title: tabTitle('រង្វាន់'),
                ),
                BottomNavigationBarItem(
                  icon: tabIcon(Res.tab_favorite),
                  activeIcon: tabIcon(Res.tab_favorite_focus),
                  title: tabTitle('ចូលចិត្ត'),
                ),
                BottomNavigationBarItem(
                  icon: tabIcon(Res.tab_account),
                  activeIcon: tabIcon(Res.tab_account_focus),
                  title: tabTitle('គណនី'),
                ),
              ],
            ),
          ),
//      bottomNavigationBar: Container(
//        height: 80,
//        decoration: BoxDecoration(
//          color: HexColor('#ECEFF0'),
//          borderRadius: BorderRadius.only(
//            topLeft: Radius.circular(25),
//            topRight: Radius.circular(25),
//          ),
//        ),
//        child: Row(
//          mainAxisAlignment: MainAxisAlignment.spaceAround,
//          children: <Widget>[
//            _tabIcon(iconPath: Res.tab_shopping, iconPathFocus: Res.tab_shopping_focus, title: 'ទំនិញ', index: 0),
//            _tabIcon(iconPath: Res.tab_gift, iconPathFocus: Res.tab_gift_focus, title: 'ទំនិញ', index: 1),
//            _tabIcon(iconPath: Res.tab_favorite, iconPathFocus: Res.tab_favorite_focus, title: 'ទំនិញ', index: 2),
//            _tabIcon(iconPath: Res.tab_account, iconPathFocus: Res.tab_account_focus, title: 'ទំនិញ', index: 3),
//          ],
//        ),
//      ),
        );
    }
    );
  }

  Widget tabIcon(String iconPath) {
    return Container(
      padding: EdgeInsets.only(top: 3),
      alignment: Alignment.center,
      child: Image.asset(
        iconPath,
        height: 25,
      ),
    );
  }

  Widget tabTitle(String title) {
    return Text(
      title,
    );
  }

  Widget _tabIcon(
      {String iconPath, String iconPathFocus, String title, int index}) {
    return Container(
      alignment: Alignment.center,
      child: InkWell(
        onTap: () => onChangeTab(index),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              _currentIndex != index ? iconPath : iconPathFocus,
              height: _currentIndex != index ? 23 : 25,
            ),
            SizedBox(height: 5),
            Text(
              title,
              style: TextStyle(
                fontSize: _currentIndex != index ? 13 : 15,
                color:
                    _currentIndex != index ? Colors.black : HexColor('#0097A2'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
