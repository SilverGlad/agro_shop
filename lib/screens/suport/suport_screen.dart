import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pet_shop_app/commom/custom_drawer.dart';
import 'package:pet_shop_app/commom/custom_icon_button.dart';
import 'package:url_launcher/url_launcher.dart';

class SuportScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    Future<Void> openWhatsapp() async {
      var whatsappUrl = "whatsapp://send?phone=+5519984000073";

      if (await canLaunch(whatsappUrl)) {
        await launch(whatsappUrl);
      } else {
        throw 'Could not launch $whatsappUrl';
      }
    }
    Future<void> openPhone() async {
      var phoneUrl = "tel:(19)38971793";
      if(await canLaunch(phoneUrl)){
        launch(phoneUrl);
      } else {
      }
    }
    Future<void> openEmail() async {
      final Uri params = Uri(
        scheme: 'mailto',
        path: 'contato@provantagens.com.br',
        query: 'subject=Estou com dificuldades&body=Detalhe aqui seu problema: ',
      );
      String url = params.toString();
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        print('Could not launch $url');
      }
    }


    return Container(
        decoration: BoxDecoration(
        gradient: LinearGradient(colors: const [
        Colors.white,
        Colors.white,
        ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
    child: Scaffold(
    backgroundColor: Colors.transparent,
    drawer: CustomDrawer(),
    appBar: AppBar(
    backgroundColor: Colors.transparent,
    iconTheme: IconThemeData(color: Colors.black),
    title: Text('Suporte', style: TextStyle(color: Color.fromARGB(255, 30, 158, 8))),
    centerTitle: true,
    actions: <Widget>[

          ]
        ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 26.0),
              child: Text('Entre em contato conosco!',style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text('Nossa unidade:',style: TextStyle(
              fontSize: 24,
            ),),
          ),
          Column(
            children: <Widget>[
              Container(
                height: 160,
                child: Stack(
                  fit: StackFit.expand,
                  children: <Widget>[
                    Image.network(
                      'https://firebasestorage.googleapis.com/v0/b/pro-vantagens.appspot.com/o/Logo%2FLogo.jpg?alt=media&token=237f0582-cfdc-4d4f-85f4-0e441472ef7b',
                      fit: BoxFit.cover,
                    ),
                  ],
                ),
              ),
              Container(
                color: Theme.of(context).primaryColor,
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Rua Luis Camilo de Camargo, 175, Piso Superior - Hortolândia, SP',
                            style: TextStyle(color: Colors.white),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                        ],
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        CustomIconButton(
                          iconData: Icons.map,
                          color: Colors.white,
                          onTap: (){
                           // openMap();
                          },
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text('Contato:',style: TextStyle(
                  fontSize: 20,
                ),),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal:16.0, vertical: 8.0),
                child: GestureDetector(
                  onTap: (){
                    openPhone();
                  },
                  child: Row(
                    children: [
                      Text('Telefone: ',style: TextStyle(
                        fontSize: 16,
                      ),),
                      Text(' (19) 3897-1793',style: TextStyle(
                          fontSize: 16,
                          color: Colors.blue
                      ),),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal:16.0, vertical: 8.0),
                child: GestureDetector(
                  onTap: (){
                    openWhatsapp();
                  },
                  child: Row(
                    children: [
                      Text('WhatsApp: ',style: TextStyle(
                        fontSize: 16,
                      ),),
                      Text(' (19) 9 8400-0073',style: TextStyle(
                          fontSize: 16,
                          color: Colors.blue
                      ),),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal:16.0, vertical: 8.0),
                child: GestureDetector(
                  onTap: (){
                    openEmail();
                  },
                  child: Row(
                    children: [
                      Text('E-mail: ',style: TextStyle(
                        fontSize: 16,
                      ),),
                      Text(' contato@provantagens.com.br',style: TextStyle(
                          fontSize: 16,
                          color: Colors.blue
                      ),),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      )
    );
  }
}
