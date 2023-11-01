import 'package:flutter/material.dart';
import 'package:shop/providers/product.dart';

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
  final _form = GlobalKey<
      FormState>(); //we are trying to acces the data of the form by creating the form key using the global key and being specific by stating  formState since global key is a generic key

  void _saveForm() {
    _form.currentState!
        .save(); //accesing allthe fields in the form to be stored
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
                  decoration: const InputDecoration(labelText: 'Title'),
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_priceFocuseNode);
                  },
                  onSaved: (value) {
                    _editedProduct = Products(
                        id: _editedProduct.id,
                        title: value!,
                        description: _editedProduct.description,
                        price: _editedProduct.price,
                        imageUrl: _editedProduct.imageUrl);
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Price'),
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  focusNode: _priceFocuseNode,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_descriptionFocusNode);
                  },
                  onSaved: (value) {
                    _editedProduct = Products(
                        id: _editedProduct.id,
                        title: _editedProduct.title,
                        description: _editedProduct.description,
                        price: double.parse(value!),
                        imageUrl: _editedProduct.imageUrl);
                  },
                ),
                TextFormField(
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
                        imageUrl: _editedProduct.imageUrl);
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
                              imageUrl: value!);
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
