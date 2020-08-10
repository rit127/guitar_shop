import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:guitarfashion/model/NotificationMessage.dart';
import 'package:guitarfashion/model/UserModel.dart';
import 'package:guitarfashion/repository/AuthRepository.dart';
import 'package:guitarfashion/utils/Api.dart';
import 'package:guitarfashion/utils/HexColor.dart';
import 'package:guitarfashion/utils/Loading.dart';
import 'package:http/http.dart' as http;
import 'package:timeago/timeago.dart' as timeago;

class NotificationScreen extends StatefulWidget {
  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  List<NotificationMessage> listNotification;

  @override
  void initState() {
    super.initState();
    onFirstLoad();
  }

  onFirstLoad() async {
    await getNotification();
  }

  getNotification() async {
    UserModel userModel = await AuthRepository.getUser();

    String requestUrl = "";

    if (userModel != null) {
      requestUrl = "https://guitar.kravanh.co/messages";
    } else {
      requestUrl = "https://guitar.kravanh.co/messages?reciever_ne=user";
    }

    var response = await http.get(requestUrl);

    if (response.statusCode == 200) {
      Iterable list = jsonDecode(response.body);
      List<NotificationMessage> listNoti =
          list.map((e) => NotificationMessage.fromJson(e)).toList();

      setState(() {
        listNotification = listNoti;
      });
    }
  }

  convertDateToShort(String txtDate) {
    String shortDate = txtDate.split(' ')[0];

    return shortDate;
  }

  Future<void> onRefresh() async {
    await Future.delayed(Duration(seconds: 1), () async {
      await getNotification();
    });
  }

  @override
  Widget build(BuildContext context) {
    DateTime today = DateTime.now().toLocal();
    String myToday = convertDateToShort(today.toLocal().toString());

    return Scaffold(
      appBar: AppBar(
        title: Text('ការផ្តល់ដំណឹង'),
        centerTitle: true,
      ),
      body: listNotification != null
          ? RefreshIndicator(
              onRefresh: onRefresh,
              child: GroupedListView<NotificationMessage, String>(
                physics: AlwaysScrollableScrollPhysics(),
                elements: listNotification,
                groupBy: (element) => convertDateToShort(
                    DateTime.parse(element.createdAt).toLocal().toString()),
                groupSeparatorBuilder: (String date) {
                  DateTime currentDate = DateTime.parse(date).toLocal();

                  if (myToday ==
                      convertDateToShort(currentDate.toLocal().toString())) {
                    return headerDate("ថ្ងៃនេះ");
                  }

                  String value = currentDate.day.toString() +
                      "-" +
                      currentDate.month.toString() +
                      "-" +
                      currentDate.year.toString();
                  return headerDate(value);
                },
                itemBuilder: (context, NotificationMessage element) =>
                    notificationCard(element),
                order: GroupedListOrder.DESC,
              ),
            )
          : Center(
              child: Loading(),
            ),
    );
  }

  Widget headerDate(String date) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 12,
      ),
      child: Text(
        date,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget notificationCard(NotificationMessage item) {
    DateTime txtDate = DateTime.parse(item.createdAt);

    return Container(
//      padding: EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
          border: Border.symmetric(
              vertical: BorderSide(width: 1, color: HexColor('#ECEFF0')))),
      child: ListTile(
        leading: Image.network(
          Api.mainUrl + item.icon.url,
          height: 35,
        ),
        title: Text(item.title),
        subtitle: Text(timeago.format(txtDate)),
      ),
    );
  }
}
