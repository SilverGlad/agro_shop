import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pet_shop_app/models/home_manager.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'components/images_form.dart';

class EditHomeScreen extends StatefulWidget {
  EditHomeScreen(HomeManager p)
      : homeManager = p != null ? p.clone() : HomeManager();

  final HomeManager homeManager;

  @override
  _EditHomeScreen createState() => _EditHomeScreen(homeManager);
}

class _EditHomeScreen extends State<EditHomeScreen> {
  _EditHomeScreen(this.homeManager) {}

  var selectedCurrency, selectedType, currencyValue;

  final HomeManager homeManager;
  final Firestore firestore = Firestore.instance;
  var totalList;
  var _tapPosition;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  List<String> _categoryType = <String>[];

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: const [
          Colors.white,
          Colors.white,
        ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            iconTheme: IconThemeData(color: Colors.black),
            title: Text('Editar propaganda',
                style: TextStyle(color: Color.fromARGB(255, 30, 158, 8))),
            centerTitle: true,
            actions: <Widget>[],
          ),
          body: Consumer<HomeManager>(builder: (_, homeManager, __) {
            return Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: ListView(
                  children: <Widget>[
                    homeManager.images.isEmpty
                        ? CircularProgressIndicator()
                        : ImagesForm(homeManager),
                    SizedBox(
                      height: 50,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Consumer<HomeManager>(
                        builder: (_, homeManager, __) {
                          return SizedBox(
                            height: 50,
                            child: RaisedButton(
                              onPressed: !homeManager.loading
                                  ? () async {
                                      if (formKey.currentState.validate()) {
                                        formKey.currentState.save();
                                        await homeManager.saveEditing();

                                        Navigator.of(context).pop();
                                      }
                                    }
                                  : null,
                              child: homeManager.loading
                                  ? CircularProgressIndicator(
                                      valueColor:
                                          AlwaysStoppedAnimation(Colors.white),
                                    )
                                  : const Text(
                                      'Salvar',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                              color: Theme.of(context).primaryColor,
                              disabledColor:
                                  Theme.of(context).primaryColor.withAlpha(100),
                            ),
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Consumer<HomeManager>(
                        builder: (_, homeManager, __) {
                          return SizedBox(
                            height: 50,
                            child: RaisedButton(
                              onPressed: !homeManager.loading
                                  ? () async {
                                      Navigator.of(context).pop();
                                    }
                                  : null,
                              child: const Text(
                                      'Cancelar',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                              color: Colors.red,
                              disabledColor: Colors.red.withAlpha(100),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ));
  }

  tableBeneficios() {
    return Table(
      defaultColumnWidth: FlexColumnWidth(120.0),
      border: TableBorder(
        horizontalInside: BorderSide(
          color: Colors.black,
          style: BorderStyle.solid,
          width: 1.0,
        ),
        verticalInside: BorderSide(
          color: Colors.black,
          style: BorderStyle.solid,
          width: 1.0,
        ),
      ),
      children: [
        _criarTituloTable(",Plus, Premium"),
        _criarLinhaTable("Seguro de vida\n\(Morte Acidental),X,X"),
        _criarLinhaTable("Seguro de Vida\n\(Qualquer natureza),,X"),
        _criarLinhaTable("Invalidez Total e Parcial,X,X"),
        _criarLinhaTable("Assistência Residencial,X,X"),
        _criarLinhaTable("Assistência Funeral,X,X"),
        _criarLinhaTable("Assistência Pet,X,X"),
        _criarLinhaTable("Assistência Natalidade,X,X"),
        _criarLinhaTable("Assistência Eletroassist,X,X"),
        _criarLinhaTable("Assistência Alimentação,X,X"),
        _criarLinhaTable("Descontos em Parceiros,X,X"),
      ],
    );
  }

  _criarLinhaTable(String listaNomes) {
    return TableRow(
      children: listaNomes.split(',').map((name) {
        return Container(
          alignment: Alignment.center,
          child: RichText(
            text: TextSpan(children: <TextSpan>[
              TextSpan(
                text: name != "X" ? '' : 'X',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              TextSpan(
                text: name != 'X' ? name : '',
                style: TextStyle(
                    fontSize: 10.0,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 30, 158, 8)),
              ),
            ]),
          ),
          padding: EdgeInsets.all(8.0),
        );
      }).toList(),
    );
  }

  _criarTituloTable(String listaNomes) {
    return TableRow(
      children: listaNomes.split(',').map((name) {
        return Container(
          alignment: Alignment.center,
          child: RichText(
            text: TextSpan(children: <TextSpan>[
              TextSpan(
                text: name == "" ? '' : 'Plano ',
                style: TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              TextSpan(
                text: name,
                style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 30, 158, 8)),
              ),
            ]),
          ),
          padding: EdgeInsets.all(8.0),
        );
      }).toList(),
    );
  }

  void _storePosition(TapDownDetails details) {
    _tapPosition = details.globalPosition;
  }
}
