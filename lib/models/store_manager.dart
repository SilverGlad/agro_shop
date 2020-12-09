import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:pet_shop_app/models/store.dart';
import 'package:pet_shop_app/services/cepaberto_service.dart';


import 'address.dart';

class StoreManager extends ChangeNotifier {

  StoreManager(){
    _loadStoreList();
    _startTimer();
  }

  List<Store> store = [];
  Timer _timer;
  bool _loading = false;
  bool get loading =>_loading;
  set loading(bool value){
    _loading = value;
    notifyListeners();
  }
  Address address;


  final Firestore firestore = Firestore.instance;

  Future<void> _loadStoreList() async {
    final snapshot = await firestore.collection('store').getDocuments();

    store = snapshot.documents.map((e) => Store.fromDocument(e)).toList();

    notifyListeners();
  }
  Future<void> reloadStoreList() async {
    store = [];
    _loadStoreList();
  }

  void _startTimer(){
    _timer = Timer.periodic(const Duration(minutes: 1), (timer) {
      _checkOpening();
    });
  }

  void _checkOpening(){
    for(final partner in store)
      partner.updateStatus();
    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
    _timer?.cancel();
  }

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
    notifyListeners();
  }

  Future<void> loadPartnerAddress(Store part) async {
    removeAddress();
    if(part.address != null){
      address = await part.address;
      notifyListeners();
    }
  }

  void update(Store partner){
    store.removeWhere((p) => p.id == partner.id);
    store.add(partner);
    notifyListeners();
  }



  Future<void> setAddress(Address address) async {
    loading = true;
    this.address = address;
    loading = false;

    notifyListeners();
  }
  void load(){
    if (loading == true){
      loading = false;
    }else{
      loading = true;
    }
    notifyListeners();
  }

  void removeAddress()async{
    address = await null;
    notifyListeners();
  }


}