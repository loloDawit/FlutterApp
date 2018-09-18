import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import './price_tag.dart';
import '../UI/title_default.dart';
import './address_tag.dart';

import '../../models/product.dart';
import '../../scoped_models/main.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final int productIndex;
  final int count = 0;

  ProductCard(this.product, this.productIndex);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: <Widget>[
          FadeInImage(
            image: NetworkImage(product.image),
            height: 300.0,
            fit: BoxFit.cover,
            placeholder: AssetImage('assets/backgroundImage.gif'),
          ),
          Container(
            margin: EdgeInsets.only(top: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TitleDefult(product.title),
                SizedBox(width: 8.0),
                PriceTag(product.price.toString())
              ],
            ),
          ),
          AddressTag('Seattle, WA'),
          Text(product.userEmail),
          ScopedModelDescendant<MainModel>(
            builder: (BuildContext context, Widget child, MainModel model) {
              return ButtonBar(
                  alignment: MainAxisAlignment.center,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.info),
                      color: Theme.of(context).accentColor,
                      onPressed: () => Navigator.pushNamed<bool>(context,
                          '/product/' + model.allProducts[productIndex].id),
                    ),
                    IconButton(
                      icon: Icon(model.allProducts[productIndex].isFav
                          ? Icons.favorite
                          : Icons.favorite_border),
                      color: Colors.red,
                      onPressed: () {
                        model.selectProduct(model.allProducts[productIndex].id);
                        model.favProduct();
                      },
                    ),
                    Text(count.toString())
                  ]);
            },
          )
        ],
      ),
    );
  }
}
