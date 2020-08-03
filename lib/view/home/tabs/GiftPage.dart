import 'package:flutter/material.dart';
import 'package:guitarfashion/model/Customer.dart';
import 'package:guitarfashion/model/UserModel.dart';
import 'package:guitarfashion/repository/AccountRepository.dart';
import 'package:guitarfashion/repository/AuthRepository.dart';
import 'package:guitarfashion/res.dart';
import 'package:guitarfashion/utils/AppColor.dart';
import 'package:guitarfashion/utils/HexColor.dart';
import 'package:guitarfashion/utils/Loading.dart';
import 'package:guitarfashion/view/auth/UnAuthorize.dart';
import 'package:guitarfashion/view/home/tabs/GiftChangedTab.dart';
import 'package:guitarfashion/view/home/tabs/GiftTab.dart';

class GiftPage extends StatefulWidget {
  @override
  _GiftPageState createState() => _GiftPageState();
}

class _GiftPageState extends State<GiftPage>
    with TickerProviderStateMixin<GiftPage>, AutomaticKeepAliveClientMixin<GiftPage> {
  TabController _tabController;
  int currentIndex = 0;
  String userToken;

  bool isReady = false;
  Customer customer;
  @override
  void initState() {
    super.initState();
    _tabController = new TabController(length: 2, vsync: this);
    onFirstLoad();
  }

  onFirstLoad() async {
    String token = await AuthRepository.getUserToken();

    if(token != null) {
      UserModel myUser = await AuthRepository.getUser();
      Customer myCustomer = await AccountRepository.fetchCustomer(myUser.customer.toString());
      userToken = token;
      customer = myCustomer;
    }
    await Future.delayed(Duration(milliseconds: 500));

    setState(() {
      isReady = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    if (!isReady) {
      return Center(
        child: Loading(),
      );
    }

    if (userToken == null) {
      return UnAuthorize();
    }

    return ListView(
      children: <Widget>[
        headerList(),
        pointSection(),
        SizedBox(height: 20),
        Column(
          children: <Widget>[
            Container(
              child: Container(
                height: 55,
                decoration: new BoxDecoration(
                  border: Border.symmetric(
                    vertical: BorderSide(
                      width: 0.5,
                      color: Colors.grey,
                    ),
                  ),
                ),
                child: new TabBar(
                  onTap: (index) {
                    _tabController.animateTo(index);
                    setState(() {
                      currentIndex = index;
                    });
                  },
                  controller: _tabController,
                  indicatorColor: AppColor.guitarShopColor,
                  indicatorSize: TabBarIndicatorSize.tab,
                  unselectedLabelStyle: TextStyle(
                    color: HexColor('#BDBDBD'),
                  ),
                  labelStyle: TextStyle(
                    fontSize: 15,
                    color: AppColor.guitarShopColor,
                  ),
                  tabs: [
//                    Tab(
//                      child: Container(
//                        margin: EdgeInsets.symmetric(vertical: 5),
//                        width: double.infinity,
//                        decoration: BoxDecoration(
//                          border: Border(right: BorderSide(width: 0.5))
//                        ),
//                        alignment: Alignment.center,
//                        child: Text('រង្វាន់'),
//                      ),
//                    ),
                    Tab(text: 'រង្វាន់'),
                    Tab(text: 'រង្វាន់ធ្លាប់ប្តូរ'),
                  ],
                ),
              ),
            ),
            Container(
//              height: screenHeight,
              child: currentIndex == 0 ? GiftTab() : GiftChangedTab(),
            ),
          ],
        ),
      ],
    );
  }

  Widget headerList() {
    return Container(
      padding: EdgeInsets.all(12),
      child: Row(
        children: <Widget>[
          Image.asset(
            Res.tab_gift,
            color: HexColor('#0097A2'),
            height: 18,
          ),
          SizedBox(width: 5),
          Container(
            padding: EdgeInsets.only(top: 5, left: 5),
            child: Text(
              "រង្វាន់",
              style: TextStyle(fontSize: 16),
            ),
          )
        ],
      ),
    );
  }

  Widget pointSection() {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            child: Text(
              "សន្សំពិន្ទុដើម្បីប្តូរយករង្វាន់",
              style: TextStyle(
                fontSize: 14,
                color: HexColor('#8C8C8C'),
              ),
            ),
          ),
          Container(
            child: Text(
              customer.point != null ? customer.point : "0",
              style: TextStyle(
                fontSize: 50,
                color: HexColor('#FF9D00'),
              ),
            ),
          ),
          Container(
            child: Text(
              "ពិន្ទុ​របស់​អ្នក",
              style: TextStyle(
                fontSize: 16,
                color: AppColor.guitarShopColor,
                fontWeight: FontWeight.bold
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
