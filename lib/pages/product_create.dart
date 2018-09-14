import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProductCreatePage extends StatefulWidget {
  final Function addProduct;

  ProductCreatePage(this.addProduct);

  @override
  State<StatefulWidget> createState() {
    return _ProductCreatePageState();
  }
}

class _ProductCreatePageState extends State<ProductCreatePage> {
  final Map<String, dynamic> _formData = {
    "title": null,
    "description": null,
    "price": null, 
    'image': 'assets/food.jpg'
  };

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget _buildTitleTextField() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Product Title'),
      autovalidate: true,
      validator: (String value) {
        if (value.isEmpty || value.length < 4) {
          return 'Title is required and should be 4+ characters long';
        }
      },
      onSaved: (String value) {
        _formData['title'] = value;
      },
    );
  }

  Widget _buildDescriptionTextField() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Product Description'),
      maxLines: 4,
      autovalidate: true,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Description is required';
        }
      },
      onSaved: (String value) {
        _formData['description'] = value;
      },
    );
  }

  Widget _buildPriceTextField() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Product Price'),
      keyboardType: TextInputType.number,
      autovalidate: true,
      validator: (String value) {
        if (value.isEmpty ||
            !RegExp(r'^(?:[1-9]\d*|0)?(?:\.\d)?$').hasMatch(value)) {
          return 'Price is required and should be a number';
        }
      },
      onSaved: (String value) {
        _formData['price'] = double.parse(value);
      },
    );
  }

  _showAlert() {
    var alert = new CupertinoAlertDialog(
      title: new Text("Alert"),
      content: new Text(
          "There was an error saving the data. Please make sure the fields all filled!"),
      actions: <Widget>[
        new CupertinoDialogAction(
            child: const Text('Ok'),
            isDestructiveAction: true,
            onPressed: () {
              Navigator.pop(context, 'Ok');
            }),
      ],
    );
    showDialog(context: context, child: alert);
  }

  void _submitForm() {
    if (!_formKey.currentState.validate()) {
      return _showAlert();
    }
    _formKey.currentState.save();
    widget.addProduct(_formData);
    Navigator.pushNamed(context, '/home');
  }

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double targerWidth = deviceWidth > 550.0 ? 500.0 : deviceWidth * 0.95;
    final double targerPadding = deviceWidth - targerWidth;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Container(
        margin: EdgeInsets.all(10.0),
        child: Form(
          key: _formKey,
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: targerPadding / 4),
            children: <Widget>[
              _buildTitleTextField(),
              _buildDescriptionTextField(),
              _buildPriceTextField(),
              SizedBox(height: 10.0),
              RaisedButton(
                child: Text('Save'),
                textColor: Colors.white,
                onPressed: _submitForm,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
