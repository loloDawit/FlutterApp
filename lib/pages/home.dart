import 'package:flutter/material.dart';

import '../widgets/products/products.dart';

class HomePage extends StatelessWidget {
  final List<Map<String,dynamic>> products;
  HomePage(this.products);

  @override
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
              leading: Icon( Icons.edit),
              title: Text('Manage Products'),
              onTap: () {
                Navigator.pushReplacementNamed(context, '/admin');
              },
            )
          ],
        ),
      ),
      appBar: AppBar(
        title: Text('Welcome to Fluter'),
        actions: <Widget>[ 
           IconButton( icon: Icon(Icons.favorite), onPressed: () {},)
        ],
      ),
      body: Products(products),
    );
  }
}
