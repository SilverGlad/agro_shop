import 'package:flutter/material.dart';
import 'package:pet_shop_app/models/product.dart';


class ProductGridTile extends StatelessWidget {

  const ProductGridTile(this.product);

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
                  child: Column(
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
                        // ignore: unrelated_type_equality_checks
                        product.hasStock? 'R\$ ${product.basePrice.toStringAsFixed(2)}' : 'Sem estoque',
                        style: product.hasStock? TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w800,
                          color: Theme.of(context).primaryColor,
                        ) : TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w800,
                          color: Colors.red,
                        ) ,
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
