import 'package:pet_shop_app/commom/price_card.dart';
import 'package:pet_shop_app/models/cart_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import 'components/address_card.dart';

class AddressScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Entrega', style: TextStyle(color: Colors.white),),
        centerTitle: true,
      ),
      body: ListView(
        children: <Widget>[
          AddressCard(),
          Consumer<CartManager>(
            builder: (_, cartManager, __){
              return PriceCard(
                buttonText: 'Continuar para pagamento',
                onPressed: cartManager.isAddressValid ? (){
                  Navigator.of(context).pushNamed('/checkout');
                } : null,
              );
            },
          ),
        ],
      ),
    );
  }
}