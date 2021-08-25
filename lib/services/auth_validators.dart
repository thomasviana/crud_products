import 'package:flutter/material.dart';

class NameValidator {
  static String? validate(String? value) {
    if (value!.isEmpty) {
      return "Este campo es obligatorio.";
    }
    return null;
  }
}

class EmailValidator {
  static String? validate(String? value) {
    if (value!.isEmpty) {
      return "Este campo es obligatorio.";
    }
    if (value.isEmpty || !value.contains('@')) {
      return 'Ingrese un correo válido.';
    }
    return null;
  }
}

class PasswordValidator {
  static String? validate(String? value) {
    if (value!.isEmpty) {
      return "Este campo es obligatorio.";
    }
    if (value.isEmpty || value.length < 8) {
      return 'La contraseña debe tener mínimo 8 dígitos.';
    }
    return null;
  }
}

class ConfirmPasswordValidator {
  static String? validate(
      String? value, String? password, String? confirmPassword) {
    if (value!.isEmpty) {
      return "Este campo es obligatorio.";
    }
    if (password != confirmPassword) {
      return 'Las contraseñas no coinciden.';
    }
    if (value.isEmpty || value.length < 8) {
      return 'La contraseña debe tener mínimo 8 dígitos.';
    }
    return null;
  }
}
