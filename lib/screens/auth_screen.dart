import 'package:crud_products/providers/auth.dart';
import 'package:crud_products/custom/rounded_button.dart';
import 'package:crud_products/services/auth_validators.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'home_screen.dart';
import 'package:provider/provider.dart';
import 'package:crud_products/constants.dart';

class AuthScreen extends StatefulWidget {
  static const routeName = '/auth-screen';

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _formKey = GlobalKey<FormState>();
  late bool _registerMode = false;
  late bool _loginMode = false;
  late String name;
  late String email;
  late String password;
  bool showSpinner = false;

  @override
  void initState() {
    String _mode = 'LoginMode';
    if (_mode == 'LoginMode') {
      setState(() {
        _loginMode = true;
      });
    } else {
      setState(() {
        _registerMode = true;
      });
    }
    super.initState();
  }

  void showError(error) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(error, textAlign: TextAlign.center),
        backgroundColor: Theme.of(context).errorColor,
      ),
    );
    return;
  }

  Future<void> _trySubmit() async {
    final _isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (_isValid && _registerMode) {
      print("registerMode");
      print(email);
      setState(() {
        showSpinner = true;
      });
      try {
        await Provider.of<Auth>(context, listen: false)
            .signUp(name, email, password);
        Navigator.pushReplacementNamed(context, HomeScreen.routeName);
        setState(() {
          showSpinner = false;
        });
      } catch (e) {
        showError(
            'La contraseña no corresponde al usuario o el usuario no exite.');
      }
    } else if (_isValid && _loginMode) {
      print("loginMode");

      try {
        await Provider.of<Auth>(context, listen: false).login(email, password);
        Navigator.pushReplacementNamed(context, HomeScreen.routeName);
        setState(() {
          showSpinner = false;
        });
      } catch (e) {
        showError(
            'La contraseña no corresponde al usuario o el usuario no exite.');
      }
    } else if (!_isValid) {
      return;
    }
    nameController.clear();
    emailController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: ModalProgressHUD(
          progressIndicator: CircularProgressIndicator(
              backgroundColor: Theme.of(context).accentColor,
              color: Colors.black),
          inAsyncCall: showSpinner,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Hero(
                      tag: 'logo',
                      child: Padding(
                        padding: const EdgeInsets.only(top: 50),
                        child: Icon(Icons.cloud_done_outlined, size: 150),
                      ),
                    ),
                    SizedBox(width: 50),
                    Text('CRUD Productos',
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center),
                    SizedBox(height: 20.0),
                    if (_registerMode)
                      TextFormField(
                        key: ValueKey('name'),
                        textAlign: TextAlign.center,
                        onChanged: (value) {
                          name = value.trim();
                        },
                        decoration: kTextFieldDecoration.copyWith(
                          hintText: 'Nombre completo',
                          hoverColor: Colors.green,
                        ),
                        validator: NameValidator.validate,
                      ),
                    SizedBox(height: 8.0),
                    TextFormField(
                      key: ValueKey('email'),
                      controller: emailController,
                      textAlign: TextAlign.center,
                      onChanged: (value) {
                        email = value.trim();
                      },
                      decoration: kTextFieldDecoration.copyWith(
                        hintText: 'Correo electrónico',
                        hoverColor: Colors.green,
                      ),
                      validator: EmailValidator.validate,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    SizedBox(height: 8.0),
                    TextFormField(
                      key: ValueKey('pasword'),
                      controller: passwordController,
                      obscureText: true,
                      textAlign: TextAlign.center,
                      onChanged: (value) {
                        password = value.trim();
                      },
                      decoration:
                          kTextFieldDecoration.copyWith(hintText: 'Contraseña'),
                      validator: _loginMode ? null : PasswordValidator.validate,
                    ),
                    if (_registerMode) SizedBox(height: 8.0),
                    if (_registerMode)
                      TextFormField(
                        key: ValueKey('confirmPasword'),
                        controller: confirmPasswordController,
                        obscureText: true,
                        textAlign: TextAlign.center,
                        onChanged: (value) {
                          password = value.trim();
                        },
                        decoration: kTextFieldDecoration.copyWith(
                            hintText: 'Confirmar contraseña'),
                        validator: _registerMode
                            ? (value) => ConfirmPasswordValidator.validate(
                                value,
                                passwordController.text,
                                confirmPasswordController.text)
                            : null,
                      ),
                    SizedBox(height: 20),
                    RoundedButton(
                      buttonColor: _loginMode ? kPinkColor : kBlueColor,
                      title: _loginMode ? 'Ingresar' : 'Registrarme',
                      textStyle: kWhiteAndBold,
                      onPressed: _trySubmit,
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          _registerMode = !_registerMode;
                          _loginMode = !_loginMode;
                        });
                      },
                      child: Text(_loginMode
                          ? 'Crear nueva cuenta'
                          : 'Ya tengo una cuenta'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
