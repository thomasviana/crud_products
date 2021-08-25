import 'package:crud_products/constants.dart';
import 'package:crud_products/custom/rounded_button.dart';
import 'package:flutter/material.dart';
import 'auth_screen.dart';

class WelcomeScreen extends StatelessWidget {
  static const routeName = '/';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Hero(
              tag: 'logo',
              child: Icon(
                Icons.cloud_done_outlined,
                size: 200,
              ),
            ),
            Text(
              'Bienvenido',
              style: TextStyle(fontSize: 30),
            ),
            SizedBox(height: 20),
            RoundedButton(
                buttonColor: kBlueColor,
                title: 'Comenzar',
                onPressed: () {
                  Navigator.of(context).pushNamed(AuthScreen.routeName);
                },
                textStyle: TextStyle(color: Colors.white)),
          ],
        ),
      ),
    );
  }
}
