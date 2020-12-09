import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pet_shop_app/models/section.dart';
import 'package:pet_shop_app/screens/home/components/section_header.dart';
import 'package:uuid/uuid.dart';

class HomeManager extends ChangeNotifier{
  HomeManager({this.images, this.id}){
    loadImages();
    _loadSections();

    images = images ?? [];
  }



  void addSection(Section section){
    _editingSections.add(section);
    notifyListeners();
  }

  Future<void> _loadSections() async{
    firestore.collection('home').orderBy('pos').snapshots().listen((snapshot) {
      _sections.clear();
      for(final DocumentSnapshot document in snapshot.documents){
        _sections.add( Section.fromDocument(document));
      }
      notifyListeners();
    });

  }

  final List<Section> _sections = [];
  List<Section> _editingSections = [];
  List<String> images;
  List<dynamic> newImages;
  String id;
  bool editing = false;
  bool loading = false;
  int index, totalItems;




  final Firestore firestore = Firestore.instance;
  final FirebaseStorage storage = FirebaseStorage.instance;
  DocumentReference get firestoreRef => firestore.document('home/$id');
  DocumentReference get firestoreCRef => firestore.document('homeC/$id');
  StorageReference get storageRef => storage.ref().child('home').child(id);


  Future<dynamic> loadImages() async{
    loading = true;
    firestore.collection('homeC').snapshots().listen((snapshot){
      for(final DocumentSnapshot document in snapshot.documents){
        id = document.documentID;
        images = List<String>.from(document.data['images'] as List<dynamic>);
      }
    });

    loading = false;
    notifyListeners();

  }
  List<Section>  get sections {
    if(editing)
      return _editingSections;
    else
      return _sections;
  }

  void enterEditing({Section section}){
    editing = true;

    _editingSections = _sections.map((s) => s.clone()).toList();

    defineIndex(section: section);

    notifyListeners();
  }


  void saveEditing() async{
    bool valid = true;
    for(final section in _editingSections){
      if(!section.valid()) valid = false;
    }
    if(!valid) return;
    loading = true;
    notifyListeners();

    int pos = 0;

    for(final section in _editingSections){
      await section.save(pos);
      pos++;
    }

    for(final section in List.from(_sections)){
      if(!_editingSections.any((s) => s.id == section.id)){
        await section.delete();
      }
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

    await firestoreCRef.updateData({'images': updateImages});

    images = updateImages;

    loading = false;
    editing = false;
    notifyListeners();

  }


  void discardEditing(){
    editing = false;
    notifyListeners();
  }


  HomeManager clone(){
    return HomeManager(
      images: List.from(images),

    );
  }

  void defineIndex({Section section}){
    index = _editingSections.indexOf(section);
    totalItems = _editingSections.length;
    notifyListeners();
  }

  void removeSection(Section section){
    _editingSections.remove(section);
    SectionHeader();
    notifyListeners();
  }

  void onMoveUp(Section section){
    int index = _editingSections.indexOf(section);

    if(index != 0) {
      _editingSections.remove(section);
      _editingSections.insert(index - 1, section);
      index = _editingSections.indexOf(section);
    }
    SectionHeader();
    notifyListeners();
  }



  void onMoveDown(Section section){

    index = _editingSections.indexOf(section);
    totalItems = _editingSections.length;
    if(index < totalItems - 1){
      _editingSections.remove(section);
      _editingSections.insert(index + 1, section);
      index = _editingSections.indexOf(section);
    }else{
    }
    SectionHeader();
    notifyListeners();
  }
}