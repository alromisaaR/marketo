import 'dart:ui';

class CategoryModel {
  final String slug;
  final String name;
  final String url;
  final image;


  CategoryModel({
    required this.slug,
    required this.name,
    required this.url,
    required this.image,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      slug: json['slug'] ?? '',
      name: json['name'] ?? '',
      url: json['url'] ?? '',
      image: json['image']?? '');
  }
}


