import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:uuid/uuid.dart';

import 'item_size.dart';

class MyProduct extends ChangeNotifier {

  MyProduct({this.name, this.id, this.description, this.sizes, this.category, this.images, this.deleted = false}){
    images = images ?? [];
    sizes = sizes ?? [];
  }

  MyProduct.fromDocument(DocumentSnapshot document){
    id = document.documentID;
    name = document['name'] as String;
    description = document['description'] as String;
    category = document['category'] as String;
    images = List<String>.from(document.data['images'] as List<dynamic>);
    deleted = (document.data['deleted'] ?? false) as  bool;
    sizes = (document.data['sizes'] as List<dynamic> ?? []).map(
            (s) => ItemSize.fromMap(s as Map<String, dynamic>)).toList();
  }


  final Firestore firestore = Firestore.instance;
  final FirebaseStorage storage = FirebaseStorage.instance;

  DocumentReference get firestoreRef => firestore.document('products/$id');
  StorageReference get storageRef => storage.ref().child('products').child(id);

  String id;
  String name;
  String description;
  String category;
  String power;
  bool deleted;
  List<String> images;
  List<ItemSize> sizes;

  List<dynamic> newImages;

  bool _loading = false;
  bool get loading => _loading;
  set loading(bool value){
    _loading = value;
    notifyListeners();
  }

  ItemSize _selectedSize;
  ItemSize get selectedSize => _selectedSize;
  set selectedSize(ItemSize value){
    _selectedSize = value;
    notifyListeners();
  }

  int get totalStock {
    int stock = 0;
    for(final size in sizes){
      stock += size.stock;
    }
    return stock;
  }

  bool get hasStock {
    return totalStock > 0 && !deleted;
  }

  num get basePrice{
    num lowest = double.infinity;
    for(final size in sizes){
      if(size.price <lowest && size.hasStock)
        lowest = size.price;
    }
    return lowest;
  }

  ItemSize findSize(String name) {
    try {
      return sizes.firstWhere((s) => s.name == name);
    } catch (e) {
      return null;
    }
  }

  List<Map<String, dynamic>> exportSizeList(){
    return sizes.map((size) => size.toMap()).toList();
  }

  Future<void> save()async{
    loading = true;
    final Map<String, dynamic> data = {
      'name': name,
      'description' : description,
      'category' : category,
      'sizes' : exportSizeList(),
      'deleted': deleted,

    };

    if(id == null){
      final doc = await firestore.collection('products').add(data);
      id = doc.documentID;
    } else {
      await firestoreRef.updateData(data);
    }

    final List<String> updateImages = [];

    for(final newImage in newImages){
      if(images.contains(newImage)){
        updateImages.add(newImage as String);
      } else {
        final StorageUploadTask task = storageRef.child(Uuid().v1()).putFile(newImage as File);
        final StorageTaskSnapshot snapshot = await task.onComplete;
        final String url = await snapshot.ref.getDownloadURL() as String;
        updateImages.add(url);
      }
    }

    for(final image in images){
      if(!newImages.contains(image) && image.contains('firebase')){
        try {
          final ref = await storage.getReferenceFromUrl(image);
          await ref.delete();
        } catch (e){
          debugPrint('Falha ao deletar $image');
        }
      }
    }

    await firestoreRef.updateData({'images': updateImages});

    images = updateImages;

    loading = false;




  }



  MyProduct clone(){
    return MyProduct(
      id: id,
      name: name,
      description: description,
      category: category,
      images: List.from(images),
      sizes: sizes.map((size) => size.clone()).toList(),
      deleted: deleted,


    );
  }

  void delete(){
    firestoreRef.updateData({'deleted' :  true});
  }

  @override
  String toString() {
    return 'Product{id: $id, name: $name, description: $description, category: $category, images: $images, sizes: $sizes, newImages: $newImages}';
  }

}