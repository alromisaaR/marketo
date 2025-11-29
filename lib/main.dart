import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'Features/Splash/splash_screen.dart';
import 'Features/cart/data/cart_item.dart';
import 'Features/cart/persentation/cubit/cart_cubit.dart';
import 'Features/favorite/data/favorite_item.dart';
import 'Features/favorite/persentation/cubit/favorite_cubit.dart';
import 'core/theme.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();


  await Firebase.initializeApp();


  await EasyLocalization.ensureInitialized();

  await Hive.initFlutter();

  Hive.registerAdapter(CartItemAdapter());

  final cartBox = await Hive.openBox<CartItem>('cartBox');

  Hive.registerAdapter(FavoriteItemAdapter());
  final favBox = await Hive.openBox<FavoriteItem>('favBox');

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ar')],
      path: 'assets/lang',
      fallbackLocale: const Locale('en'),
      child: MultiBlocProvider(
        providers: [
          BlocProvider<CartCubit>(create: (_) => CartCubit(cartBox)),
          BlocProvider<FavoritesCubit>(create: (_) => FavoritesCubit(favBox)),
        ],
        child: const MyApp(),
      ),

    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.light;
  Locale _locale = const Locale('en');

  void toggleTheme() {
    setState(() {
      _themeMode =
      _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    });
  }

  void toggleLanguage() {
    final newLocale = _locale.languageCode == 'en'
        ? const Locale('ar')
        : const Locale('en');

    setState(() => _locale = newLocale);

    EasyLocalization.of(context)?.setLocale(newLocale);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppThemes.lightTheme,
      darkTheme: AppThemes.darkTheme,
      themeMode: _themeMode,
      locale: _locale,
      supportedLocales: context.supportedLocales,
      localizationsDelegates: context.localizationDelegates,
      home: SplashScreen(
        toggleTheme: toggleTheme,
        toggleLanguage: toggleLanguage,
      ),
    );
  }
}

