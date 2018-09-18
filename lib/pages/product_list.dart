import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import '../pages/product_create.dart';

import '../scoped_models/main.dart';

class ProductListPage extends StatefulWidget {
  final MainModel model;
  ProductListPage(this.model);
  @override
  State<StatefulWidget> createState() {
    return _ProductListPage();
  }
}

class _ProductListPage extends State<ProductListPage> {
  @override
   initState(){
     widget.model.fetchProducts();
     super.initState();
   }
  Widget _buildEditButton(BuildContext context, int index, MainModel model) {
    return IconButton(
      icon: Icon(Icons.edit),
      onPressed: () {
        model.selectProduct(model.allProducts[index].id);
        Navigator.of(context).push(
          MaterialPageRoute(builder: (BuildContext context) {
            return ProductCreatePage();
          }),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        Widget content = Center( child: Text('You Have No Product!'),);
        if(model.disPlayedProducts.length > 0 && !model.isLoading){
          content =  ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            return Dismissible(
              background: Container(
                color: Colors.red,
              ),
              key: Key(model.allProducts[index].title),
              onDismissed: (DismissDirection direction) {
                model.selectProduct(model.allProducts[index].id);
                if (direction == DismissDirection.endToStart) {
                  model.removeProduct();
                } else if (direction == DismissDirection.startToEnd) {
                  // Navigator.of(context).push(
                  //   MaterialPageRoute(builder: (BuildContext context) {
                  //     return ProductCreatePage(
                  //       product: productList[index],
                  //       updateProduct: updateProduct,
                  //       productToBeEditedIndex: index,
                  //     );
                  //   }),
                  // );
                  print('object');
                  // _buildEditButton(context, index);
                }
              },
              child: Column(
                children: <Widget>[
                  ListTile(
                      leading: CircleAvatar(
                        backgroundImage:
                            NetworkImage(model.allProducts[index].image),
                      ),
                      title: Text(model.allProducts[index].title),
                      subtitle: Text(
                          '\$${model.allProducts[index].price.toString()}'),
                      trailing: _buildEditButton(context, index, model)),
                  Divider(
                    color: Colors.redAccent,
                  )
                ],
              ),
            );
          },
          itemCount: model.allProducts.length,
        );}
        else if(model.isLoading){
          content = Center( child: CircularProgressIndicator(),);
        }
        return content;
      },
    );
  }
}
