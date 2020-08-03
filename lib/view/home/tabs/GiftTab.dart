import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:guitarfashion/model/Product.dart';
import 'package:guitarfashion/model/RewardModel.dart';
import 'package:guitarfashion/model/UserModel.dart';
import 'package:guitarfashion/repository/AuthRepository.dart';
import 'package:guitarfashion/utils/Api.dart';
import 'package:guitarfashion/utils/Loading.dart';
import 'package:guitarfashion/widget/GiftCard.dart';
import 'package:http/http.dart' as http;

class GiftTab extends StatefulWidget {
  @override
  _GiftTabState createState() => _GiftTabState();
}

class _GiftTabState extends State<GiftTab> {
  List<RewardModel> listReward;

  bool isReady = false;

  @override
  void initState() {
    super.initState();

    onFirstLoad();
  }

  onFirstLoad() async {
//    onRequestProductGift();
    onRequestReward();
  }

  onRequestReward () async {
    var response = await http.get(Api.reward);

    if(response.statusCode == 200) {
      Iterable list = jsonDecode(response.body);
      List<RewardModel> rewardList = list.map((e) => RewardModel.fromJson(e)).toList();

      await Future.delayed(Duration(milliseconds: 500));

      setState(() {
        listReward = rewardList;
        isReady = true;
      });
    } else {
      print("StatusCode ${response.statusCode}");
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
      itemCount: listReward.length,
      itemBuilder: (BuildContext context, int index) {
        return GiftCard(listReward[index]);
      },
    );
  }


}
