import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

final currency = NumberFormat("#,##0.00", "en_US");

TextEditingController nameController = TextEditingController();
TextEditingController emailController = TextEditingController();
TextEditingController passwordController = TextEditingController();
TextEditingController confirmPasswordController = TextEditingController();

const Color kPinkColor = Color(0xFFEA236F);
const Color kBlueColor = Color(0xFF1A4BC1);

Widget appBarGradient = Container(
  decoration: BoxDecoration(
    gradient: LinearGradient(
      colors: [kBlueColor, kPinkColor],
    ),
  ),
);

const kTextFieldDecoration = InputDecoration(
  contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Color(0xFFEA236F), width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.black54, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
);

const kMessageTextStyle =
    TextStyle(color: Colors.grey, fontSize: 18, fontWeight: FontWeight.bold);
const kWhiteAndBold =
    TextStyle(color: Colors.white, fontWeight: FontWeight.bold);
