import 'package:scoped_model/scoped_model.dart';
import '../models/product.dart';

class ProductsModel extends Model {
  List<Product> _products = [];
  int _selectedProductIndex;
  bool _showFav = false; 
  List<Product> get products {
    return List.from(_products);
  }
  List<Product> get disPlayedProducts {
    if(_showFav){
      return _products.where((Product product)=> product.isFav ).toList();
    }
    return List.from(_products);
  }
  int get selectedProductIndex {
    return _selectedProductIndex;
  }

  Product get selectedProduct {
    if (_selectedProductIndex == null) {
      return null;
    }
    return _products[_selectedProductIndex];
  }
  bool get displayFavOnly {
    return _showFav;
  }
  void addProduct(Product product) {
    _products.add(product);
    _selectedProductIndex = null;
    notifyListeners();
  }

  void removeProduct() {
    _products.removeAt(_selectedProductIndex);
    _selectedProductIndex = null;
    notifyListeners();
  }

  void updateProduct(Product product) {
    _products[_selectedProductIndex] = product;
    _selectedProductIndex = null;
    notifyListeners();
  }

  void selectProduct(int index) {
    _selectedProductIndex = index;
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
        isFav: newFavStatus);
    _products[_selectedProductIndex] = updatedProduct;
    _selectedProductIndex = null;
    notifyListeners();
  }
  void toggleDisplayMode(){
    _showFav = !_showFav;
    notifyListeners();
  }
}
