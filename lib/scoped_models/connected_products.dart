import 'dart:async';

import 'package:scoped_model/scoped_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/product.dart';
import '../models/user.dart';

class ConnectedProductsModel extends Model {
  List<Product> _products = [];
  User _authenticatedUser;
  String _selected_ProductId;
  bool _isLoading = false;

  Future<bool> addProduct(
      String title, String description, String image, double price) {
    _isLoading = true;
    notifyListeners();
    final Map<String, dynamic> productData = {
      'title': title,
      'description': description,
      'image':
          'https://cdn.pixabay.com/photo/2018/08/30/10/25/plums-3641844_960_720.jpg',
      'price': price,
      'userEmail': _authenticatedUser.email,
      'userId': _authenticatedUser.id
    };
    return http
        .post('https://flutterapp-12c55.firebaseio.com/products.json',
            body: json.encode(productData))
        .then((http.Response response) {
      if (response.statusCode != 200 && response.statusCode != 201) {
        print(response.statusCode);
        _isLoading = false;
        notifyListeners();
        return false;
      }
      final Map<String, dynamic> responseData = json.decode(response.body);
      print(responseData);
      final Product newProduct = Product(
          id: responseData['name'],
          title: title,
          description: description,
          image: image,
          price: price,
          userEmail: _authenticatedUser.email,
          userId: _authenticatedUser.id);
      _products.add(newProduct);
      _isLoading = false;
      notifyListeners();
      return true;
    }).catchError((err) {
      _isLoading = false;
      notifyListeners();
      return false;
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
    return _products.indexWhere((Product product) {
      return product.id == _selected_ProductId;
    });
  }

  String get selectedProductId {
    return _selected_ProductId;
  }

  Product get selectedProduct {
    if (selectedProductId == null) {
      return null;
    }
    return _products.firstWhere((Product product) {
      return product.id == _selected_ProductId;
    });
  }

  bool get displayFavOnly {
    return _showFav;
  }

  Future<bool> removeProduct() {
    _isLoading = true;
    final deletedProductId = selectedProduct.id;
    _products.removeAt(selectedProductIndex);
    _selected_ProductId = null;
    notifyListeners();
    return http
        .delete(
            'https://flutterapp-12c55.firebaseio.com/products/${deletedProductId}.json')
        .then((http.Response response) {
      if (response.statusCode != 200 || response.statusCode != 200) {
        _isLoading = false;
        notifyListeners();
        return false;
      }
      _isLoading = false;
      notifyListeners();
      return true;
    }).catchError((err) {
      _isLoading = false;
      notifyListeners();
      return false;
    });
  }

  Future<bool> updateProduct(
      String title, String description, String image, double price) {
    _isLoading = true;
    notifyListeners();
    Map<String, dynamic> updateData = {
      'title': title,
      'description': description,
      'image':
          'https://cdn.pixabay.com/photo/2017/10/27/22/43/coffee-2895730_960_720.jpg',
      'price': price,
      'userEmail': selectedProduct.userEmail,
      'userId': selectedProduct.userId
    };
    return http
        .put(
            'https://flutterapp-12c55.firebaseio.com/products/${selectedProduct.id}.json',
            body: json.encode(updateData))
        .then((http.Response response) {
      if (response.statusCode != 200 || response.statusCode != 201) {
      print("update error" + response.statusCode.toString());
        _isLoading = false;
        notifyListeners();
        return false;
      }
      _isLoading = false;
      final Product updatedProduct = Product(
          id: selectedProduct.id,
          title: title,
          description: description,
          image: image,
          price: price,
          userEmail: selectedProduct.userEmail,
          userId: selectedProduct.userId);
      _products[selectedProductIndex] = updatedProduct;
      notifyListeners();
      return true;
    }).catchError((err) {
      _isLoading = false;
      notifyListeners();
      return false;
    });
  }

  void selectProduct(String productId) {
    _selected_ProductId = productId;
    notifyListeners();
  }

  Future<Null> fetchProducts() {
    _isLoading = true;
    notifyListeners();
    return http
        .get('https://flutterapp-12c55.firebaseio.com/products.json')
        .then<Null>((http.Response response) {
      print(json.decode(response.body));
      final List<Product> fetchedProductList = [];
      final Map<String, dynamic> productListData = json.decode(response.body);
      if (productListData == null) {
        _isLoading = false;
        notifyListeners();
        return;
      }
      productListData.forEach((String productId, dynamic productData) {
        final Product product = Product(
            id: productId,
            title: productData['title'],
            description: productData['description'],
            image: productData['image'],
            price: productData['price'],
            userEmail: productData['userEmail'],
            userId: productListData['userId']);
        fetchedProductList.add(product);
      });
      _products = fetchedProductList;
      _isLoading = false;
      notifyListeners();
      _selected_ProductId = null;
    }).catchError((err) {
      _isLoading = false;
      notifyListeners();
      return;
    });
  }

  void favProduct() {
    final bool isCurFav = selectedProduct.isFav;
    final newFavStatus = !isCurFav;
    final Product updatedProduct = Product(
        id: selectedProduct.id,
        title: selectedProduct.title,
        description: selectedProduct.description,
        price: selectedProduct.price,
        image: selectedProduct.image,
        userEmail: selectedProduct.userEmail,
        userId: selectedProduct.userId,
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

class UtilityModel extends ConnectedProductsModel {
  bool get isLoading {
    return _isLoading;
  }
}
