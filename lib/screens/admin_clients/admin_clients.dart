import 'package:alphabet_list_scroll_view/alphabet_list_scroll_view.dart';
import 'package:flutter/material.dart';
import 'package:pet_shop_app/commom/custom_drawer.dart';
import 'package:pet_shop_app/models/admin_users_manager.dart';
import 'package:provider/provider.dart';

class AdminClientsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        title: const Text('Usuários', style: TextStyle(color: Colors.white),),
        centerTitle: true,
      ),
      body: Container(
        color: Colors.white,
        child: Consumer<AdminUsersManager>(
          builder: (_, adminUsersManager, __){
            return AlphabetListScrollView(
              itemBuilder: (_, index){
                return Card(
                  elevation: 10,
                  child: ListTile(
                    title: Text(
                      adminUsersManager.users[index].name,
                      style: TextStyle(
                          fontWeight: FontWeight.w800,
                          color: Theme.of(context).primaryColor
                      ),
                    ),
                    subtitle: Text(
                      adminUsersManager.users[index].email,
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                );
              },
              highlightTextStyle: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: 20
              ),
              indexedHeight: (index) => 80,
              strList: adminUsersManager.names,
              showPreview: true,
            );
          },
        ),
      ),
    );
  }
}