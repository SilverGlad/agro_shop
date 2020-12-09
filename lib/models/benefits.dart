import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import 'address.dart';


class Benefits {

  Benefits({this.name, this.id, this.description, this.card, this.image, this.value});



  Benefits.fromDocument(DocumentSnapshot document){
    id = document.documentID;
    name = document.data['name'] as String;
    image = document.data['image'] as String;
    description = document.data['description'] as String;
    card = document.data['card'] as String;
    value = document.data['value'] as String;
  }

  String id;
  String name;
  String description;
  String oldImage;
  dynamic newImage;
  String card;
  String value;
  String image;


  DocumentReference get firestoreRef =>
      Firestore.instance.document('benefits/$id');
  StorageReference get storageRef => storage.ref().child('benefits').child(id);

  final Firestore firestore = Firestore.instance;
  final FirebaseStorage storage = FirebaseStorage.instance;

  Future<void> saveData() async {
    await firestoreRef.setData(toMap());
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'card': card,
    };
  }

  Benefits clone(){
    return Benefits(
      id: id,
      name: name,
      description:  description,
      card:  card,
      value:  value,
      image:  image,
    );
  }

  Future<void> save()async{

    final Map<String, dynamic> data = {
      'name': name,
      'description' : description,
      'card': card,
      'value': value,
    };


    if(id == null){
      final doc = await firestore.collection('benefits').add(data);
      id = doc.documentID;
    } else {
      await firestoreRef.updateData(data);
    }

    String updateImage;


    if(image == newImage){
      updateImage = newImage;
    } else {
      final StorageUploadTask task = storageRef.child(Uuid().v1()).putFile(newImage as File);
      final StorageTaskSnapshot snapshot = await task.onComplete;
      final String url = await snapshot.ref.getDownloadURL() as String;
      updateImage = url;
    }

    if(oldImage != newImage){
      try {
        final ref = await storage.getReferenceFromUrl(oldImage);
        await ref.delete();
      } catch (e){
        debugPrint('Falha ao deletar $oldImage');
      }
    }


    await firestoreRef.updateData({'image': updateImage});

    image = updateImage;

  }



}