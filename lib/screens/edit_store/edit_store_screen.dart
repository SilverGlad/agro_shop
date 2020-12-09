import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:pet_shop_app/models/address.dart';
import 'package:pet_shop_app/models/store.dart';
import 'package:pet_shop_app/models/store_manager.dart';
import 'package:provider/provider.dart';
import 'components/address_input_field.dart';
import 'components/cep_input_field.dart';
import 'components/edit_store_hour.dart';
import 'components/images_form_store.dart';


class EditStoreScreen extends StatefulWidget {

  EditStoreScreen(Store p) : store = p != null ? p.clone() : Store();

  final Store store;


  @override
  _EditStoreScreen createState() => _EditStoreScreen(store);
}



class _EditStoreScreen extends State<EditStoreScreen> {

  _EditStoreScreen(this.store);

  final GlobalKey<FormState> formKey01 = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final ImagePicker picker = ImagePicker();
  final Store store;
  bool loading = false, loaded = false;
  //Mascaras para os formFields.
  var maskCPF = new MaskTextInputFormatter(
      mask: '###.###.###-##', filter: {"#": RegExp(r'[0-9]')});
  var maskRG = new MaskTextInputFormatter(
      mask: '##.###.###-#', filter: {"#": RegExp(r'[0-9]')});
  var maskData = new MaskTextInputFormatter(
      mask: '##/##/####', filter: {"#": RegExp(r'[0-9]')});
  var maskExped = new MaskTextInputFormatter(
      mask: '##/##/####', filter: {"#": RegExp(r'[0-9]')});
  var maskTel1 = new MaskTextInputFormatter(
      mask: '(##) ####-#### ', filter: {"#": RegExp(r'[0-9]')});
  var maskCel1 = new MaskTextInputFormatter(
      mask: '(##) # ####-#### ', filter: {"#": RegExp(r'[0-9]')});
  var maskTel2 = new MaskTextInputFormatter(
      mask: '(##) ####-#### ', filter: {"#": RegExp(r'[0-9]')});
  var maskCel2 = new MaskTextInputFormatter(
      mask: '(##) # ####-#### ', filter: {"#": RegExp(r'[0-9]')});

  final ScrollController listViewController = ScrollController();



  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              const Color.fromARGB(255, 105, 190, 90),
              Colors.white,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Scaffold(
          key: scaffoldKey,
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: store.name == null? Text('Adicionar parceiro', style: TextStyle(color: Colors.white),) : Text('Editar parceiro', style: TextStyle(color: Colors.white),),
            centerTitle: true,
          ),
          body: Center(
            child: Form(
              key: formKey01,
              child: Consumer<StoreManager>(
                builder: (_, storeManager, __) {
                  var address = storeManager.address ?? Address();
                  if(loaded == false){
                    storeManager.loadPartnerAddress(store);
                    loaded = true;
                  }

                  return SingleChildScrollView(
                      child: Column(
                        children: [
                          ImagesFormStore(store),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Card(
                              margin: const EdgeInsets.symmetric(horizontal: 16),
                              child: ListView(
                                padding: const EdgeInsets.all(16),
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                children: <Widget>[
                                  Text(
                                    'Nome',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                    ),
                                  ),
                                  TextFormField(
                                    initialValue: store.name != null? store.name: '',
                                    decoration: const InputDecoration(
                                        hintText: 'Nome do parceiro'),
                                    enabled: !storeManager.loading,
                                    validator: (name) {
                                      if (name.isEmpty)
                                        return 'Campo obrigatório';
                                      return null;
                                    },
                                    onSaved: (name) => store.name = name,
                                  ),
                                ],
                              ),
                            ),
                          ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Card(
                          margin: const EdgeInsets.symmetric(horizontal: 16),
                          child: ListView(
                            padding: const EdgeInsets.all(16),
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            children: <Widget>[
                              Text(
                                'Telefone',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                ),
                              ),
                              TextFormField(
                                initialValue: store.phone != null? store.phone: null,
                                decoration: const InputDecoration(
                                    hintText: 'Telefone'),
                                inputFormatters: [maskTel1],
                                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                                enabled: !storeManager.loading,
                                validator: (tel1) {
                                  if (tel1.isEmpty)
                                    return 'Campo obrigatório';
                                  return null;
                                },
                                onSaved: (tel1) => store.phone = tel1,
                              ),
                            ],
                          ),
                        ),
                      ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Card(
                              margin: const EdgeInsets.symmetric(horizontal: 16),
                              child: ListView(
                                padding: const EdgeInsets.all(16),
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                children: <Widget>[
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        'Endereço',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16,
                                        ),
                                      ),
                                      CepInputField(address),
                                      AddressInputField(address),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Card(
                              margin: const EdgeInsets.symmetric(horizontal: 16),
                              child: ListView(
                                padding: const EdgeInsets.all(16),
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                children: <Widget>[
                                  Text(
                                    'Horários',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                    ),
                                  ),
                                  EditStoreHour(store: store,),
                                ],
                              ),
                            ),
                          ),
                                Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: RaisedButton(
                                      materialTapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                      color: Theme.of(context).primaryColor,
                                      disabledColor:
                                      Theme.of(context).primaryColor.withAlpha(100),
                                      textColor: Colors.white,
                                      onPressed: storeManager.loading
                                          ? null
                                          : () async {
                                        if (formKey01.currentState.validate()) {
                                          formKey01.currentState.save();
                                          storeManager.load();
                                          await store.save();
                                          storeManager.load();
                                          storeManager.reloadStoreList();
                                          Navigator.pop(context);
                                        }
                                      },
                                      child: storeManager.loading
                                          ? CircularProgressIndicator(
                                        valueColor:
                                        AlwaysStoppedAnimation(Colors.white),
                                      )
                                          : const Text(
                                        'Salvar',
                                        style: TextStyle(fontSize: 15),
                                      ),
                                ),
                              )
                        ],
                      )
                  );
                },
              ),
            ),
          ),
        ));
  }



}
