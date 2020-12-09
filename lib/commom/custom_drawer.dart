import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:pet_shop_app/models/user_manager.dart';
import 'package:provider/provider.dart';
import 'custom_drawer_header.dart';
import 'drawer_tile.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.white,
                  Colors.white
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          Consumer<UserManager>(
            builder: (_, userManager, __){
              return ListView(
                children: <Widget>[
                  CustomDrawerHeader(),
                  const Divider(),
                  DrawerTile(
                    iconData: Icons.home,
                    title: 'Início',
                    page: 0,
                  ),
                  DrawerTile(
                    iconData: Icons.list_alt_rounded,
                    title: 'Produtos',
                    page: 1,
                  ),
                  DrawerTile(
                    iconData: Icons.list_rounded,
                    title: 'Categorias',
                    page: 2,
                  ),
                  DrawerTile(
                    iconData: Icons.auto_awesome_motion,
                    title: 'Meus pedidos',
                    page: 3,
                  ),
                  DrawerTile(
                    iconData: Icons.store_rounded,
                    title: 'Loja',
                    page: 4,
                  ),
                  DrawerTile(
                    iconData: Icons.person,
                    title: 'Meu perfil',
                    page: 5,
                  ),
                  DrawerTile(
                      iconData: Icons.help_outline, title: 'Suporte', page: 6),
                  userManager.adminEnabled == true?
                    Container(
                      child: Column(
                        children: [
                          Divider(),
                          DrawerTile(iconData: Icons.person_add, title: 'Fazer venda', page: 7),
                          DrawerTile(iconData: Icons.list_alt, title: 'Lista de usuários', page: 8),
                          DrawerTile(iconData: Icons.description, title: 'Pedidos', page: 9),
                        ],
                      ),
                    ): Container(),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
