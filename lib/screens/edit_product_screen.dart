import 'package:crud_products/models/product.dart';
import 'package:crud_products/providers/auth.dart';
import 'package:crud_products/providers/products.dart';
import 'package:crud_products/screens/manage_products_screen.dart';
import 'package:crud_products/services/new_product_validators.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants.dart';

class EditProductScreen extends StatefulWidget {
  static const routeName = '/edit-product';
  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _priceFocusNode = FocusNode();
  final _stockFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageUrlFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();
  final _form = GlobalKey<FormState>();
  var _editedProduct = Product(
    id: 'No Id',
    imageUrl: '',
    name: '',
    description: '',
    stock: 0,
    price: 0,
  );
  var _initValues = {
    'imageUrl': '',
    'name': '',
    'description': '',
    'stock': '',
    'price': '',
  };
  var _isInit = true;
  var _isLoading = false;

  @override
  void initState() {
    _imageUrlFocusNode.addListener(_updateImageUrl);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final productId = ModalRoute.of(context)!.settings.arguments as String?;
      if (productId != null) {
        _editedProduct =
            Provider.of<Products>(context, listen: false).findById(productId);
        _initValues = {
          'name': _editedProduct.name,
          'price': _editedProduct.price.toString(),
          'description': _editedProduct.description,
          'stock': _editedProduct.stock.toString(),
          'imageUrl': '',
        };
        _imageUrlController.text = _editedProduct.imageUrl;
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _imageUrlFocusNode.removeListener(_updateImageUrl);
    _priceFocusNode.dispose();
    _stockFocusNode.dispose();
    _imageUrlFocusNode.dispose();
    _descriptionFocusNode.dispose();
    super.dispose();
  }

  void _updateImageUrl() {
    if (!_imageUrlFocusNode.hasFocus) {
      setState(() {});
    }
  }

  Future<void> _saveForm() async {
    final isValid = _form.currentState!.validate();
    final userId = Provider.of<Auth>(context, listen: false).userId;

    if (!isValid) {
      return;
    }
    _form.currentState!.save();
    setState(() {
      _isLoading = true;
    });
    if (_editedProduct.id != 'No Id') {
      await Provider.of<Products>(context, listen: false)
          .updateProduct(userId, _editedProduct);
      setState(() {
        _isLoading = false;
      });
    } else {
      try {
        await Provider.of<Products>(context, listen: false)
            .addProduct(userId, _editedProduct);
      } catch (error) {
        await showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text('Error'),
            content: Text(
              'Algo salió mal.',
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context)
                      .pushReplacementNamed(ManageProductsScreen.routeName);
                  Navigator.of(ctx).pop();
                },
                child: Text('Listo'),
              )
            ],
          ),
        );
      }
    }
    setState(() {
      _isLoading = false;
    });
    Navigator.of(context).pushReplacementNamed(ManageProductsScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    final prodTitle = _initValues['name'] as String;
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: appBarGradient,
        title: Text(prodTitle.isEmpty ? 'Nuevo Producto' : prodTitle),
        actions: [
          TextButton(
            onPressed: () {
              _saveForm();
            },
            child: Text(
              'GUARDAR',
              style: kWhiteAndBold,
            ),
          ),
        ],
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _form,
                child: ListView(
                  children: [
                    TextFormField(
                        initialValue: _initValues['name'],
                        decoration: InputDecoration(labelText: 'Nombre'),
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (_) {
                          FocusScope.of(context).requestFocus(_priceFocusNode);
                        },
                        validator: ProductNameValidator.validate,
                        onSaved: (value) => {
                              _editedProduct = Product(
                                id: _editedProduct.id,
                                imageUrl: _editedProduct.imageUrl,
                                name: value as String,
                                description: _editedProduct.description,
                                stock: _editedProduct.stock,
                                price: _editedProduct.price,
                              ),
                            }),
                    TextFormField(
                        initialValue: _initValues['price'],
                        decoration: InputDecoration(labelText: 'Precio'),
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.number,
                        focusNode: _priceFocusNode,
                        onFieldSubmitted: (_) {
                          FocusScope.of(context)
                              .requestFocus(_descriptionFocusNode);
                        },
                        validator: ProductPriceValidator.validate,
                        onSaved: (value) => {
                              _editedProduct = Product(
                                id: _editedProduct.id,
                                imageUrl: _editedProduct.imageUrl,
                                name: _editedProduct.name,
                                description: _editedProduct.description,
                                stock: _editedProduct.stock,
                                price: int.parse(value as String),
                              )
                            }),
                    TextFormField(
                      initialValue: _initValues['description'],
                      decoration: InputDecoration(labelText: 'Descripción'),
                      maxLines: 3,
                      keyboardType: TextInputType.multiline,
                      focusNode: _descriptionFocusNode,
                      validator: ProductDescriptionValidator.validate,
                      onSaved: (value) => {
                        _editedProduct = Product(
                          id: _editedProduct.id,
                          imageUrl: _editedProduct.imageUrl,
                          name: _editedProduct.name,
                          description: value as String,
                          stock: _editedProduct.stock,
                          price: _editedProduct.price,
                        ),
                      },
                    ),
                    TextFormField(
                        initialValue: _initValues['stock'],
                        decoration: InputDecoration(labelText: 'Stock'),
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.number,
                        focusNode: _stockFocusNode,
                        onFieldSubmitted: (_) {
                          FocusScope.of(context)
                              .requestFocus(_imageUrlFocusNode);
                        },
                        validator: ProductStockValidator.validate,
                        onSaved: (value) => {
                              _editedProduct = Product(
                                id: _editedProduct.id,
                                imageUrl: _editedProduct.imageUrl,
                                name: _editedProduct.name,
                                description: _editedProduct.description,
                                stock: int.parse(value as String),
                                price: _editedProduct.price,
                              )
                            }),
                    TextFormField(
                        decoration: InputDecoration(labelText: 'Imagen (URL)'),
                        keyboardType: TextInputType.url,
                        textInputAction: TextInputAction.done,
                        controller: _imageUrlController,
                        focusNode: _imageUrlFocusNode,
                        validator: ProductUrlValidator.validate,
                        onFieldSubmitted: (_) {
                          FocusScope.of(context).unfocus();
                        },
                        onSaved: (value) => {
                              _editedProduct = Product(
                                id: _editedProduct.id,
                                imageUrl: value as String,
                                name: _editedProduct.name,
                                description: _editedProduct.description,
                                stock: _editedProduct.stock,
                                price: _editedProduct.price,
                              ),
                            }),
                    Container(
                      width: 100,
                      height: 300,
                      margin: const EdgeInsets.only(top: 25, right: 10),
                      decoration: BoxDecoration(
                        border:
                            Border.all(width: 5, color: Colors.grey.shade300),
                      ),
                      child: _imageUrlController.text.isEmpty
                          ? Center(
                              child: Text(
                                  'Copie la URL para visualizar la imagen.'),
                            )
                          : FittedBox(
                              child: Image.network(_imageUrlController.text),
                              fit: BoxFit.contain),
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
