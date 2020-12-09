import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:pet_shop_app/models/category.dart';

class CategoryManager extends ChangeNotifier {

  String categoryName = '';

  CategoryManager(){
    _loadAllCategory();
  }

  final Firestore firestore = Firestore.instance;

  List<Category> allCategory = [];

  String _search = '';

  get search => _search;
  set search(String value){
    _search = value;
    notifyListeners();
  }


  List<Category> get filteredCategory {
    final List<Category> filteredCategory = [];

    if(search.isEmpty){
      filteredCategory.addAll(allCategory);
    }else{
      filteredCategory.addAll(
          allCategory.where(
                  (p) => p.name.toLowerCase().contains(search.toLowerCase()))
      );
    }

    return filteredCategory;
  }

  Future<void> _loadAllCategory() async {

    firestore.collection('category').where('deleted', isEqualTo: false).snapshots().listen((snapshot) {
      allCategory.clear();
      for(final DocumentSnapshot document in snapshot.documents){
        allCategory.add( Category.fromDocument(document));
      }
      notifyListeners();
    });



    notifyListeners();

  }

  void update(Category category){
    allCategory.removeWhere((c) => c.id == category.id);
    allCategory.add(category);
    notifyListeners();
  }


  void delete (Category category){
    category.delete();
    allCategory.removeWhere((p) => p.id == category.id);
    notifyListeners();
  }



}