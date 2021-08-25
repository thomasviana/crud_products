import 'package:crud_products/providers/auth.dart';
import 'package:crud_products/screens/auth_screen.dart';
import 'package:crud_products/screens/home_screen.dart';
import 'package:crud_products/screens/manage_products_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(left: 20, top: 40),
            alignment: Alignment.centerLeft,
            child: Text(
              'Menú',
              style: kWhiteAndBold.copyWith(fontSize: 20),
            ),
            height: 100,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  kBlueColor,
                  kPinkColor,
                ],
              ),
            ),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.edit),
            title: Text('Administrar Productos'),
            onTap: () {
              Navigator.of(context).pushNamed(ManageProductsScreen.routeName);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Cerrar sesión'),
            onTap: () {
              Provider.of<Auth>(context, listen: false).signOut();
              Navigator.pushReplacementNamed(context, AuthScreen.routeName);
            },
          )
        ],
      ),
    );
  }
}
