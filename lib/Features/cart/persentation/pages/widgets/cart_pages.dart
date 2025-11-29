import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubit/cart_cubit.dart';
import '../../cubit/cart_state.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        if (state is CartInitial) {
          return Center(child: CircularProgressIndicator());
        } else if (state is CartLoaded) {
          final items = state.items;
          if (items.isEmpty) {
            return Center(child: Text('Cart is empty'));
          }

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    final item = items[index];
                    return ListTile(
                      leading: Image.network(item.thumbnail, width: 50),
                      title: Text(item.title),
                      subtitle: Text('Price: \$${item.price}'),
                      trailing: SizedBox(
                        width: 120,
                        child: Row(
                          children: [
                            IconButton(
                              icon: Icon(Icons.remove),
                              onPressed: () {
                                if (item.quantity > 1) {
                                  context
                                      .read<CartCubit>()
                                      .updateQuantity(item.productId, item.quantity - 1);
                                } else {
                                  context
                                      .read<CartCubit>()
                                      .removeFromCart(item.productId);
                                }
                              },
                            ),
                            Text('${item.quantity}'),
                            IconButton(
                              icon: Icon(Icons.add),
                              onPressed: () {
                                context
                                    .read<CartCubit>()
                                    .updateQuantity(item.productId, item.quantity + 1);
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total: \$${state.total.toStringAsFixed(2)}',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        context.read<CartCubit>().clearCart();
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Checkout successful! Cart is cleared.'),
                            backgroundColor: Colors.green,
                          ),
                        );
                      },
                      child: Text('Checkout'),
                    )
                  ],
                ),
              )
            ],
          );
        } else {
          return SizedBox();
        }
      },
    );
  }
}

