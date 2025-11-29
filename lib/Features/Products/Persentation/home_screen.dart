import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../Welcom/login_screen.dart';
import '../../cart/data/cart_item.dart';
import '../../cart/persentation/cubit/cart_cubit.dart';
import '../../cart/persentation/pages/widgets/cart_pages.dart';
import '../../favorite/data/favorite_item.dart';
import '../../favorite/persentation/cubit/favorite_cubit.dart';
import '../../favorite/persentation/pages/favorites.page.dart';
import '../data/data/home_repo.dart';
import '../data/data/api_service.dart';
import '../data/data/category_model.dart';
import '../data/data/product_model.dart';
import 'Cubits/home_cubit.dart';
import 'Cubits/home_state.dart';
import 'product_details.dart';

class HomeScreen extends StatefulWidget {
  final VoidCallback toggleTheme;
  final VoidCallback toggleLanguage;

  const HomeScreen({
    Key? key,
    required this.toggleTheme,
    required this.toggleLanguage,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<HomeCubit>(
          create: (_) => HomeCubit(HomeRepo(api: ApiService()))..loadData(),
        ),
        BlocProvider<CartCubit>(
          create: (_) => CartCubit(Hive.box('cartBox')),
        ),
        BlocProvider<FavoritesCubit>(
          create: (_) => FavoritesCubit(Hive.box('favBox')),
        ),
      ],
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text(_currentIndex == 0
                ? "Products".tr()
                : _currentIndex == 1
                ? "favorites".tr()
                : "cart".tr()),
            actions: [
              IconButton(
                  icon: const Icon(Icons.brightness_6),
                  onPressed: widget.toggleTheme),
              IconButton(
                  icon: const Icon(Icons.language),
                  onPressed: widget.toggleLanguage),
              IconButton(
                icon: const Icon(Icons.logout),
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => LoginScreen(
                        toggleTheme: widget.toggleTheme,
                        toggleLanguage: widget.toggleLanguage,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
          body: _buildBody(),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: _currentIndex,
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.favorite), label: "Fav"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.shopping_cart), label: "Cart"),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBody() {
    switch (_currentIndex) {
      case 0:
        return _buildProductsScreen();
      case 1:
        return FavScreen();
      case 2:
        return CartScreen();
      default:
        return const Center(child: Text("Error"));
    }
  }

  Widget _buildProductsScreen() {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state is HomeLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is HomeSuccess) {
          return Column(
            children: [
              const SizedBox(height: 20),
              SizedBox(
                height: 40,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: state.categories.length,
                  itemBuilder: (_, i) {
                    final CategoryModel c = state.categories[i];
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: ElevatedButton(
                        onPressed: () {
                          context.read<HomeCubit>().filterByCategory(c.slug);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFFDD835),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                        ),
                        child: Text(
                          c.name,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: GridView.builder(
                  padding: const EdgeInsets.all(10),
                  itemCount: state.products.length,
                  gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    childAspectRatio: 0.62,
                  ),
                  itemBuilder: (_, i) {
                    final ProductModel p = state.products[i];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => MultiBlocProvider(
                              providers: [
                                BlocProvider.value(
                                  value: context.read<CartCubit>(),
                                ),
                                BlocProvider.value(
                                  value: context.read<FavoritesCubit>(),
                                ),
                              ],
                              child: ProductDetailsScreen(product: p),
                            ),
                          ),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Theme.of(context).cardColor,
                          boxShadow: const [
                            BoxShadow(
                                color: Colors.black12,
                                blurRadius: 5,
                                offset: Offset(0, 2))
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            ClipRRect(
                              borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(10),
                              ),
                              child: Image.network(
                                p.image,
                                height: 125,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) =>
                                const Icon(Icons.image_not_supported,
                                    size: 50),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.stretch,
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: Text(
                                                p.title,
                                                style: const TextStyle(
                                                    fontWeight:
                                                    FontWeight.bold),
                                                maxLines: 1,
                                                overflow:
                                                TextOverflow.ellipsis,
                                              ),
                                            ),
                                            BlocBuilder<FavoritesCubit,
                                                List<FavoriteItem>>(
                                                builder: (context, favItems) {
                                                  final isFav = context
                                                      .read<FavoritesCubit>()
                                                      .isFavorite(p.id);
                                                  return IconButton(
                                                    icon: Icon(
                                                      isFav
                                                          ? Icons.favorite
                                                          : Icons.favorite_border,
                                                      color: Colors.red,
                                                      size: 20,
                                                    ),
                                                    onPressed: () {
                                                      final favItem = FavoriteItem(
                                                        productId: p.id,
                                                        title: p.title,
                                                        thumbnail: p.image,
                                                        price: p.price,
                                                        rating: p.rating,
                                                      );
                                                      context
                                                          .read<FavoritesCubit>()
                                                          .toggleFavorite(favItem);
                                                    },
                                                  );
                                                }),
                                          ],
                                        ),
                                        const SizedBox(height: 5),
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "${p.price} LE",
                                              style: const TextStyle(
                                                color: Colors.green,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                const Icon(Icons.star,
                                                    color: Colors.amber,
                                                    size: 16),
                                                const SizedBox(width: 3),
                                                Text(
                                                  p.rating
                                                      .toStringAsFixed(1),
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 14,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    ElevatedButton.icon(
                                      onPressed: () {
                                        final cartItem = CartItem(
                                          productId: p.id,
                                          title: p.title,
                                          price: p.price,
                                          quantity: 1,
                                          thumbnail: p.image,
                                        );
                                        context
                                            .read<CartCubit>()
                                            .addToCart(cartItem);
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                            content: Text(
                                                "${p.title} added to cart")));
                                      },
                                      icon: const Icon(Icons.add_shopping_cart,
                                          size: 14, color: Colors.white),
                                      label: const Text(
                                        "Add to Cart",
                                        style: TextStyle(
                                            fontSize: 12, color: Colors.white),
                                      ),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.amber,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(15),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        }

        return const Center(child: Text("Error loading data"));
      },
    );
  }
}








