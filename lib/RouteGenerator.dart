import 'package:flutter/material.dart';
import 'package:guitarfashion/view/account/ChangePasswordScreen.dart';
import 'package:guitarfashion/view/account/ForgetPasswordScreen.dart';
import 'package:guitarfashion/view/account/edit.dart';
import 'package:guitarfashion/view/category/CategoryScreen.dart';
import 'package:guitarfashion/view/home/HomeScreen.dart';
import 'package:guitarfashion/view/home/ProductDetail.dart';
import 'package:guitarfashion/view/login/LoginScreen.dart';
import 'package:guitarfashion/view/notification/NotificationScreen.dart';
import 'package:guitarfashion/view/onboard/OnBoard.dart';
import 'package:guitarfashion/view/register/RegisterScreen.dart';
import 'package:guitarfashion/view/search/SearchScreen.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => OnBoard());
      case '/cate':
        return MaterialPageRoute(builder: (_) => CategoryScreen(categoryItem: args,));
      case '/login':
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case '/register':
        return MaterialPageRoute(builder: (_) => RegisterScreen());
      case '/home':
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case '/detail':
        return MaterialPageRoute(builder: (_) => ProductDetail(args));
      case '/edit':
        return MaterialPageRoute(builder: (_) => EditScreen(args));
      case '/change_password':
        return MaterialPageRoute(builder: (_) => ChangePasswordScreen());
      case '/forget_password':
        return MaterialPageRoute(builder: (_) => ForgetPasswordScreen());
      case '/notification':
        return MaterialPageRoute(builder: (_) => NotificationScreen());
      case '/search':
        return MaterialPageRoute(builder: (_) => SearchScreen());
//      case '/newsdetail':
//        return MaterialPageRoute(builder: (_) => NewsDetail(args));
//      case '/videolist':
//        return MaterialPageRoute(builder: (_) => VideoList());
//      case '/documentlist':
//        return MaterialPageRoute(builder: (_) => DocumentList(args));
//      case '/pdfview':
//        return MaterialPageRoute(builder: (_) => PDFView(args));
//      case '/search':
//        return MaterialPageRoute(builder: (_) => Search());
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}
