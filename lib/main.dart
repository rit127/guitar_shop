import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guitarfashion/RouteGenerator.dart';
import 'package:guitarfashion/bloc/AccountBloc.dart';
import 'package:guitarfashion/bloc/CategoryBloc.dart';
import 'package:guitarfashion/bloc/FavoriteBloc.dart';
import 'package:guitarfashion/bloc/HomeBloc.dart';
import 'package:guitarfashion/bloc/ProductBloc.dart';
import 'package:guitarfashion/utils/AppThemeData.dart';

void main() => runApp(
  DevicePreview(
    enabled: true,
    builder: (context) => MyApp(),
  ),
);

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<HomeBloc>(
          create: (context)=>HomeBloc(),
        ),
        BlocProvider<ProductBloc>(
          create: (context) => ProductBloc(),
        ),
        BlocProvider<CategoryBloc>(
          create: (context) => CategoryBloc(),
        ),
        BlocProvider<AccountBloc>(
          create: (context) => AccountBloc(),
        ),
        BlocProvider<FavoriteBloc>(
          create: (context) => FavoriteBloc(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        builder: DevicePreview.appBuilder,
        theme: AppThemeData,
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        onGenerateRoute: RouteGenerator.generateRoute,
      ),
    );
  }
}

