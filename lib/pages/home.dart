import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../widgets/products/products.dart';
import '../scoped_models/main.dart';
import '../widgets/UI/logout_list_tile.dart';

class HomePage extends StatefulWidget {
  final MainModel model;
  HomePage(this.model);
  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  @override
  initState() {
    widget.model.fetchProducts();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: <Widget>[
            AppBar(
              automaticallyImplyLeading: false,
              title: Text('Choose'),
            ),
            ListTile(
              leading: Icon(Icons.edit),
              title: Text('Manage Products'),
              onTap: () {
                Navigator.pushReplacementNamed(context, '/admin');
              },
            ),
            Divider(),
            LogoutListTile(),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text('Welcome to Fluter'),
        actions: <Widget>[
          ScopedModelDescendant<MainModel>(
            builder: (BuildContext context, Widget child, MainModel model) {
              return IconButton(
                icon: Icon(model.displayFavOnly
                    ? Icons.favorite
                    : Icons.favorite_border),
                onPressed: () {
                  model.toggleDisplayMode();
                },
              );
            },
          )
        ],
      ),
      body: _buildProductList(),
    );
  }

  Widget _buildProductList() {
    return ScopedModelDescendant(
      builder: (BuildContext context, Widget child, MainModel model) {
        Widget content = Center(
          child: Text('No Products Found!'),
        );
        if (model.disPlayedProducts.length > 0 && !model.isLoading) {
          content = Products();
        } else if (model.isLoading) {
          content = Center(
            child: CupertinoActivityIndicator(),
          );
        }
        return RefreshIndicator(child: content, onRefresh: model.fetchProducts);
      },
    );
  }
}
