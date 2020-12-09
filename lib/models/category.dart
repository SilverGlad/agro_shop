import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:uuid/uuid.dart';


class Category extends ChangeNotifier {

  Category({this.name, this.id, this.images, this.deleted}) {
    images = images ?? [];
  }

  Category.fromDocument(DocumentSnapshot document){
    id = document.documentID;
    name = document ['name'] as String;
    images = List<String>.from(document.data['images'] as List<dynamic>);
    deleted = (document.data['deleted'] ?? false) as  bool;
  }

  String id = '';
  String name;
  bool deleted;
  List<String> images;

  List<dynamic> newImages;

  bool _loading = false;

  bool get loading => _loading;

  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }


  final Firestore firestore = Firestore.instance;
  final FirebaseStorage storage = FirebaseStorage.instance;

  StorageReference get storageRef =>
      storage.ref().child('category').child(id);

  DocumentReference get firestoreRef =>
      Firestore.instance.document('category/$id');

  CollectionReference get productRef =>
      firestoreRef.collection('products');


  Future<void> save() async {
    loading = true;
    final Map<String, dynamic> data = {
      'name': name,
      'deleted' : deleted,

    };

    if (id == null) {
      final doc = await firestore.collection('category').document(name).setData(
          data);
      id = name;
    } else {
      await firestoreRef.updateData(data);
    }
      final List<String> updateImages = [];

      for (final newImage in newImages) {
        if (images.contains(newImage)) {
          updateImages.add(newImage as String);
        } else {
          final StorageUploadTask task = storageRef.child(Uuid().v1()).putFile(
              newImage as File);
          final StorageTaskSnapshot snapshot = await task.onComplete;
          final String url = await snapshot.ref.getDownloadURL() as String;
          updateImages.add(url);
        }
      }
      for (final image in images) {
        if (!newImages.contains(image)) {
          try {
            final ref = await storage.getReferenceFromUrl(image);
            await ref.delete();
          } catch (e) {
            debugPrint('falha ao deletar');
          }
        }
      }
      await firestoreRef.updateData({'images': updateImages});

      images = updateImages;

      loading = false;
    }

    Category clone() {
      return Category(
        id: id,
        name: name,
        images: List.from(images),
        deleted : deleted,
      );
    }

  void delete(){
    firestoreRef.updateData({'deleted' :  true});
  }


  @override
    String toString() {
      return 'Category{id: $id, name: $name, images: $images, newImages: $newImages, firestore: $firestore, storage: $storage}';
    }
  }

