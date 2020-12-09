import 'package:flutter/material.dart';
import 'package:pet_shop_app/commom/custom_drawer.dart';
import 'package:pet_shop_app/models/store_manager.dart';
import 'package:pet_shop_app/models/user_manager.dart';
import 'package:pet_shop_app/screens/store/components/store_card.dart';
import 'package:provider/provider.dart';

class StoreScreen extends StatelessWidget {
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
          drawer: CustomDrawer(),
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            iconTheme: IconThemeData(color: Colors.black),
            title: Text('Lojas', style: TextStyle(color: Color.fromARGB(255, 30, 158, 8))),
            centerTitle: true,
            actions: <Widget>[
              Consumer<UserManager>(
                  builder: (_, userManager, __){
                    if(userManager.adminEnabled)
                      return IconButton(
                        icon: Icon(Icons.add),
                        onPressed: (){
                         Navigator.of(context).pushNamed('/edit_store_screen');
                        },
                      );
                    else
                      return Container();
                  }),
              Divider(),
            ],
          ),
          body: Consumer<StoreManager>(
            builder: (_, storeManager, __) {
              if (storeManager.store.isEmpty) {

                return LinearProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(Colors.white),
                  backgroundColor: Colors.transparent,
                );
              }else{
                return ListView.builder(
                  itemCount: storeManager.store.length,
                  itemBuilder: (_, index) {
                    return StoreCard(storeManager.store[index]);
                  },
                );
              }
            },
          ),
        ));
  }
}
