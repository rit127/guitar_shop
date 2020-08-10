

import 'package:guitarfashion/model/FavoriteModel.dart';

abstract class FavoriteEvent {
  List prop = const [];
}

class LoadData extends FavoriteEvent {
  @override
  // TODO: implement props
  List<Object> get props => null;
}

class LoadMoreEvent extends FavoriteEvent{

  @override
  // TODO: implement props
  List<Object> get props => null;
}

class onFavorite extends FavoriteEvent {
  FavoriteModel favoriteModel;

  onFavorite(this.favoriteModel);

  @override
  // TODO: implement props
  List<Object> get props => [favoriteModel];
}

class UnFavorite extends FavoriteEvent {
  FavoriteModel favoriteModel;

  UnFavorite(this.favoriteModel);

  @override
  // TODO: implement props
  List<Object> get props => [favoriteModel];
}

class UpdateData extends FavoriteEvent{

  List<FavoriteModel> list;

  UpdateData(this.list);

  @override
  // TODO: implement props
  List<Object> get props => [list];
}

class FinishLoadData extends FavoriteEvent{

  @override
  // TODO: implement props
  List<Object> get props => null;
}