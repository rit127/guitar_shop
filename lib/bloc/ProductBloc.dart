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
    ProductState productState = new ProductState(products: state.products, start: state.start, end:  state.end, isLoading: state.isLoading);

    // TODO: implement mapEventToState
    if(event is LoadDataEvent){
      productState.start = 0;
      productState.end = 10;
      fetchData();
      productState.isLoading = true;
      yield productState;
    }

    if(event is LoadMoreEvent) {
      if(!productState.isLoading) {
        print("LoadMoreEvent");
        productState.isLoading = true;
        fetchData(start: productState.start, end: productState.end);
        yield productState;
      }
    }

    if(event is UpdateData){
      if(productState.start == 0 ) {
        productState.products = event.list;
      } else {
        productState.products.addAll(event.list);
      }
      productState.start = productState.end + 1;
      productState.end = productState.end + 10;
      productState.isLoading = false;
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

  fetchData({int start = 0, int end = 10}) async {
    List<Product> listPro = await ProductRepository.getProduction(start, end);
    if(listPro.length>0){
      add(UpdateData(listPro));
    }else{
      add(FinishLoadData());
    }
  }
}