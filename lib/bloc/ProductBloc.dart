import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guitarfashion/event/ProductEvent.dart';
import 'package:guitarfashion/model/FavoriteModel.dart';
import 'package:guitarfashion/model/Product.dart';
import 'package:guitarfashion/model/UserModel.dart';
import 'package:guitarfashion/repository/AuthRepository.dart';
import 'package:guitarfashion/repository/FavoriteRepository.dart';
import 'package:guitarfashion/repository/ProductRepository.dart';
import 'package:guitarfashion/state/ProductState.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  @override
  // TODO: implement initialState
  ProductState get initialState => ProductState();

  @override
  Stream<ProductState> mapEventToState(ProductEvent event) async* {
    ProductState productState = new ProductState(
      products: state.products,
      start: state.start,
      end: state.end,
      isLoading: state.isLoading,
      listFavorite: state.listFavorite,
    );

    // TODO: implement mapEventToState
    if (event is LoadDataEvent) {
      productState.start = 0;
      productState.end = 10;
      fetchData();
      productState.isLoading = true;
      yield productState;
    }

    if (event is LoadMoreEvent) {
      if (!productState.isLoading) {
        print("LoadMoreEvent");
        productState.isLoading = true;
        fetchData(start: productState.start, end: productState.end);
        yield productState;
      }
    }

    if (event is UpdateFavorite) {
      Product tmp = productState.products.firstWhere(
          (element) => element.id.toString() == event.productId,
          orElse: () => null);

      print("tmp ${tmp}");

      FavoriteModel tmpFav = new FavoriteModel(
        id: tmp.id,
        price: tmp.price,
        code: tmp.code,
        description: tmp.description,
        productType: tmp.productType,
      );

      print("tmpFav $tmpFav");

      if (event.status) {
        //Favorite
        if (tmp != null) {
          productState.listFavorite.add(tmpFav);
        }
      } else {
        //UnFavorite
        if (tmp != null) {
          int proIndex = productState.listFavorite.indexWhere((element) => element.id == tmpFav.id);
          print(proIndex);
          productState.listFavorite.removeAt(proIndex);
        }
      }
      yield productState;
    }

    if (event is UpdateData) {
      if (productState.start == 0) {
        productState.products = event.list;
      } else {
        productState.products.addAll(event.list);
      }
      productState.start = productState.end + 1;
      productState.end = productState.end + 10;
      productState.isLoading = false;
      yield productState;
    }

    if(event is LoadFavoriteProduct) {
      UserModel currentUser = await AuthRepository.getUser();

      List<FavoriteModel> myFavorite = await FavoriteRepository.getListFavorite(currentUser.customer.toString());

      productState.listFavorite = myFavorite;

      yield productState;
    }

    if (event is FinishLoadData) {
      productState.isLoading = false;
      yield productState;
    }

//    if(event is UpdateViewCount){
//      print(event.slug);
//      newsRepository.updateViewCount(event.slug);
//    }
    if(event is ClearFavorite) {
      productState.listFavorite = [];
      yield productState;
    }
  }

  fetchData({int start = 0, int end = 10}) async {
    List<Product> listPro = await ProductRepository.getProduction(start, end);
    if (listPro.length > 0) {
      add(UpdateData(listPro));
    } else {
      add(FinishLoadData());
    }
  }

}
