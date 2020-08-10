import 'package:guitarfashion/model/FavoriteModel.dart';

class FavoriteState {
  int start;
  int end;
  List<FavoriteModel> listFavorite;
  bool isLoading;

  FavoriteState({
    this.start,
    this.end,
    this.listFavorite,
    this.isLoading,
  });
}
