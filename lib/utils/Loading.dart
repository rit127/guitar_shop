import 'package:flutter/material.dart';
import 'package:guitarfashion/utils/AppColor.dart';
class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 7),(){
      if(mounted){
        setState(() {
          isLoading = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return (isLoading)?Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        CircularProgressIndicator(backgroundColor: Theme.of(context).indicatorColor,),
        SizedBox(height: 10,),
        Text("កំពុងទាញយក"),
      ],
    ):Text("គ្មានទិន្នន័យ",style: Theme.of(context).textTheme.headline.copyWith(color: AppColor.primaryColor))
    ;
  }
}
