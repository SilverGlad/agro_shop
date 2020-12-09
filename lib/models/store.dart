import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:pet_shop_app/helpers/extensions.dart';
import 'package:uuid/uuid.dart';
import 'address.dart';

enum PartnerStatus{closed, open, closing}

class Store{

  Store({this.id, this.name, this.phone, this.image, this.opening, this.weekday, this.status, this.address,this.newImage, this.oldImage});

  Store.fromDocument(DocumentSnapshot doc){
    id = doc.documentID;
    name = doc.data['name'] as String;
    image = doc.data['image'] as String;
    oldImage = doc.data['image'] as String;
    phone = doc.data['phone'] as String;
    address = Address.fromMap(doc.data['address'] as Map<String, dynamic>);
    opening = (doc.data['opening'] as Map<String, dynamic>).map((key, value) {
      final timesString = value as String;

      if(timesString != null && timesString.isNotEmpty){
        final splitted = timesString.split(RegExp(r"[:-]"));

        return MapEntry(
            key,
            {
              "from": TimeOfDay(
                  hour: int.parse(splitted[0]),
                  minute: int.parse(splitted[1])
              ),
              "to": TimeOfDay(
                  hour: int.parse(splitted[2]),
                  minute: int.parse(splitted[3])
              ),
            }
        );
      } else {
        return MapEntry(key, null);
      }
    });

    updateStatus();
  }

  DocumentReference get firestoreRef =>
      Firestore.instance.document('store/$id');

  StorageReference get storageRef => storage.ref().child('store').child(id);

  final Firestore firestore = Firestore.instance;
  final FirebaseStorage storage = FirebaseStorage.instance;

  String id;
  String name;
  String image;
  String oldImage;
  dynamic newImage;
  String phone;
  String weekday;
  Address address;
  Map<String, Map<String, TimeOfDay>> opening;


  PartnerStatus status;

  String get cleanPhone => phone.replaceAll(RegExp(r"[^\d]"), "");

  String get addressText =>
      '${address.street}, ${address.number}${address.complement.isNotEmpty ? ' - ${address.complement}' : ''} - '
          '${address.district}, ${address.city}/${address.state}';

  String get openingText {
    if(weekday == 'monday')
      return  'Segunda-Feira: ${formattedPeriod(opening['monday'])}';
    if(weekday == 'tuesday')
      return  'Terça-Feira: ${formattedPeriod(opening['tuesday'])}';
    if(weekday == 'wednesday')
      return  'Quarta-Feira: ${formattedPeriod(opening['wednesday'])}';
    if(weekday == 'thursday')
      return  'Quinta-Feira: ${formattedPeriod(opening['thursday'])}';
    if(weekday == 'friday')
      return  'Sexta-Feira: ${formattedPeriod(opening['friday'])}';
    if(weekday == 'saturday')
      return  'Sábado: ${formattedPeriod(opening['saturday'])}';
    if(weekday == 'sunday')
      return  'Domingo: ${formattedPeriod(opening['sunday'])}';
  }

  String formattedPeriod(Map<String, TimeOfDay> period){
    if(period == null) return "Fechada";
    return '${period['from'].formatted()} - ${period['to'].formatted()}';
  }

  void updateStatus(){

    Map<String, TimeOfDay> period;

    if(DateTime.now().weekday == 1) {
      weekday = 'monday';
      period = opening['monday'];
    }
    if(DateTime.now().weekday == 2) {
      weekday = 'tuesday';
      period = opening['tuesday'];
    }
    if(DateTime.now().weekday == 3) {
      weekday = 'wednesday';
      period = opening['wednesday'];
    }
    if(DateTime.now().weekday == 4) {
      weekday = 'thursday';
      period = opening['thursday'];
    }
    if(DateTime.now().weekday == 5) {
      weekday = 'friday';
      period = opening['friday'];
    }
    if(DateTime.now().weekday == 6) {
      weekday = 'saturday';
      period = opening['saturday'];
    }
    if(DateTime.now().weekday == 7) {
      weekday = 'sunday';
      period = opening['sunday'];
    }

    final now = TimeOfDay.now();


    if(period == null){
      status = PartnerStatus.closed;

    } else if(period['from'].toMinutes() < now.toMinutes()
        && period['to'].toMinutes() - 15 > now.toMinutes()){
      status = PartnerStatus.open;

    } else if(period['from'].toMinutes() < now.toMinutes()
        && period['to'].toMinutes() > now.toMinutes()){
      status = PartnerStatus.closing;

    } else {
      status = PartnerStatus.closed;
    }

  }

  String get statusText {
    switch(status){
      case PartnerStatus.open:
        return 'Aberta';
      case PartnerStatus.closed:
        return 'Fechada';
      case PartnerStatus.closing:
        return 'Fecha em breve';
      default:
        return '';
    }
  }

  Store clone(){
    return Store(
      id: id,
      name: name,
      image: image,
      oldImage: oldImage,
      phone: phone,
      address: address,
      opening: opening
    );
  }

  bool _loading = false;
  bool get loading => _loading;
  set loading(bool value){
    _loading = value;
  }

  Future<void> save()async{
    loading = true;
    var monday, tuesday, wednesday, thursday, friday, saturday, sunday;
    monday =opening['monday'] == null? '': opening['monday']['from'].formatted().toString().replaceAll('h', ':') + '-' + opening['monday']['to'].formatted().toString().replaceAll('h', ':');
    tuesday =opening['tuesday'] == null? '': opening['tuesday']['from'].formatted().toString().replaceAll('h', ':') + '-' + opening['tuesday']['to'].formatted().toString().replaceAll('h', ':');
    wednesday =opening['wednesday'] == null? '': opening['wednesday']['from'].formatted().toString().replaceAll('h', ':') + '-' + opening['wednesday']['to'].formatted().toString().replaceAll('h', ':');
    thursday =opening['thursday'] == null? '': opening['thursday']['from'].formatted().toString().replaceAll('h', ':') + '-' + opening['thursday']['to'].formatted().toString().replaceAll('h', ':');
    friday =opening['friday'] == null? '': opening['friday']['from'].formatted().toString().replaceAll('h', ':') + '-' + opening['friday']['to'].formatted().toString().replaceAll('h', ':');
    saturday =opening['saturday'] == null? '': opening['saturday']['from'].formatted().toString().replaceAll('h', ':') + '-' + opening['saturday']['to'].formatted().toString().replaceAll('h', ':');
    sunday =opening['sunday'] == null? '': opening['sunday']['from'].formatted().toString().replaceAll('h', ':') + '-' + opening['sunday']['to'].formatted().toString().replaceAll('h', ':');
    final Map<String, dynamic> data = {
      'name': name,
      'phone' : phone,
      if(address != null)
        'address': address.toMap(),
    };


    if(id == null){
      final doc = await firestore.collection('store').add(data);
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

    Map<String, dynamic> toMap() {
      return {
        'monday': monday,
        'tuesday': tuesday,
        'wednesday': wednesday,
        'thursday': thursday,
        'friday': friday,
        'saturday': saturday,
        'sunday': sunday,
      };
    }
    await firestoreRef.updateData({'opening': toMap()});
  }





}