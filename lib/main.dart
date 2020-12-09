import 'package:flutter/material.dart';
import 'package:pet_shop_app/models/admin_users_manager.dart';
import 'package:pet_shop_app/models/store.dart';
import 'package:pet_shop_app/models/benefits_manager.dart';
import 'package:pet_shop_app/models/home_manager.dart';
import 'package:pet_shop_app/models/store_manager.dart';
import 'package:pet_shop_app/screens/address/address_screen.dart';
import 'package:pet_shop_app/screens/cart/cart_screen.dart';
import 'package:pet_shop_app/screens/checkout/checkout_screen.dart';
import 'package:pet_shop_app/screens/confirmation/confirmation_screen.dart';
import 'package:pet_shop_app/screens/edit_category/edit_category_screen.dart';
import 'package:pet_shop_app/screens/edit_home/edit_home_screen.dart';
import 'package:pet_shop_app/screens/edit_product/edit_product_screen.dart';
import 'package:pet_shop_app/screens/login/login_screen.dart';
import 'package:pet_shop_app/screens/product/product_screen.dart';
import 'package:pet_shop_app/screens/products/products_screen.dart';
import 'package:pet_shop_app/screens/select_product/select_product_screen.dart';
import 'package:pet_shop_app/screens/store/store_screen.dart';
import 'package:pet_shop_app/screens/base/base_screen.dart';
import 'package:pet_shop_app/screens/signup/signup_screen.dart';
import 'package:pet_shop_app/screens/edit_store/edit_store_screen.dart';
import 'package:provider/provider.dart';
import 'models/admin_orders_manager.dart';
import 'models/cart_manager.dart';
import 'models/category.dart';
import 'models/category_manager.dart';
import 'models/order.dart';
import 'models/orders_manager.dart';
import 'models/product.dart';
import 'models/product_manager.dart';
import 'models/user_manager.dart';


void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {


  const MyApp();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserManager(),
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (_) => HomeManager(),
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (_) => StoreManager(),
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (_) => BenefitsManager(),
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (_) => ProductManager(),
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (_) => CategoryManager(),
          lazy: false,
        ),
        ChangeNotifierProxyProvider<UserManager, CartManager>(
          create: (_) => CartManager(),
          lazy: false,
          update: (_, userManager, cartManager) => cartManager..updateUser(userManager),
        ),
        ChangeNotifierProxyProvider<UserManager, AdminUsersManager>(
          create: (_) => AdminUsersManager(),
          lazy: false,
          update: (_, userManager, adminUsersManager) => adminUsersManager..updateUser(userManager),
        ),
        ChangeNotifierProvider(
          create: (_) => HomeManager(),
          lazy: false,
        ),

        ChangeNotifierProxyProvider<UserManager, OrdersManager>(
          create: (_) => OrdersManager(),
          lazy: false,
          update: (_, userManager, ordersManager) =>
          ordersManager..updateUser(userManager.user),
        ),
        ChangeNotifierProxyProvider<UserManager, AdminOrdersManager>(
          create: (_) => AdminOrdersManager(),
          lazy: false,
          update: (_, userManager, adminOrdersManager) =>
          adminOrdersManager..updateAdmin(
              adminEnabled: userManager.adminEnabled),
        ),
      ],
      child: MaterialApp(
        title: 'Pró Vantagens App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor:  const Color.fromARGB(255, 105, 190, 90),
          scaffoldBackgroundColor: const Color.fromARGB(255, 4, 125, 141),
          appBarTheme: const AppBarTheme(
              elevation: 0
          ),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        onGenerateRoute: (settings){
          switch(settings.name){
            case '/store':
              return MaterialPageRoute(
                builder: (_) => StoreScreen(),
              );
            case '/product':
              return MaterialPageRoute(
                  builder: (_) => ProductScreen(
                      settings.arguments as Product
                  )
              );
            case '/checkout':
              return MaterialPageRoute(
                  builder: (_) => CheckoutScreen()
              );
            case '/confirmation':
              return MaterialPageRoute(
                  builder: (_) => ConfirmationScreen(
                      settings.arguments as Order
                  )
              );
            case '/edit_product':
              return MaterialPageRoute(
                builder: (_) => EditProductScreen(settings.arguments as Product),
              );
            case '/edit_category':
              return MaterialPageRoute(
                builder: (_) => EditCategoryScreen(settings.arguments as Category),
              );
            case '/address':
              return MaterialPageRoute(
                builder: (_) => AddressScreen(),
              );
            case '/cart':
              return MaterialPageRoute(
                  builder: (_) => CartScreen(),
                  settings: settings
              );
            case '/select_product':
              return MaterialPageRoute(
                  builder: (_) => SelectProductScreen()
              );
            case '/login':
              return MaterialPageRoute(
                  builder: (_) => LoginScreen()
              );
            case '/signup':
              return MaterialPageRoute(
                builder: (_) => SignUpScreen(),
              );
            case '/edit_home_screen':
              return MaterialPageRoute(
                builder: (_) => EditHomeScreen(settings.arguments as HomeManager),
              );
            case '/edit_store_screen':
              return MaterialPageRoute(
                builder: (_) => EditStoreScreen(settings.arguments as Store),
              );
            case '/':
            default:
              return MaterialPageRoute(
                  builder: (_) => BaseScreen(),
                  settings: settings
              );
          }
        },
      ),
    );
  }
}