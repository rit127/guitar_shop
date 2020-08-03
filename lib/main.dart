import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guitarfashion/RouteGenerator.dart';
import 'package:guitarfashion/bloc/AccountBloc.dart';
import 'package:guitarfashion/bloc/CategoryBloc.dart';
import 'package:guitarfashion/bloc/HomeBloc.dart';
import 'package:guitarfashion/bloc/ProductBloc.dart';
import 'package:guitarfashion/utils/AppThemeData.dart';

void main() {
  runApp(MyApp());
}

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
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: AppThemeData,
        initialRoute: '/',
        onGenerateRoute: RouteGenerator.generateRoute,
      ),
    );
  }
}

