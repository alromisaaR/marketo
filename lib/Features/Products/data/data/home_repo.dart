import 'category_model.dart';
import 'product_model.dart';
import 'api_service.dart';

class HomeRepo {
  final ApiService api;

  HomeRepo({required this.api});

  Future<List<CategoryModel>> fetchCategories() => api.getCategories();

  Future<List<ProductModel>> fetchProducts() async {
    return await api.getProducts();
  }
  }


