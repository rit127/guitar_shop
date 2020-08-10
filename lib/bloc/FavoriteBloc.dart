import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guitarfashion/event/FavoriteEvent.dart';
import 'package:guitarfashion/model/FavoriteModel.dart';
import 'package:guitarfashion/model/Product.dart';
import 'package:guitarfashion/model/UserModel.dart';
import 'package:guitarfashion/repository/AuthRepository.dart';
import 'package:guitarfashion/repository/FavoriteRepository.dart';
import 'package:guitarfashion/state/FavoriteState.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  @override
  // TODO: implement initialState
  FavoriteState get initialState => FavoriteState();

  @override
  Stream<FavoriteState> mapEventToState(FavoriteEvent event) async* {

    FavoriteState favoriteState = new FavoriteState(
      start: state.start,
      end: state.end,
      listFavorite: state.listFavorite,
    );

    if (event is LoadData) {
      favoriteState.start = 0;
      favoriteState.end = 10;
      fetchFavorite();
      favoriteState.isLoading = true;
      yield favoriteState;
    }
    
    if(event is LoadMoreEvent) {
      if(!favoriteState.isLoading) {
        print("LoadMoreEvent");
        favoriteState.isLoading = true;
        fetchFavorite(start: favoriteState.start, end: favoriteState.end);
        yield favoriteState;
      }
    }

    if(event is UpdateData){
      if(favoriteState.start == 0 ) {
        print("fetchFavorite Here");
        favoriteState.listFavorite = event.list;
      } else {
        print("fetchFavorite not Here");
        favoriteState.listFavorite.addAll(event.list);
      }
      favoriteState.start = favoriteState.end + 1;
      favoriteState.end = favoriteState.end + 10;
      favoriteState.isLoading = false;
      yield favoriteState;
    }

    if(event is onFavorite) {
      favoriteState.listFavorite.add(event.favoriteModel);
      yield favoriteState;
    }

    if(event is UnFavorite) {
      favoriteState.listFavorite.removeWhere((element) => element.id == event.favoriteModel.id);
      yield favoriteState;
    }

    if(event is FinishLoadData){
      favoriteState.isLoading = false;
      yield favoriteState;
    }
  }

  fetchFavorite({int start = 0, int end = 10}) async {
    UserModel currentUser = await AuthRepository.getUser();

    List<FavoriteModel> listFavorite =
        await FavoriteRepository.getListFavoritePagination(
      customerId: currentUser.customer.toString(),
      start: start,
      end: end,
    );


    if(listFavorite.length > 0) {
      add(UpdateData(listFavorite));
    } else {
      add(FinishLoadData());
    }
  }
}
