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
  String _titleValue = '';
  String _description = '';
  double _priceValue = 0.0;

  Widget _buildTitleTextField() {
    return TextField(
      decoration: InputDecoration(
        labelText: 'Product Title',
      ),
      onChanged: (String value) {
        setState(() {
          _titleValue = value;
        });
      },
    );
  }

  Widget _buildDescriptionTextField() {
    return TextField(
        decoration: InputDecoration(labelText: 'Product Description'),
        maxLines: 4,
        onChanged: (String value) {
          setState(() {
            _description = value;
          });
        });
  }

  Widget _buildPriceTextField() {
    return TextField(
        decoration: InputDecoration(labelText: 'Product Price'),
        keyboardType: TextInputType.number,
        onChanged: (String value) {
          setState(() {
            _priceValue = double.parse(value);
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10.0),
      child: ListView(
        children: <Widget>[
          _buildTitleTextField(),
          _buildDescriptionTextField(),
          _buildPriceTextField(),
          SizedBox(height: 10.0),
          RaisedButton(
            child: Text('Save'),
            color: Theme.of(context).accentColor,
            textColor: Colors.white,
            onPressed: () {
              final Map<String, dynamic> product = {
                'title': _titleValue,
                'description': _description,
                'price': _priceValue,
                'image': 'assets/food.jpg'
              };
              widget.addProduct(product);
              Navigator.pushNamed(context, '/home');
            },
          )
        ],
      ),
    );
  }
}
