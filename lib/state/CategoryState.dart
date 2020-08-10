import 'package:guitarfashion/model/CategoryMenu.dart';
import 'package:guitarfashion/model/FavoriteModel.dart';
import 'package:guitarfashion/model/Product.dart';

class CategoryState {
  List<Product> listProduct;
  List<CategoryMenu> listBrands;
  int page;
  bool isLoading;
  bool isFilter;
  String categoryName;
  List<FavoriteModel> listFavorite;

  CategoryState({
    this.listProduct,
    this.listBrands,
    this.page,
    this.isLoading,
    this.isFilter,
    this.categoryName,
    this.listFavorite,
  });
}
