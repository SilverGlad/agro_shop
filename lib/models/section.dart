import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:pet_shop_app/models/section_item.dart';
import 'package:uuid/uuid.dart';

class Section extends ChangeNotifier{

  Section({this.name, this.items, this.type, this.id, this.pos}){
      items = items ?? [];
      name = name ?? '';
      originalItems = List.from(items);
  }

  Section.fromDocument(DocumentSnapshot document){
    id = document.documentID;
    name = document.data['name'] as String;
    type = document.data['type'] as String;
    pos = document.data['pos'] as int;
    items = (document.data['items'] as List).map(
            (i) => SectionItem.fromMap(i as Map<String, dynamic>)).toList();

  }

  final Firestore firestore = Firestore.instance;
  final FirebaseStorage storage = FirebaseStorage.instance;

  DocumentReference get firestoreRef => firestore.document('home/$id');
  StorageReference get storageRef => storage.ref().child('home').child(id);

  String id;
  String name;
  String type;
  int pos;
  List<SectionItem> items;
  List<SectionItem> originalItems;

  String _error;
  String get error => _error;
  set error(String value){
    _error = value;
    notifyListeners();
  }

  Future<void> save(int pos) async{
    final Map<String,dynamic> data = {
      'name': name,
      'type': type,
      'pos': pos,
    };

    if(id == null){
      final doc = await firestore.collection('home').add(data);
      id = doc.documentID;
    }else
      await firestoreRef.updateData(data);

    for (final item in items){
      if(item.image is File){
        final StorageUploadTask task = storageRef.child(Uuid().v1()).putFile(item.image as File);
        final StorageTaskSnapshot snapshot = await task.onComplete;
        final String url = await snapshot.ref.getDownloadURL() as String;
        item.image = url;
      }
    }
    for (final original in originalItems){
      if(!items.contains(original) && (original.image as String).contains('firebase')){
        try{
          final ref = await storage.getReferenceFromUrl(original.image as String);
          await ref.delete();
        }catch(e){}
      }
    }

    final Map<String, dynamic> itemsData = {
      'items': items.map((e) => e.toMap()).toList(),
    };
    await firestoreRef.updateData(itemsData);
  }

  void addItem(SectionItem item){
    items.add(item);
    notifyListeners();
  }


  @override
  String toString() {
    return 'Section{firestore: $firestore, storage: $storage, id: $id, name: $name, type: $type, pos: $pos, items: $items, originalItems: $originalItems}';
  }

  Section clone(){
    return Section(
        id: id,
        name: name,
        type: type,
        pos: pos,
        items: items.map((s) => s.clone()).toList(),
    );
  }

  bool valid(){
    if(name == null || name.isEmpty){
      error = 'Título inválido';
    } else if(items.isEmpty){
      error = 'Insira ao menos uma imagem';
    } else {
      error = null;
    }
    return error == null;
  }

  Future<void> delete() async{
    await firestoreRef.delete();
    for(final item in items){
      if((item.image as String).contains('firebase')){
        try{
          final ref = await storage.getReferenceFromUrl(item.image as String);
          await ref.delete();
        }catch(e){}

      }
      }
  }

  void removeItem(SectionItem item){
    items.remove(item);
    notifyListeners();
  }

}