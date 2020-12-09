import 'package:flutter/material.dart';
import 'package:pet_shop_app/models/product.dart';

class MyProductGridTile extends StatelessWidget {

  const MyProductGridTile(this.product);

  final Product product;


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
                Expanded(
                  child: ListView(
                    physics: const NeverScrollableScrollPhysics(),
                    children: <Widget> [
                     Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        AspectRatio(
                          aspectRatio: 1,
                          child: Image.network(product.images.first),
                        ),
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
                          padding: const EdgeInsets.only(left: 4.0, right: 4.0, top: 4.0),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: MaterialButton(
                                  height: 30,
                                  minWidth: 40,
                                  onPressed: (){

                                  },
                                  color: Colors.white,
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
                                  color: Colors.white,
                                  textColor: Colors.black,
                                  child: const Text(
                                      'OFF'
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
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
