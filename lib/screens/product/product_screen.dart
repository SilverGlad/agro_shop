import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:pet_shop_app/models/cart_manager.dart';
import 'package:pet_shop_app/models/product.dart';
import 'package:pet_shop_app/models/product_manager.dart';
import 'package:pet_shop_app/models/user_manager.dart';
import 'package:provider/provider.dart';
import 'components/size_widget.dart';

class ProductScreen extends StatelessWidget {

  const ProductScreen(this.product);

  final Product product;

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    ProductManager();
    return ChangeNotifierProvider.value(
      value: product,
      child: Scaffold(
        appBar: AppBar(
          title: Text(product.name),
          centerTitle: true,
          actions: <Widget>[
            Consumer<UserManager>(
              builder: (_, userManager, __){
                if(userManager.adminEnabled && !product.deleted){
                  return IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: (){
                      Navigator.of(context)
                          .pushReplacementNamed('/edit_product',
                          arguments: product);
                    },
                  );
                }else{
                  return Container();
                }
              },
            )
          ],
        ),
        backgroundColor: Colors.white,
        body: ListView(
          children: <Widget>[
            AspectRatio(
              aspectRatio: 1,
              child: Carousel(
                images: product.images.map((url){
                  return NetworkImage(url);
                }).toList(),
                dotSize: 4,
                dotSpacing: 15,
                dotBgColor: Colors.transparent,
                dotColor: primaryColor,
                autoplay: false,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text(
                    product.name,
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      'A partir de',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 13,
                      ),
                    ),
                  ),
                  Text(
                    product.hasStock? 'R\$ ${product.basePrice.toStringAsFixed(2)}' : 'Sem estoque',
                    style: product.hasStock? TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ) : TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16, bottom: 8),
                    child: Text(
                      'Descrição',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500
                      ),
                    ),
                  ),
                  Text(
                    product.description,
                    style: const TextStyle(
                        fontSize: 16
                    ),
                  ),
                  if(product.deleted)
                    Padding(
                          padding: const EdgeInsets.only(top: 16, bottom: 8),
                          child: Text(
                            'Esse produto não está mais disponível',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.red,
                            ),
                          ),
                  )
                  else
                    ...[
                      Padding(
                        padding: const EdgeInsets.only(top: 16, bottom: 8),
                        child: Text(
                          'Tamanhos',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500
                          ),
                        ),
                      ),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: product.sizes.map((s){
                          return SizeWidget(size: s);
                        }).toList(),
                      ),
                  ],
                  const SizedBox(height: 20,),
                  if(product.hasStock)
                    Consumer2<UserManager, Product>(
                      builder: (_, userManager, product, __){
                        return SizedBox(
                          height: 44,
                          child: RaisedButton(

                            onPressed: product.selectedSize != null ? (){
                                context.read<CartManager>().addToCart(product);
                                Navigator.of(context).pushNamed('/cart');
                            } : null,
                            color: primaryColor,
                            textColor: Colors.white,

                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  userManager.isLoggedIn
                                      ? 'Adicionar ao Carrinho'
                                      : 'Entre para Comprar',
                                  style: const TextStyle(fontSize: 18),

                                ),
                                Icon(Icons.add_shopping_cart),
                              ]
                            ),


                          ),

                        );
                      },

                    ),

                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}