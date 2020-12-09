import 'package:flutter/material.dart';
import 'package:pet_shop_app/models/product_manager.dart';
import 'package:provider/provider.dart';


class SelectProductScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: const [
                Color.fromARGB(255, 203, 236, 241),
                Colors.white,

              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter
          )
      ),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Vincular Produto',
          style: TextStyle(color: Colors.black),),
          centerTitle: true,
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Colors.transparent,
        ),
        backgroundColor: Colors.transparent,
        body: Consumer<ProductManager>(
          builder: (_, productManager, __) {
            return ListView.builder(
                itemBuilder: (_, index) {
                  final product = productManager.allProducts[index];
                  return GestureDetector(
                    onTap: (){
                      Navigator.of(context).pop(product);
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4)
                     ),
                      child: Container(
                        height: 110,
                        color: Colors.white.withAlpha(300),
                          child: Row(
                            children: <Widget>[
                              AspectRatio(
                                aspectRatio: 1,
                                child: Image.network(product.images.first),
                              ),
                              const SizedBox(width: 16,),
                              Expanded(
                                child: Column(

                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      product.name,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 4),
                                      child: Text(
                                        'A partir de: ',
                                        style: TextStyle(
                                          color: Colors.grey[400],
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      'R\$ ${product.basePrice.toStringAsFixed(2)}',
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w800,
                                        color: Theme.of(context).primaryColor,
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          )
                      ),
                    ),
                  );
                },
                itemCount: productManager.allProducts.length);
          }
        ),
      ),
    );
  }
}
