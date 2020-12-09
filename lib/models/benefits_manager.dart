import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'benefits.dart';

class BenefitsManager extends ChangeNotifier {

  BenefitsManager(){
    _loadBenefitsList();
  }

  List<Benefits> benefits = [];

  bool _loading = false;
  bool get loading =>_loading;
  set loading(bool value){
    _loading = value;
    notifyListeners();
  }

  final Firestore firestore = Firestore.instance;

  Future<void> _loadBenefitsList() async {
    final snapshot = await firestore.collection('benefits').getDocuments();
    benefits = snapshot.documents.map((e) => Benefits.fromDocument(e)).toList();
    notifyListeners();
  }

  Future<void> reloadBenefitsList() async {
    benefits = [];
    _loadBenefitsList();
  }

  void load(){
    if (loading == true){
      loading = false;
    }else{
      loading = true;
    }
    notifyListeners();
  }



}