import 'package:dio/dio.dart';
import 'package:marketo/Features/Products/data/data/product_model.dart';

import 'category_model.dart';

class ApiService {
  final Dio dio;

  ApiService()
      : dio = Dio(
    BaseOptions(
      baseUrl: 'https://dummyjson.com/',
      connectTimeout: Duration(seconds: 15),
    ),
  );

  Future<List<CategoryModel>> getCategories() async {
    final response = await dio.get('products/categories');

    print("CATEGORIES RESPONSE: ${response.data}");

    return (response.data as List)
        .map((item) => CategoryModel.fromJson(item))
        .toList();
  }

  Future<List<ProductModel>> getProducts() async {
    try {
      final response = await dio.get('products');
      print("PRODUCTS RESPONSE: ${response.data['products']}");
      return (response.data['products'] as List)
          .map((p) => ProductModel.fromJson(p))
          .toList();
    } catch (e, st) {
      print("ERROR FETCHING PRODUCTS: $e");
      print(st);
      return [];
    }
  }

}
