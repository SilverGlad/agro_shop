import 'package:flutter/material.dart';
import 'package:pet_shop_app/commom/custom_drawer.dart';
import 'package:pet_shop_app/commom/empty_card.dart';
import 'package:pet_shop_app/commom/login_card.dart';
import 'package:pet_shop_app/commom/order_tile.dart';
import 'package:pet_shop_app/models/orders_manager.dart';
import 'package:provider/provider.dart';


class OrdersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: CustomDrawer(),
      appBar: AppBar(
        title: const Text('Meus Pedidos'),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Consumer<OrdersManager>(
        builder: (_, ordersManager, __){
          if(ordersManager.user == null){
            return LoginCard();
          }
          if(ordersManager.orders.isEmpty){
            return EmptyCard(
              title: 'Nenhuma compra encontrada!',
              iconData: Icons.border_clear,
            );
          }
          return ListView.builder(
              itemCount: ordersManager.orders.length,
              itemBuilder: (_, index){
                return OrderTile(
                    ordersManager.orders.reversed.toList()[index]
                );
              }
          );
        },
      ),
    );
  }
}