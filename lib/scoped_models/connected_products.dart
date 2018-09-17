import 'package:scoped_model/scoped_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/product.dart';
import '../models/user.dart';

class ConnectedProductsModel extends Model {
  List<Product> _products = [];
  User _authenticatedUser;
  int _selected_ProductIndex;

  void addProduct(
      String title, String description, String image, double price) {
    final Map<String, dynamic> productData = {
      'title': title,
      'description': description,
      'image':
          'https://www.google.com/url?sa=i&rct=j&q=&esrc=s&source=images&cd=&cad=rja&uact=8&ved=2ahUKEwjQ9Zz3gsPdAhWSLnwKHUAwDYUQjRx6BAgBEAU&url=https%3A%2F%2Fmigrationology.com%2Fethiopian-kitfo-yohannes-restaurant%2F&psig=AOvVaw19T4PhLKqoGGcgzdZDGN5C&ust=1537307471643454',
      'price': price
    };
    http
        .post('https://flutterapp-12c55.firebaseio.com/products.json',
            body: json.encode(productData))
        .then((http.Response response) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      print(responseData);
      final Product newProduct = Product(
          id: responseData['name'],
          title: title,
          description: description,
          image: image,
          price: price,
          userEmail: _authenticatedUser.email,
          userID: _authenticatedUser.id);
      _products.add(newProduct);
      notifyListeners();
    });
  }
}

class ProductsModel extends ConnectedProductsModel {
  bool _showFav = false;
  List<Product> get allProducts {
    return List.from(_products);
  }

  List<Product> get disPlayedProducts {
    if (_showFav) {
      return _products.where((Product product) => product.isFav).toList();
    }
    return List.from(_products);
  }

  int get selectedProductIndex {
    return _selected_ProductIndex;
  }

  Product get selectedProduct {
    if (selectedProductIndex == null) {
      return null;
    }
    return _products[selectedProductIndex];
  }

  bool get displayFavOnly {
    return _showFav;
  }

  void removeProduct() {
    _products.removeAt(selectedProductIndex);
    notifyListeners();
  }

  void updateProduct(
      String title, String description, String image, double price) {
    final Product updatedProduct = Product(
        title: title,
        description: description,
        image: image,
        price: price,
        userEmail: selectedProduct.userEmail,
        userID: selectedProduct.userID);
    _products[selectedProductIndex] = updatedProduct;
    notifyListeners();
  }

  void selectProduct(int index) {
    _selected_ProductIndex = index;
    notifyListeners();
  }

  void favProduct() {
    final bool isCurFav = selectedProduct.isFav;
    final newFavStatus = !isCurFav;
    final Product updatedProduct = Product(
        title: selectedProduct.title,
        description: selectedProduct.description,
        price: selectedProduct.price,
        image: selectedProduct.image,
        userEmail: selectedProduct.userEmail,
        userID: selectedProduct.userID,
        isFav: newFavStatus);
    _products[selectedProductIndex] = updatedProduct;
    notifyListeners();
  }

  void toggleDisplayMode() {
    _showFav = !_showFav;
    notifyListeners();
  }
}

class UserModel extends ConnectedProductsModel {
  void login(String email, String password) {
    _authenticatedUser = User(id: 'dadada', email: email, password: password);
  }
}
