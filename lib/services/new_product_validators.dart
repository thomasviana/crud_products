import 'package:flutter/material.dart';

class ProductNameValidator {
  static String? validate(String? value) {
    if (value!.isEmpty) {
      return 'Por favor asigme un nombre.';
    }
    return null;
  }
}

class ProductPriceValidator {
  static String? validate(String? value) {
    if (value!.isEmpty) {
      return 'Porfavor asigne un precio.';
    }
    if (double.tryParse(value) == null) {
      return 'Ingrese un número válido.';
    }
    if (double.parse(value) <= 0) {
      return 'Ingrese un numero mayor a cero.';
    }
    return null;
  }
}

class ProductDescriptionValidator {
  static String? validate(String? value) {
    if (value!.isEmpty) {
      return 'Por favor escriba una descripción.';
    }
    if (value.length < 10) {
      return 'La descripción debe ser mayor a 10 letras.';
    }
    return null;
  }
}

class ProductStockValidator {
  static String? validate(String? value) {
    if (value!.isEmpty) {
      return 'Porfavor inicialice el stock';
    }
    if (double.tryParse(value) == null) {
      return 'Ingrese un número válido.';
    }
    return null;
  }
}

class ProductUrlValidator {
  static String? validate(String? value) {
    if (value!.isEmpty) {
      return 'Coloque una URL válida';
    }
    return null;
  }
}
