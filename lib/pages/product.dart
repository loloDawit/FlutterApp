import 'package:flutter/material.dart';

import 'dart:async';
import '../widgets/UI/title_default.dart';
import '../models/product.dart';

class ProductPage extends StatelessWidget {
  final Product productsList;

  ProductPage(this.productsList);
  @override
  Widget build(BuildContext context) {
    Widget _buildPriceRow(double price) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Seattle, WA',
            style: TextStyle(fontFamily: 'Oswald'),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 5.0),
            child: Text('|'),
          ),
          Text(
            '\$ ${price.toString()}',
            style: TextStyle(fontFamily: 'Oswald'),
          )
        ],
      );
    }

    return WillPopScope(
      onWillPop: () {
        Navigator.pop(context, false);
        return Future.value(false);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(productsList.title),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            FadeInImage(
              image: NetworkImage(productsList.image),
              height: 300.0,
              fit: BoxFit.cover,
              placeholder: AssetImage('assets/backgroundImage.gif'),
            ),
            Container(
              padding: EdgeInsets.all(10.0),
              child: TitleDefult(productsList.title),
            ),
            _buildPriceRow(productsList.price),
            Container(
              padding: EdgeInsets.all(10.0),
              margin: EdgeInsets.only(top: 3.0),
              child: Text(
                productsList.description,
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      ),
    );
  }
}
