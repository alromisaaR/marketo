import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../cart/data/cart_item.dart';
import '../../../cart/persentation/cubit/cart_cubit.dart';
import '../../data/favorite_item.dart';
import '../cubit/favorite_cubit.dart';


class FavScreen extends StatelessWidget {
  const FavScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<FavoritesCubit, List<FavoriteItem>>(
        builder: (context, favorites) {
          if (favorites.isEmpty) {
            return const Center(
              child: Text('No favorites yet!'),
            );
          }

          return ListView.builder(
            itemCount: favorites.length,
            itemBuilder: (context, index) {
              final item = favorites[index];
              return ListTile(
                leading: Image.network(
                  item.thumbnail,
                  width: 50,
                  errorBuilder: (context, error, stackTrace) =>
                  const Icon(Icons.image_not_supported),
                ),
                title: Text(item.title),
                subtitle: Text('Price: ${item.price} LE'),
                trailing: SizedBox(
                  width: 110,
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          context.read<FavoritesCubit>().toggleFavorite(item);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content: Text(
                                    '${item.title} removed from favorites')),
                          );
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.add_shopping_cart,
                            color: Colors.green),
                        onPressed: () {
                          final cartItem = CartItem(
                            productId: item.productId,
                            title: item.title,
                            price: item.price,
                            quantity: 1,
                            thumbnail: item.thumbnail,
                          );
                          context.read<CartCubit>().addToCart(cartItem);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content:
                                Text('${item.title} added to cart')),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
