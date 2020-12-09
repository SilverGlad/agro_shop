import 'package:flutter/material.dart';
import 'package:pet_shop_app/screens/products/products_screen.dart';
import 'package:provider/provider.dart';
import 'package:pet_shop_app/models/category.dart';
import 'package:pet_shop_app/models/page_manager.dart';
import 'package:pet_shop_app/models/user_manager.dart';

class CategoryListTile extends StatelessWidget {


  String filteredCategory;

   CategoryListTile(this.category, {this.pageManager});

  final Category category;
  final PageManager pageManager;




  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        GestureDetector(
          onTap: (){


            print("Categoria id: "+ category.id);
            print("Categoria nome: "+ category.name);
            Navigator.push(context,
                MaterialPageRoute(
                    builder: (context) => ProductsScreen(category.id, category.name)
                ));

          },
          child: Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4)
            ),
            child: Container(
                height: 100,
                padding: const EdgeInsets.all(8),
                child: Row(
                  children: <Widget>[
                    AspectRatio(
                      aspectRatio: 1,
                      child: Image.network(category.images.first),
                    ),
                    const SizedBox(width: 16,),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            category.name,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        Navigator.of(context)
                            .pushNamed('/edit_category',
                            arguments: category);
                      },
                      child: Consumer<UserManager>(
                        builder: (_, userManager, __) {
                          if(userManager.adminEnabled) {
                            return Row(
                              children: <Widget>[
                                Icon(Icons.edit)
                              ],
                            );
                          }
                          else{
                            return Container();
                          }
                        }
                      ),
                    ),

                  ],
                ),
            ),
          ),
        ),
      ],
    );
  }
}
