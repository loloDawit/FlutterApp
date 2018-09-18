import 'package:flutter/material.dart';

import './product_create.dart';
import './product_list.dart';
import '../scoped_models/main.dart';

class ProductAdminPage extends StatelessWidget {
  final MainModel model;

  ProductAdminPage(this.model);

  @override
  Widget build(BuildContext context) {
    Widget _buildSideDrawer(BuildContext context) {
      return Drawer(
        child: Column(
          children: <Widget>[
            AppBar(
              automaticallyImplyLeading: false,
              title: Text('Choose'),
            ),
            ListTile(
              leading: Icon(Icons.shop),
              title: Text('All Products'),
              onTap: () {
                Navigator.pushReplacementNamed(context, '/home');
              },
            )
          ],
        ),
      );
    }

    return DefaultTabController(
        length: 2,
        child: Scaffold(
          drawer: _buildSideDrawer(context),
          appBar: AppBar(
            title: Text('Manage Products'),
            bottom: TabBar(tabs: <Widget>[
              Tab(
                icon: Icon(Icons.create),
                text: 'Create Product',
              ),
              Tab(
                icon: Icon(Icons.list),
                text: 'My Product',
              )
            ]),
          ),
          body: TabBarView(
            children: <Widget>[ProductCreatePage(), ProductListPage(model)],
          ),
        ));
  }
}
