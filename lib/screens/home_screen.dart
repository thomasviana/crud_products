import 'package:crud_products/constants.dart';
import 'package:crud_products/custom/drawer_button.dart';
import 'package:crud_products/providers/products.dart';
import 'package:crud_products/widgets/app_drawer.dart';
import 'package:crud_products/widgets/product_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home-screen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isInit = true;
  bool _isLoading = false;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<Products>(
        context,
      ).getData().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final prodData = Provider.of<Products>(context, listen: false).items;
    final height = MediaQuery.of(context).size.height;
    return Container(
      color: Colors.white,
      child: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Scaffold(
              drawer: AppDrawer(),
              body: CustomScrollView(
                physics: BouncingScrollPhysics(),
                slivers: [
                  SliverAppBar(
                    leading: DrawerButton(),
                    backgroundColor: kPinkColor,
                    pinned: true,
                    expandedHeight: 200,
                    flexibleSpace: FlexibleSpaceBar(
                      collapseMode: CollapseMode.none,
                      centerTitle: true,
                      title: Text(
                        'PRODUCTOS',
                        style: kWhiteAndBold,
                      ),
                      background: Image.network(
                        'https://i.pinimg.com/originals/ae/2f/65/ae2f6576f41643d5f7cac852f2e01b3f.jpg',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  if (prodData.isEmpty)
                    SliverList(
                      delegate: SliverChildListDelegate(
                        [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 70),
                            height: height * 0.5,
                            child: Image.network(
                              'https://www.softmaco.com/assets/images/no%20data.png',
                              fit: BoxFit.contain,
                            ),
                          ),
                          SizedBox(height: 0),
                          Text(
                            'Agrega productos en:',
                            textAlign: TextAlign.center,
                            style: kMessageTextStyle,
                          ),
                          Text(' Menú -> Administrar productos',
                              textAlign: TextAlign.center,
                              style: kMessageTextStyle)
                        ],
                      ),
                    ),
                  SliverGrid(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                    ),
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        return ProductItem(
                          id: prodData[index].id,
                          imageUrl: prodData[index].imageUrl,
                          name: prodData[index].name,
                          description: prodData[index].description,
                          stock: prodData[index].stock,
                          price: prodData[index].price,
                        );
                      },
                      childCount: prodData.length,
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
