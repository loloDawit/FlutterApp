import 'package:flutter/material.dart';

import './price_tag.dart';
import '../UI/title_default.dart';
import './address_tag.dart';

class ProductCard extends StatelessWidget {
  final Map<String, dynamic> product;
  final int productIndex;
  final int count = 0;

  ProductCard(this.product, this.productIndex);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: <Widget>[
          Image.asset(product['image']),
          Container(
            margin: EdgeInsets.only(top: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TitleDefult(product['title']),
                SizedBox(width: 8.0),
                PriceTag(product['price'].toString())
              ],
            ),
          ),
          AddressTag('Seattle, WA'),
          ButtonBar(
            alignment: MainAxisAlignment.center,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.info),
                color: Theme.of(context).accentColor,
                onPressed: () => Navigator.pushNamed<bool>(
                    context, '/product/' + productIndex.toString()),
              ),
              IconButton(
                  icon: Icon(Icons.favorite_border),
                  color: Colors.red,
                  onPressed: () {
                    //count++;
                    print(count);
                    Text(count.toString());
                  }),
              Text(count.toString())
            ],
          )
        ],
      ),
    );
  }
}
