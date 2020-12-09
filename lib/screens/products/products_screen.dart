import 'package:flutter/material.dart';
import 'package:pet_shop_app/commom/custom_drawer.dart';
import 'package:provider/provider.dart';
import 'package:pet_shop_app/models/product_manager.dart';
import 'package:pet_shop_app/models/user_manager.dart';

import 'components/products_grid_tile.dart';
import 'components/products_list_tile.dart';
import 'components/search_dialog.dart';


class ProductsScreen extends StatelessWidget {
   ProductsScreen(this.filterCategory, this.nameCategory);


  final String filterCategory;
  final String nameCategory;



  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: const [
                  Colors.white,
                  Colors.white,

                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter
            )
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          drawer: filterCategory != ''? null : CustomDrawer(),
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            iconTheme: IconThemeData(color: Colors.black),
            title: Consumer<ProductManager>(
              builder: (_, productManager, __){
                if(productManager.search.isEmpty){
                  if(filterCategory.isEmpty){
                    return const Text('Produtos',
                      style: TextStyle(color: Colors.black),);
                  }else{
                    return  Text(nameCategory.substring(0,1).toUpperCase() + nameCategory.substring(1).toLowerCase(),
                      style: TextStyle(color: Colors.black),);
                  }

                }else{
                  return LayoutBuilder(
                    builder: (_, constraints){
                      constraints.biggest.width;
                      return GestureDetector(
                        onTap: () async{
                          final search = await showDialog<String>(context: context,
                              builder: (_) => SearchDialog(productManager.search));

                          if(search !=null){
                            productManager.search = search ;
                          }
                        },

                        child: Container(

                          width: constraints.biggest.width,
                            child: Text(productManager.search)
                        ),
                      );
                    },
                  );
                }
              },
            ),
            bottom: TabBar(
              indicatorColor: Colors.black,
              tabs: <Widget>[
                Tab(icon: Icon(Icons.grid_on, color: Colors.black,)),
                Tab(icon: Icon(Icons.list, color: Colors.black,),)
              ],
            ),

            centerTitle: true,
            actions: <Widget>[
            Divider(),
              Consumer<ProductManager>(
                builder: (_, productManager, __){
                  if(productManager.search.isEmpty){
                   return IconButton(
                      icon: Icon(Icons.search),
                      onPressed: () async{

                        final search = await showDialog<String>(context: context,
                            builder: (_) => SearchDialog(productManager.search));

                        if(search !=null){
                          productManager.search = search;
                        }

                      },
                    );
                  } else{
                   return IconButton(
                      icon: Icon(Icons.close),
                      onPressed: () async{
                        productManager.search = '';
                        },
                    );
                  }
                },
              ),
              Consumer<UserManager>(
                builder: (_, userManager, __){
                  if(userManager.adminEnabled){
                    return IconButton(
                      icon: Icon(Icons.add),
                      onPressed: (){
                        Navigator.of(context)
                            .pushNamed('/edit_product');
                      },
                    );
                  }else{
                    return Container();
                  }
                },
              ),
            ],
          ),
          body: TabBarView(
            children: [
              Consumer<ProductManager>(
                builder: (_, productManager, __){
                  productManager.categoryfilt = filterCategory;
                  final filteredProducts = productManager.filteredProducts;


                  return GridView.builder(
                      padding: const EdgeInsets.all(4),
                      itemCount: filteredProducts.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 4,
                          crossAxisSpacing: 4,
                          childAspectRatio: 0.65),
                      itemBuilder: (_,index){
                        productManager.categoryfilt = filterCategory;
                        return ProductGridTile(filteredProducts[index]);

                      }
                  );
                },
              ),
              Consumer<ProductManager>(
                builder: (_, productManager, __){
                  productManager.categoryfilt = filterCategory;
                  final filteredProducts = productManager.filteredProducts;


                  return ListView.builder(
                      padding: const EdgeInsets.all(4),
                      itemCount: filteredProducts.length,
                      itemBuilder: (_,index){
                        productManager.categoryfilt = filterCategory;
                        return ProductListTile(filteredProducts[index]);

                      }
                  );
                },
              ),
            ],
          ),

          floatingActionButton: Consumer2<UserManager, ProductManager>(
              builder: (_, userManager, productManager, __) {
                return FloatingActionButton(
                  backgroundColor: Theme.of(context).primaryColor,
                  foregroundColor: Colors.white,
                  onPressed: () {
                      Navigator.of(context).pushNamed('/cart');
                  },
                  child: Icon(Icons.shopping_cart),
                );
              })
        ),
      ),
    );
  }
}
