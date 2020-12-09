import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pet_shop_app/models/category.dart';
import 'package:pet_shop_app/models/category_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'components/images_form.dart';





class EditCategoryScreen extends StatelessWidget {

  EditCategoryScreen(Category c) : category = c != null ? c.clone() : Category();


  var selectedCurrency, selectedType, currencyValue;


  final Category category;
  final Firestore firestore = Firestore.instance;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  List<String> _categoryType=<String>[];

  @override
  Widget build(BuildContext context) {
    String nameAnuncio;
    if(category.name != null){
      nameAnuncio = 'Editar Categoria';
    }else{
      nameAnuncio = 'Adicionar Categoria';
    }
    return ChangeNotifierProvider.value(
      value: category,
      child: Scaffold(
        appBar: AppBar(
          title:  Text(nameAnuncio),
          centerTitle: true,
          actions: <Widget>[
            if(category.name != null)
              IconButton(
                icon: Icon(Icons.delete),
                onPressed: (){
                  context.read<CategoryManager>().delete(category);
                  Navigator.of(context).pop();
                },
              )
          ],
        ),
        backgroundColor: Colors.white,
        body: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: ListView(
              children: <Widget>[
                ImagesForm(category),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextFormField(
                      initialValue: category.name,
                      decoration: const InputDecoration(
                        hintText: 'Titulo',
                        border: InputBorder.none,
                      ),
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600
                      ),
                      validator: (name){
                        if(name.length < 3)
                          return 'Titulo muito curto';
                        return null;
                      },
                      onSaved: (name) => category.name = name,
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Divider(),
                Consumer<Category>(
                  builder: (_, category, __){
                    return SizedBox(
                      height: 50,
                      child: RaisedButton(
                        onPressed: !category.loading ? () async{
                          if(formKey.currentState.validate()){
                            formKey.currentState.save();
                            await category.save();

                            context.read<CategoryManager>().update(category);

                            Navigator.of(context).pop();
                          }
                        } : null,
                        child: category.loading ? CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation(Colors.white),
                        ) :
                        const Text('Salvar', style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),),
                        color: Theme.of(context).primaryColor,
                        disabledColor: Theme.of(context).primaryColor.withAlpha(100),

                      ),
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );


  }



}
