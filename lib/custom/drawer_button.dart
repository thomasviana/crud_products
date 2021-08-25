import 'package:crud_products/constants.dart';
import 'package:flutter/material.dart';

class DrawerButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Scaffold.of(context).openDrawer();
        print('drawer');
      },
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  kBlueColor,
                  kPinkColor,
                ],
              ),
            ),
            child: Icon(Icons.menu),
          ),
        ),
      ),
    );
  }
}
