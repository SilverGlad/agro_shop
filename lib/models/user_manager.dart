import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:pet_shop_app/helpers/firebase_errors.dart';
import 'package:pet_shop_app/models/user.dart';
import 'package:pet_shop_app/services/cepaberto_service.dart';

import 'address.dart';
//import 'package:flutter_facebook_login/flutter_facebook_login.dart';


class UserManager extends ChangeNotifier {

  UserManager(){
    loadCurrentUser();
  }



final FirebaseAuth auth = FirebaseAuth.instance;

User user;
Address address;

 final Firestore firestore = Firestore.instance;

bool _loading = false;
bool get loading =>_loading;
bool get isLoggedIn => user != null;

  set loading(bool value){
    _loading = value;
    notifyListeners();
  }

  bool _loadingFace = false;
  bool get loadingFace =>_loadingFace;
  bool get isLoggedInFace => user != null;

  set loadingFace(bool value){
    _loadingFace = value;
    notifyListeners();
  }

  Future<void> signIn({User user, Function onFail, Function onSuccess}) async{
    loading = true;
    try{
      final AuthResult result = await auth.signInWithEmailAndPassword(
          email: user.email, password: user.password);
      await loadCurrentUser(firebaseUser: result.user);
      onSuccess();
    }on PlatformException catch (e){
      onFail(getErrorString(e.code));
    }
    loading = false;
    notifyListeners();
  }


  Future<void> signUp({User user, Function onFail, Function onSuccess}) async {
    loading = true;

    try {
      final AuthResult result = await auth.createUserWithEmailAndPassword(
          email: user.email,
          password: user.password);

      user.id = result.user.uid;
      this.user = user;
      this.address = address;
      user.setAddress(address);
      await user.saveData();

      onSuccess();
    }on PlatformException catch (e){
        onFail(getErrorString(e.code));
    }
    loading = false;
    notifyListeners();
  }
/*
  Future<void> facebookLogin({Function onFail, Function onSuccess}) async{
    final result = await FacebookLogin().logIn(['email','public_profile']);

    loadingFace = true;

    switch(result.status){
      case FacebookLoginStatus.loggedIn:
        final credential = FacebookAuthProvider
            .getCredential(accessToken: result.accessToken.token);

        final authResult = await auth.signInWithCredential(credential);

        if(authResult.user != null) {
          final firebaseUser = authResult.user;

          user = User(
            id: firebaseUser.uid,
            name: firebaseUser.displayName,
            email: firebaseUser.email,
          );

          await user.saveData();

          onSuccess();

        }
        break;
      case FacebookLoginStatus.cancelledByUser:
        break;
      case FacebookLoginStatus.error:
        onFail(result.errorMessage);
        break;
    }
    loadingFace = false;
  }
*/
  void signOut(){
    auth.signOut();
    user = null;
    notifyListeners();
  }


  Future<void> loadCurrentUser({FirebaseUser firebaseUser}) async{
  final FirebaseUser currentUser = firebaseUser ??  await auth.currentUser();
    if(currentUser != null)
      {
       final DocumentSnapshot docUser = await firestore.collection('users')
           .document(currentUser.uid).get();

       user =  User.fromDocument(docUser);

       final docAdmin = await firestore.collection('admins').document(user.id).get();

       if(docAdmin.exists){
         user.admin = true;
       }

       notifyListeners();

      }
    notifyListeners();
  }

  bool get adminEnabled => user != null && user.admin;



  bool get isAddressValid => address != null;

  // ADDRESS

  Future<void> getAddress(String cep) async {
    loading = true;

    final cepAbertoService = CepAbertoService();

    try {
      final cepAbertoAddress = await cepAbertoService.getAddressFromCep(cep);

      if(cepAbertoAddress != null){
        address = Address(
            street: cepAbertoAddress.logradouro,
            district: cepAbertoAddress.bairro,
            zipCode: cepAbertoAddress.cep,
            city: cepAbertoAddress.cidade.nome,
            state: cepAbertoAddress.estado.sigla,
            lat: cepAbertoAddress.latitude,
            long: cepAbertoAddress.longitude
        );
      }
      loading = false;
    } catch (e){
      loading = false;
      return Future.error('CEP Inválido');
    }


  }



  Future<void> setAddress(Address address) async {
    loading = true;
    loading = false;
  }

  void removeAddress(){
    address = null;
    notifyListeners();
  }

}