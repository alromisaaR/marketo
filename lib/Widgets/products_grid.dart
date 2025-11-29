import 'package:flutter/material.dart';

import '../Features/Products/data/data/product_model.dart';


class ProductsGrid extends StatelessWidget {
  final List<ProductModel> products;

  ProductsGrid({required this.products});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: products.length,
      gridDelegate:
      SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemBuilder: (_, i) {
        final p = products[i];
        return GestureDetector(
          // onTap: () => Hive.box("cart").put(p.id, p.toJson()),
          child: Card(
            child: Column(
              children: [
                Image.network(p.image),
                Text(p.title),
                Text("${p.price} LE"),
              ],
            ),
          ),
        );
      },
    );
  }
}
