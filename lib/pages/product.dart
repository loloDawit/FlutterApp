import 'package:flutter/material.dart';
import 'dart:async';

class ProductPage extends StatelessWidget {
  final String title;
  final String imageUrl;
  final double price;
  final String description;

  ProductPage(this.title, this.imageUrl, this.price, this.description);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.pop(context, false);
        return Future.value(false);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.asset(imageUrl),
            Container(
              padding: EdgeInsets.all(10.0),
              child: Text(
                title,
                style: TextStyle(
                    fontFamily: 'Oswald',
                    fontSize: 26.0,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Row(
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
            ),
            Container(
              padding: EdgeInsets.all(10.0),
              margin: EdgeInsets.only(top: 3.0),
              child: Text(description, textAlign: TextAlign.center,),
            )
          ],
        ),
      ),
    );
  }
}
