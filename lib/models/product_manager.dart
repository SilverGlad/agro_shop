import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:pet_shop_app/models/category.dart';
import 'package:pet_shop_app/models/product.dart';

class ProductManager extends ChangeNotifier {



  ProductManager({this.category}){
    _loadAllProducts();
  }

  final Category category;

  final Firestore firestore = Firestore.instance;

  List<Product> allProducts = [];

  String _search = '';

  String categoryfilt = '';





  get search => _search;
  set search(String value){
    _search = value;
    notifyListeners();
  }


  List<Product> get filteredProducts {
    final List<Product> filteredProducts = [];

    if(search.isEmpty){
      if(categoryfilt.isEmpty){
        filteredProducts.addAll(allProducts);
      }else{
        filteredProducts.addAll(
            allProducts.where(
                    (p) => p.category.toLowerCase().contains(categoryfilt.toLowerCase()) )
        );
      }
    }else{
      filteredProducts.addAll(
        allProducts.where(
                (p) => p.name.toLowerCase().contains(search.toLowerCase()) && p.category.toLowerCase().contains(categoryfilt.toLowerCase()) )
      );
    }

    return filteredProducts;
  }

  Future<void> _loadAllProducts() async {

    firestore.collection('products').where('deleted', isEqualTo: false).snapshots().listen((snapshot) {
      allProducts.clear();
      for(final DocumentSnapshot document in snapshot.documents){
        allProducts.add( Product.fromDocument(document));
      }
      notifyListeners();
    });

    notifyListeners();

  }

  void update(Product product){
    allProducts.removeWhere((p) => p.id == product.id);
    allProducts.add(product);
    notifyListeners();
  }

  Product findProductById(String id){
    try {
     return allProducts.firstWhere((p) => p.id == id);
    }catch(e){
      return null;
    }
  }

  void delete (Product product){
    product.delete();
    allProducts.removeWhere((p) => p.id == product.id);
    notifyListeners();
  }


}