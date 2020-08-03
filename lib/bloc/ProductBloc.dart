import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guitarfashion/event/ProductEvent.dart';
import 'package:guitarfashion/model/Product.dart';
import 'package:guitarfashion/repository/ProductRepository.dart';
import 'package:guitarfashion/state/ProductState.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {

  @override
  // TODO: implement initialState
  ProductState get initialState => ProductState();

  @override
  Stream<ProductState> mapEventToState(ProductEvent event) async* {
    ProductState productState = new ProductState(products: state.products, page: state.page, isLoading: state.isLoading);

    // TODO: implement mapEventToState
    if(event is LoadDataEvent){
      fetchData();
      productState.page = 1;
      productState.isLoading = true;
      yield ProductState();
    }

    if(event is UpdateData){
      print("UpdateData :${productState.page}");
      productState.products = event.list;
      productState.isLoading = false;
//      productState.page = productState.page+1;
      yield productState;
    }

    if(event is FinishLoadData){
      productState.isLoading = false;
      yield productState;
    }

//    if(event is UpdateViewCount){
//      print(event.slug);
//      newsRepository.updateViewCount(event.slug);
//    }
  }

  fetchData({int page = 0}) async {
    List<Product> listPro = await ProductRepository.getProduction();
    if(listPro.length>0){
      add(UpdateData(listPro));
    }else{
      add(FinishLoadData());
    }
  }
}