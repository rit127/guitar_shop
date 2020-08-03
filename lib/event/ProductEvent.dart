
import 'package:guitarfashion/model/Product.dart';

abstract class ProductEvent {
  List prop = const [];
}

class LoadDataEvent extends ProductEvent{
  @override
  // TODO: implement props
  List<Object> get props => null;
}

class LoadMoreEvent extends ProductEvent{

  @override
  // TODO: implement props
  List<Object> get props => null;
}

class UpdateData extends ProductEvent{

  List<Product> list;

  UpdateData(this.list);

  @override
  // TODO: implement props
  List<Object> get props => [list];
}

class FinishLoadData extends ProductEvent{

  @override
  // TODO: implement props
  List<Object> get props => null;
}

class UpdateViewCount extends ProductEvent{

  String slug;

  UpdateViewCount(this.slug);

  @override
  // TODO: implement props
  List<Object> get props => [this.slug];
}