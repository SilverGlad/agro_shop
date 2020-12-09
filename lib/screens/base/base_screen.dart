import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pet_shop_app/models/page_manager.dart';
import 'package:pet_shop_app/models/user_manager.dart';
import 'package:pet_shop_app/screens/admin_clients/admin_clients.dart';
import 'package:pet_shop_app/screens/category/category_screen.dart';
import 'package:pet_shop_app/screens/home/home_screen.dart';
import 'package:pet_shop_app/screens/orders/orders_screen.dart';
import 'package:pet_shop_app/screens/products/products_screen.dart';
import 'package:pet_shop_app/screens/profile/profile_screen.dart';
import 'package:pet_shop_app/screens/suport/suport_screen.dart';
import 'package:pet_shop_app/screens/store/store_screen.dart';
import 'package:provider/provider.dart';


class BaseScreen extends StatefulWidget {

  @override
  _BaseScreenState createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  final PageController pageController = PageController();


  _BaseScreenState();



  @override
  void initState(){
    super.initState();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  }


  Widget build(BuildContext context){
    return Provider(
      create: (_) => PageManager(pageController),
      child: Consumer<UserManager>(
        builder: (_, userManager, __){
          return PageView(
            controller: pageController,
            physics: const NeverScrollableScrollPhysics(),
            children:<Widget>[
              HomeScreen(), //Page 0 (Tela inicial)
              ProductsScreen('', ''), //Page 1 (Todos os produtos)
              CategoryScreen(), //Page 2 (Categorias)
              OrdersScreen(),
              StoreScreen(),
              ProfileScreen(), //Page 3 (Dados pessoais)
              SuportScreen(), //Page 6 (Suporte)
              AdminClientsScreen(), //Page 8 (Lista de clientes)
              Container(), //Page 9 (Alterar planos)
            ],
          );
        },
      ),
    );
  }
}