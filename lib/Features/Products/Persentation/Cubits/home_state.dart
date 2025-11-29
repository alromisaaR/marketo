import '../../data/data/category_model.dart';
import '../../data/data/product_model.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}
class HomeLoading extends HomeState {}
class HomeSuccess extends HomeState {
  final List<CategoryModel> categories;
  final List<ProductModel> products;

  HomeSuccess(this.categories, this.products);
}
class HomeCategoryFiltered extends HomeState {
  final List<ProductModel> filteredProducts;
  final List<CategoryModel> categories;

  HomeCategoryFiltered({
    required this.filteredProducts,
    required this.categories,
  });
}
class HomeError extends HomeState {
  final String message;
  HomeError(this.message);
}



