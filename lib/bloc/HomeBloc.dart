import 'dart:async';
import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:guitarfashion/utils/Api.dart';
import 'package:http/http.dart' as http;
import 'package:guitarfashion/event/HomeEvent.dart';
import 'package:guitarfashion/model/CategoryMenu.dart';
import 'package:guitarfashion/model/Product.dart';
import 'package:guitarfashion/repository/ProductRepository.dart';
import 'package:guitarfashion/state/HomeState.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  @override
  HomeState get initialState => HomeState();

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    HomeState homeState = HomeState(drawerMenu: state.drawerMenu);

    // TODO: Add Logic
    if (event is LoadDrawerMenu) {
      List<CategoryMenu> list = await getDrawerMenu();
      homeState.drawerMenu = list;
      print("he ${list.length}");
      yield homeState;
    }
  }

  getDrawerMenu() async {
    var response = await http.get(Api.category);

    if (response.statusCode == 200) {
      //Request Success 200
      Iterable listMenu = jsonDecode(response.body);
      List<CategoryMenu> listDrawerMenu =
          listMenu.map((e) => CategoryMenu.fromJson(e)).toList();

      return listDrawerMenu;
    }
  }
}
