class ProductModel {
  final int id;
  final String title;
  final String description;
  final double price;
  final String image;
  final double rating;
  final String category;



  ProductModel({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.image,
    required this.rating,
    required this.category,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      title: json['title'],
      description: json['description'] ?? '',
      rating: json['rating'] ?? '',
      price: (json['price'] as num).toDouble(),
      image: (json['images'] != null && (json['images'] as List).isNotEmpty)
          ? json['images'][0]
          : '',
      category: json['category'] ?? '',

    );
  }
}
