import 'package:flutter/material.dart';

import '../product_manager.dart';
import '../pages/product_admin.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
          child: Column(children: <Widget>[
        AppBar(
          automaticallyImplyLeading: false,
          title: Text('Choose'),
        ),
        ListTile(
          title: Text('Manage Products'),
          onTap: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (
                BuildContext context,
              ) =>
                      ProductAdminPage()),
            );
          },
        )
      ])),
      appBar: AppBar(
        title: Text('Welcome to Fluter'),
      ),
      body: ProductManager(),
    );
  }
}