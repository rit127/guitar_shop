import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:guitarfashion/model/GiftModel.dart';
import 'package:guitarfashion/model/UserModel.dart';
import 'package:guitarfashion/repository/AuthRepository.dart';
import 'package:guitarfashion/utils/Api.dart';
import 'package:guitarfashion/utils/HexColor.dart';
import 'package:guitarfashion/utils/Loading.dart';
import 'package:guitarfashion/widget/GiftCard.dart';
import 'package:http/http.dart' as http;
class GiftChangedTab extends StatefulWidget {
  @override
  _GiftChangedTabState createState() => _GiftChangedTabState();
}

class _GiftChangedTabState extends State<GiftChangedTab> {
  bool isReady = false;

  List<GiftModel> listGift;

  @override
  void initState() {
    super.initState();
    onFirstLoad();
  }

  onFirstLoad() async {
    onRequestProductGift();
  }

  onRequestProductGift() async {
    UserModel userModel = await AuthRepository.getUser();

    String requestUrl = Api.product + "?customers_gift.id=" + userModel.customer.toString();

    var customer = await http.get(requestUrl);

    if(customer.statusCode == 200) {
      //Request Success 200
      Iterable list = jsonDecode(customer.body);
      List<GiftModel> myGift = list.map((e) => GiftModel.fromJson(e)).toList();

      await Future.delayed(Duration(milliseconds: 500));

      setState(() {
        listGift = myGift;
        isReady = true;
      });
    }else {
      print("StatusCode ${customer.statusCode}");
    }
  }

  @override
  Widget build(BuildContext context) {
    if(!isReady) {
      return Container(
        height: 300,
        child: Center(child: Loading()),
      );
    }

    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: listGift.length,
      itemBuilder: (BuildContext context, int index) {
        return _myGiftCard(listGift[index]);
      },
    );
  }

  Widget _myGiftCard (GiftModel data) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/detail', arguments: data.id);
      },
      child: Container(
        height: 150,
        padding: EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
          border: Border.symmetric(
              vertical: BorderSide(width: 0.5, color: HexColor('#ECEFF0'))),
        ),
        child: Row(
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width * 0.4,
              height: 150,
              padding: EdgeInsets.all(8),
              child: CachedNetworkImage(
                imageUrl: Api.mainUrl + data.images[0].formats.medium.url,
                imageBuilder: (context, imageProvider) => Container(
                  margin: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
//                child: Image.network(Api.mainUrl + widget.data.image[0].formats.medium.url),
                ),
                placeholder: (context, url) => Container(
                  height: 300,
                  width: double.infinity,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
            ),
            Container(
              height: 150,
              width: MediaQuery.of(context).size.width * 0.4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "លេខកូដ: ${data.code}",
                  ),
                  Text(
                    '\$${data.price}',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Container(
//                  height: 35,
//                  width: 35,
                    alignment: Alignment.bottomLeft,
                    child: Row(children: <Widget>[
                      Text(
                        "ពិន្ទុ: ",
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                      Text(
                        data.rewards[0].point != null ? data.rewards[0].point.toString() : "0",
                        style: TextStyle(
                          color: HexColor('#FF9D00'),
                          fontSize: 15,
                        ),
                      ),
                    ]),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
