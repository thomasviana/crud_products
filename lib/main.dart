import 'package:crud_products/providers/auth.dart';
import 'package:crud_products/providers/products.dart';
import 'package:crud_products/screens/auth_screen.dart';
import 'package:crud_products/screens/edit_product_screen.dart';
import 'package:crud_products/screens/home_screen.dart';
import 'package:crud_products/screens/manage_products_screen.dart';
import 'package:crud_products/screens/product_info_%20screen.dart';
import 'package:crud_products/screens/welcome_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<Auth>(
          create: (ctx) => Auth(),
        ),
        ChangeNotifierProxyProvider<Auth, Products>(
          create: (ctx) =>
              Products(Provider.of<Auth>(ctx, listen: false).userId),
          update: (ctx, auth, _) => Products(
            auth.userId,
          ),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'CRUD Products',
        theme: ThemeData(
          primarySwatch: Colors.pink,
          appBarTheme: AppBarTheme(centerTitle: true),
        ),
        home: WelcomeScreen(),
        routes: {
          AuthScreen.routeName: (ctx) => AuthScreen(),
          HomeScreen.routeName: (ctx) => HomeScreen(),
          ProductInfoScreen.routeName: (ctx) => ProductInfoScreen(),
          ManageProductsScreen.routeName: (ctx) => ManageProductsScreen(),
          EditProductScreen.routeName: (ctx) => EditProductScreen(),
        },
      ),
    );
  }
}
