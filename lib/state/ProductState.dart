import 'package:guitarfashion/model/Product.dart';

class ProductState {
  List<Product> products;
  int start;
  int end;
  bool isLoading;


  ProductState({
    this.products,
    this.start,
    this.end,
    this.isLoading,
  });
}
