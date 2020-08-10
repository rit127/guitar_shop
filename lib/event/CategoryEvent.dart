
import 'package:guitarfashion/model/CategoryMenu.dart';
import 'package:guitarfashion/model/Product.dart';

abstract class CategoryEvent {
  List prop = const [];
}

class LoadCategory extends CategoryEvent {
  int categoryId;

  LoadCategory(this.categoryId);

  @override
  // TODO: implement props
  List<Object> get props => [this.categoryId];
}

class LoadCategoryByBrands extends CategoryEvent {
  int categoryId;
  Map<int, int> listBrand;
  String categoryName;

  LoadCategoryByBrands(this.categoryId, this.listBrand, this.categoryName);

  @override
  // TODO: implement props
  List<Object> get props => [this.categoryId, this.listBrand, this.categoryName];
}

class UpdateFavorite extends CategoryEvent {
  String productId;
  bool status;

  UpdateFavorite(this.productId, this.status);

  @override
  // TODO: implement props
  List<Object> get props => [productId, status];
}

class UpdateData extends CategoryEvent{

  List<Product> list;

  UpdateData(this.list);

  @override
  // TODO: implement props
  List<Object> get props => [list];
}

class LoadFavoriteProduct extends CategoryEvent {
  @override
  // TODO: implement props
  List<Object> get props => null;
}

class FinishLoadData extends CategoryEvent{
  @override
  // TODO: implement props
  List<Object> get props => null;
}

class LoadBrand extends CategoryEvent {
  @override
  // TODO: implement props
  List<Object> get props => null;
}