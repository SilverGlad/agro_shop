import 'package:flutter/material.dart';
import 'package:pet_shop_app/models/my_product.dart';
import 'package:pet_shop_app/models/product.dart';


class MyProductListTile extends StatelessWidget {

  const MyProductListTile(this.product, {this.myProduct});

  final Product product;
  final MyProduct myProduct;


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){

         Navigator.of(context).pushNamed('/product', arguments: product);

      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4)
        ),
        child: Container(
          color: Colors.white70,
          height: 110,
          padding: const EdgeInsets.all(8),
          child: Row(
            children: <Widget>[
                AspectRatio(
                  aspectRatio: 1,
                  child: Image.network(product.images.first),
                ),
              const SizedBox(width: 16,),
              Expanded(
                child: ListView(
                  physics: NeverScrollableScrollPhysics(),
                  children: <Widget> [
                    Column(
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
                            'Controle: ',
                            style: TextStyle(
                              color: Colors.grey[400],
                              fontSize: 12,
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: MaterialButton(
                                height: 30,
                                minWidth: 40,
                                onPressed: (){

                                },
                                color: Colors.white, // myProduct.power == "On"? Colors.green : Colors.white,
                                textColor: Colors.black,
                                child: const Text(
                                    'ON'
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: MaterialButton(
                                height: 30,
                                minWidth: 40,
                                onPressed: (){

                                },
                                color: Colors.white,//myProduct.power == "On"? Colors.white : Colors.red,
                                textColor: Colors.black,
                                child: const Text(
                                    'OFF'
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              )
              ],
            )
          ),
      ),
    );
  }
}
