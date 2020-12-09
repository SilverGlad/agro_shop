import 'package:cloud_firestore/cloud_firestore.dart';

import 'address.dart';


class User {

  User({this.email, this.password, this.name, this.id});



  User.fromDocument(DocumentSnapshot document){
    id = document.documentID;
    name = document.data['name'] as String;
    dtn = document.data['dtn'] as String;
    cpf = document.data['cpf'] as String;
    tel1 = document.data['tel1'] as String;
    tel2 = document.data['tel2'] as String;
    email = document.data['email'] as String;
    if(document.data.containsKey('address')){
      address = Address.fromMap(
          document.data['address'] as Map<String, dynamic>);
    }
  }

  String id;
  String name;
  String dtn;
  String cpf;
  String tel1;
  String tel2;
  String email;
  String password;

  String confirmPassword;

  bool admin = false;

  Address address;

  DocumentReference get firestoreRef =>
   Firestore.instance.document('users/$id');

  CollectionReference get cartReference =>
      firestoreRef.collection('cart');

  Future<void> saveData() async {
    await firestoreRef.setData(toMap());
  }

  Map<String, dynamic> toMap(){
    return {
      'name': name,
      'dtn': dtn,
      'cpf': cpf,
      'tel1': tel1,
      'tel2': tel2,
      'email': email,
      if(address != null)
        'address': address.toMap(),
    };
  }

  void setAddress(Address address){
    this.address = address;
    saveData();
  }
}