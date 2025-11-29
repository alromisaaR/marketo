import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/data/category_model.dart';
import '../../data/data/product_model.dart';
import '../../data/data/home_repo.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeRepo repo;

  List<CategoryModel> allCategories = [];
  List<ProductModel> allProducts = [];
  List<ProductModel> filteredProducts = [];

  HomeCubit(this.repo) : super(HomeInitial());

  void loadData() async {
    emit(HomeLoading());
    try {
      allCategories = await repo.fetchCategories();
      allProducts = await repo.fetchProducts();

      filteredProducts = List.from(allProducts);

      emit(HomeSuccess(allCategories, filteredProducts));
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }

  void filterByCategory(String slug) {
    filteredProducts = allProducts
        .where((p) => p.category.toLowerCase() == slug.toLowerCase())
        .toList();
    emit(HomeSuccess(allCategories, filteredProducts));
  }
}






