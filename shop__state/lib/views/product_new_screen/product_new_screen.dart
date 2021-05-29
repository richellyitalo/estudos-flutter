import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/product.dart';
import '../../providers/products_provider.dart';
import '../../util/app_routes.dart';

class ProductNewScreen extends StatefulWidget {
  ProductNewScreen({Key key}) : super(key: key);

  @override
  _ProductNewScreenState createState() => _ProductNewScreenState();
}

class _ProductNewScreenState extends State<ProductNewScreen> {
  FocusNode _inputPriceFocusNode;
  FocusNode _inputDescriptionsFocusNode;
  FocusNode _inputUrlFocusNode;
  final _inputUrlController = TextEditingController();
  final _formData = Map<String, Object>();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    _inputPriceFocusNode = FocusNode();
    _inputDescriptionsFocusNode = FocusNode();
    _inputUrlFocusNode = FocusNode();

    _inputUrlFocusNode.addListener(_updateImage);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_formData.isEmpty) {
      final product = ModalRoute.of(context).settings.arguments as Product;

      _formData['price'] = '';

      if (product != null) {
        _formData['id'] = product.id;
        _formData['title'] = product.title;
        _formData['price'] = product.price;
        _formData['description'] = product.description;
        _formData['imageUrl'] = product.imageUrl;

        _inputUrlController.text = _formData['imageUrl'];
      }
    }
  }

  @override
  void dispose() {
    super.dispose();

    _inputPriceFocusNode.dispose();
    _inputDescriptionsFocusNode.dispose();
    _inputUrlFocusNode.removeListener(_updateImage);
    _inputUrlFocusNode.dispose();
  }

  void _updateImage() {
    if (!isImageUrlValid(_inputUrlController.text)) {
      return;
    }
    setState(() {});
  }

  void _submitForm() {
    bool formIsvalid = _formKey.currentState.validate();
    if (!formIsvalid) {
      return;
    }

    _formKey.currentState.save();

    Product productEntity = new Product(
      id: _formData['id'],
      title: _formData['title'],
      price: _formData['price'],
      description: _formData['description'],
      imageUrl: _formData['imageUrl'],
    );

    final productProvider =
        Provider.of<ProductsProvider>(context, listen: false);

    if (productEntity.id == null) {
      productProvider.addProduct(productEntity);
    } else {
      productProvider.updateProduct(productEntity);
    }

    // Navigator.of(context).pushNamed(AppRoutes.PRODUCTS);
    Navigator.of(context).pop();
  }

  bool isImageUrlValid(String url) {
    bool isValidHttp = url.toLowerCase().startsWith('http');
    bool isValidHttps = url.toLowerCase().startsWith('https');
    bool isValidJpg = url.toLowerCase().endsWith('.jpg');
    bool isValidJpeg = url.toLowerCase().endsWith('.jpeg');
    bool isValidPng = url.toLowerCase().endsWith('.png');

    return ((isValidHttp || isValidHttps) &&
        (isValidJpg || isValidJpeg || isValidPng));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Novo Produto'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              _submitForm();
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Nome'),
                initialValue: _formData['title'],
                textInputAction: TextInputAction.next,
                autofocus: true,
                onFieldSubmitted: (val) {
                  FocusScope.of(context).requestFocus(_inputPriceFocusNode);
                },
                onSaved: (val) {
                  _formData['title'] = val;
                },
                validator: (val) {
                  bool isEmpty = val.trim().isEmpty;
                  bool isInvalid = val.trim().length < 3;
                  if (isEmpty) {
                    return 'Informe um nome';
                  }

                  if (isInvalid) {
                    return 'Informe pelo menos 3 caracteres.';
                  }

                  return null;
                },
              ),
              TextFormField(
                initialValue: _formData['price'].toString(),
                decoration: InputDecoration(labelText: 'Preço'),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.numberWithOptions(
                  decimal: true,
                ),
                focusNode: _inputPriceFocusNode,
                onFieldSubmitted: (val) {
                  FocusScope.of(context)
                      .requestFocus(_inputDescriptionsFocusNode);
                },
                onSaved: (val) {
                  _formData['price'] = double.tryParse(val);
                },
                validator: (val) {
                  bool isEmpty = val.trim().isEmpty;
                  var valDouble = double.tryParse(val);
                  bool isInvalid = valDouble == null || valDouble <= 0;

                  if (isEmpty) {
                    return 'Informe um preço';
                  }

                  if (isInvalid) {
                    return 'Informe um preço válido';
                  }

                  return null;
                },
              ),
              TextFormField(
                initialValue: _formData['description'],
                decoration: InputDecoration(labelText: 'Descrição'),
                maxLines: 3,
                keyboardType: TextInputType.multiline,
                focusNode: _inputDescriptionsFocusNode,
                onSaved: (val) {
                  _formData['description'] = val;
                },
                validator: (val) {
                  bool isEmpty = val.trim().isEmpty;
                  bool isInvalid = val.trim().length < 10;
                  if (isEmpty) {
                    return 'Informe um nome';
                  }

                  if (isInvalid) {
                    return 'Informe pelo menos 10 caracteres.';
                  }

                  return null;
                },
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(labelText: 'Url da imagem'),
                      keyboardType: TextInputType.url,
                      focusNode: _inputUrlFocusNode,
                      controller: _inputUrlController,
                      onSaved: (val) {
                        _formData['imageUrl'] = val;
                      },
                      validator: (val) {
                        bool isEmpty = val.trim().isEmpty;
                        bool isInvalid = !isImageUrlValid(val);
                        if (isEmpty) {
                          return 'Informe uma Url';
                        }

                        if (isInvalid) {
                          return 'Informe uma url válida';
                        }

                        return null;
                      },
                    ),
                  ),
                  Container(
                    height: 100,
                    width: 100,
                    margin: EdgeInsets.only(left: 10, top: 10),
                    // padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                      ),
                    ),
                    alignment: Alignment.center,
                    child: _inputUrlController.text.isEmpty
                        ? Text('Informe uma URL')
                        : FittedBox(
                            child: Image.network(_inputUrlController.text),
                            fit: BoxFit.cover,
                          ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
