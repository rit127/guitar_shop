import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guitarfashion/event/CategoryEvent.dart';
import 'package:guitarfashion/model/CategoryMenu.dart';
import 'package:guitarfashion/model/FavoriteModel.dart';
import 'package:guitarfashion/model/Product.dart';
import 'package:guitarfashion/model/UserModel.dart';
import 'package:guitarfashion/repository/AuthRepository.dart';
import 'package:guitarfashion/repository/BrandsRepository.dart';
import 'package:guitarfashion/repository/FavoriteRepository.dart';
import 'package:guitarfashion/state/CategoryState.dart';
import 'package:guitarfashion/utils/Api.dart';
import 'package:http/http.dart' as http;

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  @override
  // TODO: implement initialState
  CategoryState get initialState => CategoryState();

  @override
  Stream<CategoryState> mapEventToState(CategoryEvent event) async* {
    CategoryState categoryState = new CategoryState(
      listProduct: state.listProduct,
      listBrands: state.listBrands,
      isLoading: state.isLoading,
      page: state.page,
      isFilter: state.isFilter,
      categoryName: state.categoryName,
      listFavorite: state.listFavorite,
    );

    // TODO: implement mapEventToState
    if (event is LoadCategory) {
      print("List Pro123 ${categoryState.listProduct}");
      if(categoryState.listProduct != null) {
        categoryState.listProduct = null;
      }else {
        categoryState.listProduct = [];
      }
      categoryState.listProduct = null;
      categoryState.isFilter = false;
      fetchListOfCategory(event.categoryId);
      categoryState.isLoading = true;
      yield categoryState;
    }

    if(event is LoadCategoryByBrands) {
      categoryState.listProduct = null;
      categoryState.isFilter = true;
      categoryState.isLoading = true;
      categoryState.categoryName = event.categoryName;
      yield categoryState;
      fetchListCategoryOfBrands(event.categoryId,event.listBrand);
    }

    if (event is UpdateFavorite) {
      Product tmp = categoryState.listProduct.firstWhere(
              (element) => element.id.toString() == event.productId,
          orElse: () => null);

      FavoriteModel tmpFav = new FavoriteModel(
        id: tmp.id,
        price: tmp.price,
        code: tmp.code,
        description: tmp.description,
        productType: tmp.productType,
      );

      if (event.status) {
        //Favorite
        if (tmp != null) {
          categoryState.listFavorite.add(tmpFav);
        }
      } else {
        //UnFavorite
        if (tmp != null) {
          int proIndex = categoryState.listFavorite.indexWhere((element) => element.id == tmpFav.id);
          print(proIndex);
          categoryState.listFavorite.removeAt(proIndex);
        }
      }
      yield categoryState;
    }
    
    if (event is UpdateData) {
      print("UpdateData :${categoryState.page}");
      categoryState.listProduct = event.list;
      categoryState.isLoading = false;
//      categoryState.page = categoryState.page+1;
      yield categoryState;
    }

    if(event is FinishLoadData){
      print("else FinishLoadData Pro123 ${state.listProduct}");
      categoryState.isLoading = false;
      yield categoryState;
    }

    if(event is LoadFavoriteProduct) {
      UserModel currentUser = await AuthRepository.getUser();

      List<FavoriteModel> myFavorite = await FavoriteRepository.getListFavorite(currentUser.customer.toString());

      categoryState.listFavorite = myFavorite;

      yield categoryState;
    }

    if (event is LoadBrand) {}

  }

  fetchListOfCategory(int cateId) async {
    var response = await http.get(Api.list_category + cateId.toString() + "&_sort=id:DESC");

    if (response.statusCode == 200) {
      //Request Success 200
      Iterable list = jsonDecode(response.body);
      List<Product> listPro = list.map((e) => Product.fromJson(e)).toList();
      if (listPro.length > 0) {
        add(UpdateData(listPro));
      } else {
        add(FinishLoadData());
      }
    }
  }

  fetchListCategoryOfBrands(int categoryId, Map<int, int> listBrands) async {
    List<Product> listPro = await BrandsRepository.fetchCategoryOfBrands(categoryId, listBrands);

    if(listPro.length>0){
      add(UpdateData(listPro));
    }else{
      add(FinishLoadData());
    }
  }
}
