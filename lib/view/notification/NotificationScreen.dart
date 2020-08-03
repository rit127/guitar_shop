import 'package:flutter/material.dart';

class NotificationScreen extends StatefulWidget {
  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {

  @override
  void initState() {
    super.initState();
  }

  onFirstLoad() async {

  }

  getNotification () async {

  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ការផ្តល់ដំណឹង'),
        centerTitle: true,
      ),
      body: ListView(
        children: <Widget>[
          headerDate('ថ្ងៃនេះ'),
          notificationCard('images/notification/noti_1.png', "ពិន្ទុ150ប្តូរបាន កាបូបដាក់លុយដ៏ស្រស់ស្អាតមួយរួសរាន់ឡើងចំនួនមានកំណត់","1 នាទីមុ​ន"),
          headerDate('23-06-2019'),
          notificationCard('images/notification/noti_2.png', "ទំនិញថ្មីទើបមកដល់ស្អាតៗច្រើនម៉ូតតោះចូលមើលទាំងអស់គ្នា !!", "1:22 រសៀល"),
          headerDate('25-05-2019'),
          Divider(),
          notificationCard('images/notification/noti_3.png', "បញ្ចុះតម្លៃ15%រាល់ការទិញទំនិញចាប់ពី 200\$", "9:00 ព្រឹក"),
          Divider(),
          notificationCard('images/notification/noti_2.png', "ទំនិញថ្មីទើបមកដល់ស្អាតៗច្រើនម៉ូតតោះចូលមើលទាំងអស់គ្នា !!", "4:30 រសៀល"),
          Divider(),
          notificationCard('images/notification/noti_3.png', "បញ្ចុះតម្លៃ15%រាល់ការទិញទំនិញចាប់ពី 200\$", "9:00 ព្រឹក"),
          Divider(),
          notificationCard('images/notification/noti_2.png', "ទំនិញថ្មីទើបមកដល់ស្អាតៗច្រើនម៉ូតតោះចូលមើលទាំងអស់គ្នា !!", "4:30 រសៀល"),
        ],
      ),
    );
  }

  Widget headerDate (String date) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Text(date, style: TextStyle(fontSize: 16),),
    );
  }

  Widget notificationCard(String icon, String title, String dateTime) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: Image.asset(icon, height: 35,),
        title: Text(title),
        subtitle: Text(dateTime),
      ),
    );
  }
}
