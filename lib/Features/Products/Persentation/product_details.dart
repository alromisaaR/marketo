import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/data/product_model.dart';
import '../../cart/persentation/cubit/cart_cubit.dart';
import '../../cart/data/cart_item.dart';
import '../../favorite/data/favorite_item.dart';
import '../../favorite/persentation/cubit/favorite_cubit.dart';

class ProductDetailsScreen extends StatelessWidget {
  final ProductModel product;

  const ProductDetailsScreen({Key? key, required this.product})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Details")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 300,
              width: double.infinity,
              color: Colors.grey[200],
              child: product.image.isNotEmpty
                  ? Image.network(product.image, fit: BoxFit.cover)
                  : const Center(child: Text("No Image")),
            ),
            const SizedBox(height: 16),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    product.title,
                    style: const TextStyle(
                        fontSize: 22, fontWeight: FontWeight.bold),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                BlocBuilder<FavoritesCubit, List<FavoriteItem>>(
                  builder: (context, favItems) {
                    final isFavorited =
                    context.read<FavoritesCubit>().isFavorite(product.id);
                    return IconButton(
                      icon: Icon(
                        isFavorited ? Icons.favorite : Icons.favorite_border,
                        color: Colors.red,
                        size: 28,
                      ),
                      onPressed: () {
                        final favItem = FavoriteItem(
                          productId: product.id,
                          title: product.title,
                          thumbnail: product.image,
                          price: product.price,
                          rating: product.rating,
                        );
                        context.read<FavoritesCubit>().toggleFavorite(favItem);

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(isFavorited
                                ? "${product.title} removed from favorites!"
                                : "${product.title} added to favorites!"),
                          ),
                        );
                      },
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 8),

            Text("${product.price} LE",
                style: const TextStyle(fontSize: 18, color: Colors.green)),
            const SizedBox(height: 8),
            Row(
              children: List.generate(5, (index) {
                return Icon(
                  index < product.rating.round()
                      ? Icons.star
                      : Icons.star_border,
                  color: Colors.amber,
                );
              }),
            ),
            const SizedBox(height: 16),

            const Text("Description",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(product.description, style: const TextStyle(fontSize: 14)),
            const SizedBox(height: 24),

            Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  final cartItem = CartItem(
                    productId: product.id,
                    title: product.title,
                    price: product.price,
                    quantity: 1,
                    thumbnail: product.image,
                  );
                  context.read<CartCubit>().addToCart(cartItem);

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("${product.title} added to cart!"),
                    ),
                  );
                },
                icon: const Icon(Icons.add_shopping_cart),
                label: const Text("Add to Cart"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amber,
                  foregroundColor: Colors.white,
                  padding:
                  const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  textStyle:
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


