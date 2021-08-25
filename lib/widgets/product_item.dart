import 'package:crud_products/screens/product_info_%20screen.dart';
import 'package:flutter/material.dart';
import '../constants.dart';

class ProductItem extends StatelessWidget {
  final String id;
  final String imageUrl;
  final String name;
  final String description;
  final int stock;
  final int price;

  ProductItem(
      {required this.id,
      required this.imageUrl,
      required this.name,
      required this.description,
      required this.stock,
      required this.price});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return InkWell(
      onTap: () {
        Navigator.of(context)
            .pushNamed(ProductInfoScreen.routeName, arguments: id);
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 10,
        margin: const EdgeInsets.all(15),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
              ),
              child: Container(
                width: double.infinity,
                height: size.height * 0.14,
                child: Hero(
                  tag: id,
                  child: FadeInImage(
                    placeholder: const AssetImage(
                        'assets/images/product-placeholder.png'),
                    image: NetworkImage(imageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 5, top: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            name,
                            style: TextStyle(
                                fontSize: 15,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Text(
                          '\$ ${currency.format(price)}',
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed(
                          ProductInfoScreen.routeName,
                          arguments: id);
                    },
                    icon: Icon(Icons.more_horiz_outlined),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
