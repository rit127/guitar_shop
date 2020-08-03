import 'package:guitarfashion/model/Product.dart';

class ProductState {
  List<Product> products;
  int page;
  bool isLoading;


  ProductState({
    this.products,
    this.page,
    this.isLoading,
  });
}
