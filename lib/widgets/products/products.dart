import 'package:flutter/material.dart';

import './product_card.dart'; 

class Products extends StatelessWidget {
  final List<Map<String, dynamic>> products;
  final int count = 0; 

  Products(this.products);
  Widget _buildProductList() {
    Widget productCard = Center(
      child: Text('Cant Find Products, Please add some'),
    );
    if (products.length > 0) {
      productCard = ListView.builder(
        itemBuilder: (BuildContext context, int index) => ProductCard( products[index], index),
        itemCount: products.length,
      );
    }
    return productCard;
  }

  @override
  Widget build(BuildContext context) {
    return _buildProductList();
  }
}
