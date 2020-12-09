import 'package:flutter/material.dart';
import 'package:pet_shop_app/commom/custom_drawer.dart';
import 'package:provider/provider.dart';
import 'package:pet_shop_app/models/category_manager.dart';
import 'package:pet_shop_app/models/user_manager.dart';

import 'components/category_list_tile.dart';
import 'components/search_dialog.dart';


class CategoryScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {

    return Container(
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
        drawer: CustomDrawer(),
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Colors.transparent,
          title: Consumer<CategoryManager>(
            builder: (_, categoryManager, __){
              if(categoryManager.search.isEmpty){
                return const Text('Categorias',
                style: TextStyle(color: Colors.black),);
              }else{
                return LayoutBuilder(
                  builder: (_, constraints){
                    constraints.biggest.width;
                    return GestureDetector(
                      onTap: () async{
                        final search = await showDialog<String>(context: context,
                            builder: (_) => SearchDialog(categoryManager.search));
                        if(search !=null){
                          categoryManager.search = search;
                        }
                      },

                      child: Container(
                          width: constraints.biggest.width,
                          child: Text(categoryManager.search)
                      ),
                    );
                  },
                );
              }
            },
          ),
          centerTitle: true,
          actions: <Widget>[
            Consumer<CategoryManager>(
              builder: (_, categoryManager, __){
                if(categoryManager.search.isEmpty){
                  return IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () async{
                      final search = await showDialog<String>(context: context,
                          builder: (_) => SearchDialog(categoryManager.search));
                      if(search !=null){
                        categoryManager.search = search;
                      }
                    },
                  );
                } else{
                  return IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () async{
                      categoryManager.search = '';
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
                          .pushNamed('/edit_category');
                    },
                  );
                }else{
                  return Container();
                }
              },
            ),
          ],
        ),
        body: Consumer<CategoryManager>(

          builder: (_, categoryManager, __){
            final filteredCategory = categoryManager.filteredCategory;

            return ListView.builder(
                padding: const EdgeInsets.all(4),
                itemCount: filteredCategory.length,
                itemBuilder: (_,index){
                  return CategoryListTile(filteredCategory[index]);

                }


            );

          },
        ),
      ),
    );
  }
}
