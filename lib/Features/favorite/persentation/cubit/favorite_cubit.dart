import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import '../../data/favorite_item.dart';

class FavoritesCubit extends Cubit<List<FavoriteItem>> {
  final Box<FavoriteItem> favBox;
  FavoritesCubit(this.favBox) : super(favBox.values.toList());
  Future<void> loadFavorites() async {
    emit(favBox.values.toList());

  }
  Future<void> toggleFavorite(FavoriteItem item) async {
    if (favBox.containsKey(item.productId)) {
      await favBox.delete(item.productId);
    } else {
      await favBox.put(item.productId, item);
    }
    emit(favBox.values.toList());
  }

  bool isFavorite(int productId) => favBox.containsKey(productId);


}