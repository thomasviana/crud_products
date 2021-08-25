import 'package:crud_products/constants.dart';
import 'package:crud_products/custom/rounded_button.dart';
import 'package:crud_products/providers/products.dart';
import 'package:crud_products/screens/edit_product_screen.dart';
import 'package:crud_products/widgets/app_drawer.dart';
import 'package:crud_products/widgets/user_product_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ManageProductsScreen extends StatefulWidget {
  static const routeName = '/manage-products-screen';

  @override
  _ManageProductsScreenState createState() => _ManageProductsScreenState();
}

class _ManageProductsScreenState extends State<ManageProductsScreen> {
  Future<void> _refreshProducts(BuildContext context) async {
    await Provider.of<Products>(context, listen: false).getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Administrar Productos'),
        flexibleSpace: appBarGradient,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(
                EditProductScreen.routeName,
              );
            },
            icon: const Icon(
              Icons.add,
            ),
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: Stack(
        alignment: Alignment.center,
        children: [
          FutureBuilder(
            future: _refreshProducts(context),
            builder: (ctx, snapshot) =>
                snapshot.connectionState == ConnectionState.waiting
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : RefreshIndicator(
                        onRefresh: () => _refreshProducts(context),
                        child: Consumer<Products>(
                          builder: (ctx, productsData, _) => Padding(
                            padding: const EdgeInsets.all(8),
                            child: ListView.builder(
                              physics: BouncingScrollPhysics(),
                              itemCount: productsData.items.length,
                              itemBuilder: (ctx, i) => Column(
                                children: [
                                  UserProductItem(
                                    productsData.items[i].id,
                                    productsData.items[i].name,
                                    productsData.items[i].imageUrl,
                                  ),
                                  Divider()
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
          ),
          Positioned(
              bottom: 40,
              child: RoundedButton(
                buttonColor: kPinkColor,
                textStyle: TextStyle(fontSize: 15, color: Colors.white),
                onPressed: () {
                  Navigator.of(context).pushNamed(
                    EditProductScreen.routeName,
                  );
                },
                title: '+  Añadir producto',
              ))
        ],
      ),
    );
  }
}
