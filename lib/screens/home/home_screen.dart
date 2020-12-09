import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:pet_shop_app/commom/custom_drawer.dart';
import 'package:pet_shop_app/commom/custom_icons_icons.dart';
import 'package:pet_shop_app/models/home_manager.dart';
import 'package:pet_shop_app/models/user_manager.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import 'components/add_section_widget.dart';
import 'components/images_form.dart';
import 'components/menu_icon_tile.dart';
import 'components/section_list.dart';
import 'components/section_staggered.dart';


// ignore: must_be_immutable
class HomeScreen extends StatelessWidget {

  HomeManager homeManager;
  UserManager userManager;
  List<Widget> get children => null;
  int index;
  var _tapPosition;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: const [
                      Colors.white,
                      Colors.white,

                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter
                )
            ),
          ),
          CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                iconTheme: new IconThemeData(color: Colors.black),
                snap: true,
                floating: true,
                elevation: 0,
                backgroundColor: Colors.transparent,
                flexibleSpace: const FlexibleSpaceBar(
                  title: Text('Pagina inicial',
                    style: TextStyle(color: Colors.black),),
                  centerTitle: true,

                ),
                actions: <Widget>[
                  Consumer<HomeManager>(
                    builder: (_,homeManager,__){
                      if(homeManager.editing){
                        return IconButton(

                          icon: Icon(Icons.check),
                          color: Colors.green,
                          onPressed: () {
                            formKey.currentState.save();
                            homeManager.saveEditing();
                          }
                        );
                      }else{
                        return IconButton(

                          icon: Icon(Icons.shopping_cart),
                          color: Colors.black,
                          onPressed: () => Navigator.of(context).pushNamed('/cart'),
                        );
                      }
                    },
                  ),
                  Consumer2<UserManager, HomeManager>(
                    builder: (_,userManager, homeManager,__){
                      if(userManager.adminEnabled && !homeManager.loading){
                        if(homeManager.editing){
                          return IconButton(
                            icon: Icon(Icons.clear),
                            color: Colors.red,
                            onPressed: (){
                              homeManager.discardEditing();
                            },
                          );
                        }else{
                          return IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: (){
                              homeManager.enterEditing();
                            },
                          );
                        }
                      } else return Container();
                    },
                  )
                ],
              ),
              Consumer<HomeManager>(
                builder: (_, homeManager, __){
                  if(homeManager.editing){
                    return SliverToBoxAdapter(
                        child: Form(
                          key: formKey,
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: homeManager.images.isEmpty
                                ? CircularProgressIndicator()
                                : ImagesForm(homeManager),
                          ),
                        )
                    );
                  }else{
                    return SliverToBoxAdapter(
                      child: Column(
                        children: [
                          AspectRatio(
                            aspectRatio: 1,
                            child: homeManager.images.isEmpty ? CircularProgressIndicator():
                            Carousel(images: homeManager.images.map((url){
                              return Image.network(url, fit: BoxFit.cover,);
                            }).toList(),
                              dotSize: 4,
                              dotSpacing: 15,
                              dotBgColor: Colors.transparent,
                              autoplayDuration: const Duration(seconds: 10),),
                          ),
                          Column(
                            children: <Widget>[
                              Divider(
                                color: Colors.black,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  MenuIconTile(title: 'Produtos', iconData: Icons.apartment, page: 1,),
                                  MenuIconTile(title: 'Categorias', iconData: Icons.card_giftcard, page: 2,),
                                  MenuIconTile(title: 'Loja', iconData: Icons.help_outline, page: 6,),
                                ],
                              ),
                              Divider(
                                color: Colors.black,
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  }
                },
              ),

              Consumer<HomeManager>(
                builder: (_, homeManager, __){
                  if(homeManager.loading){
                    return SliverToBoxAdapter(
                      child: LinearProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(Theme.of(context).primaryColor),
                        backgroundColor: Colors.transparent,
                      ),
                    );
                  }

                  final children = homeManager.sections.map((section) {
                    index = homeManager.sections.indexOf(section);
                    switch(section.type){
                      case 'List':
                        return SectionList(section);
                      case 'Staggered':
                        return SectionStaggered(section);
                      default:
                        return Container();
                    }
                  }
                  ).toList();


                  if(homeManager.editing)
                    children.add(AddSectionWidget(homeManager));

                  return SliverList(
                    delegate: SliverChildListDelegate(children),
                  );
                },
              ),
              SliverToBoxAdapter(
                child: Container(
                  color: Color.fromARGB(255, 105, 190, 90),
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16),
                            child: Text(
                              '©  2020 todos os direitos reservados a Cartão Pró Vantagens.',
                              style: TextStyle(fontSize: 10),
                            ),
                          )
                        ],
                      ),
                      Divider(),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16),
                            child: Text(
                              'Rua Luís Camilo de Camargo, 175 -\n\Centro, Hortolândia (piso superior)',
                              style: TextStyle(fontSize: 10),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 16),
                            child: IconButton(
                              icon: Icon(CustomIcons.facebook),
                              color: Colors.black,
                              onPressed: () {
                                launch(
                                    'https://www.facebook.com/provantagens/');
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 16),
                            child: IconButton(
                              icon: Icon(CustomIcons.instagram),
                              color: Colors.black,
                              onPressed: () {
                                launch(
                                    'https://www.instagram.com/cartaoprovantagens/');
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              )
            ],
          ),
        ],
      ),
    );
  }



  void _storePosition(TapDownDetails details) {
    _tapPosition = details.globalPosition;
  }
}