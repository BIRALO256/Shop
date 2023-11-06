import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/providers/product.dart';
import 'package:shop/providers/products_provider.dart';

class EditProductScreen extends StatefulWidget {
  static const routeName = '/edit-Product';

  const EditProductScreen({super.key});

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _priceFocuseNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageURLController = TextEditingController();
  var _editedProduct =
      Products(id: '', title: '', description: '', price: 0, imageUrl: '');
  var _isInit = true;
  var _initValues = {
    'title': '',
    'description': '',
    'price': '',
    'imageURL': '',
  };

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final productId = ModalRoute.of(context)?.settings.arguments
          as String; //here we are trying to acces the id forwarded when the edit button is pressed which is used to edit the product
      final product = Provider.of<ProductProvider>(context, listen: false)
          .findbyId(productId); //we use the id provided to find the product
      _editedProduct =
          product; //making sure we intialise the edited product to the new product we got by id
      _initValues = {
        'title': _editedProduct.title,
        'description': _editedProduct.description,
        'price': _editedProduct.price.toString(),
        'imageURL': '',
      };
      _imageURLController.text = _editedProduct.imageUrl;
    }
    _isInit = false; //here we are making sure it does not run every time
    super.didChangeDependencies();
  }

  final _form = GlobalKey<
      FormState>(); //we are trying to acces the data of the form by creating the form key using the global key and being specific by stating  formState since global key is a generic key

  void _saveForm() {
    final isValid = _form.currentState
        ?.validate(); // this triggers all the validators in the form
    if (isValid!) {
      return;
    }
    _form.currentState!
        .save(); //accesing allthe fields in the form to be stored
    if (_editedProduct.id! == null) {
      Provider.of<ProductProvider>(context, listen: false)
          .updateProduct(_editedProduct.id, _editedProduct);
    } else {
      Provider.of<ProductProvider>(context, listen: false).addProducts(
          _editedProduct); //_editedproduct contains data about thre product needed
      Navigator.of(context).pop();
    } //this will take us to the previous page which is the all products page
  }

  @override
  void dispose() {
    _descriptionFocusNode
        .dispose(); //we despose them to avoid memory leakage, these disposed ones are removed from the memory the momeent the this class is nolonger used
    _priceFocuseNode.dispose();
    _imageURLController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Product'),
        actions: [
          IconButton(
              onPressed: () {
                _saveForm();
              },
              icon: const Icon(Icons.save))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Form(
            key: _form,
            child: ListView(
              children: [
                TextFormField(
                  initialValue: _initValues['title'],
                  decoration: const InputDecoration(labelText: 'Title'),
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_priceFocuseNode);
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Title sholud not be empty';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _editedProduct = Products(
                        id: _editedProduct.id,
                        title: value!,
                        description: _editedProduct.description,
                        price: _editedProduct.price,
                        imageUrl: _editedProduct.imageUrl,
                        isFavorite: _editedProduct.isFavorite);
                  },
                ),
                TextFormField(
                  initialValue: _initValues['price'],
                  decoration: const InputDecoration(labelText: 'Price'),
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  focusNode: _priceFocuseNode,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_descriptionFocusNode);
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Price sholud not be empty';
                    }
                    if (double.tryParse(value) == null) {
                      return 'Enter a valid number';
                    }
                    if (double.parse(value) <= 0) {
                      return 'number should be greater than zero';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _editedProduct = Products(
                        id: _editedProduct.id,
                        title: _editedProduct.title,
                        description: _editedProduct.description,
                        price: double.parse(value!),
                        imageUrl: _editedProduct.imageUrl,
                        isFavorite: _editedProduct.isFavorite);
                  },
                ),
                TextFormField(
                  initialValue: _initValues['description'],
                  decoration: const InputDecoration(labelText: 'Description'),
                  maxLines:
                      3, //seting how many lines are need for a description field  and here we have srt to 3 since description is some how big
                  focusNode: _descriptionFocusNode,
                  keyboardType: TextInputType.multiline,
                  onSaved: (value) {
                    _editedProduct = Products(
                        id: _editedProduct.id,
                        title: _editedProduct.title,
                        description: value!,
                        price: _editedProduct.price,
                        imageUrl: _editedProduct.imageUrl,
                        isFavorite: _editedProduct.isFavorite);
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Description sholud not be empty';
                    }
                    if (value.length < 10) {
                      return 'Should be atleast 10 characters ';
                    }
                    return null;
                  },
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      margin: const EdgeInsets.only(top: 8, right: 10),
                      decoration: BoxDecoration(
                        border: Border.all(width: 1, color: Colors.black),
                      ),
                      child: _imageURLController.text.isEmpty
                          ? const Text('Enter a url')
                          : FittedBox(
                              child: Image.network(_imageURLController.text),
                            ),
                    ),
                    Expanded(
                      child: TextFormField(
                        // initialValue: _initValues['imageURL'],
                        decoration:
                            const InputDecoration(labelText: 'Image URL'),
                        keyboardType: TextInputType.url,
                        textInputAction: TextInputAction.done,
                        controller: _imageURLController,
                        onSaved: (value) {
                          _editedProduct = Products(
                              id: _editedProduct.id,
                              title: _editedProduct.title,
                              description: _editedProduct.description,
                              price: _editedProduct.price,
                              imageUrl: value!,
                              isFavorite: _editedProduct.isFavorite);
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Image URL sholud not be empty';
                          }
                          if (!value.startsWith('http') ||
                              !value.startsWith('https')) {
                            return 'please enter a valid URL';
                          }
                          if (!value.endsWith(".png") ||
                              !value.endsWith('.jpg') ||
                              !value.endsWith('.jpeg')) {
                            return 'please enter a valid image URL';
                          }
                          return null;
                        },

                        onFieldSubmitted: (_) => {
                          //this is the form methode triggered when the form is need to be submited
                          _saveForm()
                        },

                        //this is triggerde when a user tries to submit the data in the form
                      ),
                    )
                  ],
                )
              ],
            )),
      ),
    );
  }
}
