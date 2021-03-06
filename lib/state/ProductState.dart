import 'package:guitarfashion/model/FavoriteModel.dart';
import 'package:guitarfashion/model/Product.dart';

class ProductState {
  List<Product> products;
  int start;
  int end;
  bool isLoading;
  List<FavoriteModel> listFavorite;

  ProductState({
    this.products,
    this.start,
    this.end,
    this.isLoading,
    this.listFavorite,
  });
}
