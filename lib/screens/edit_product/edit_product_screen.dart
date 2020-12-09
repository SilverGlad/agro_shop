import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pet_shop_app/models/category.dart';
import 'package:pet_shop_app/models/category_manager.dart';
import 'package:pet_shop_app/models/product.dart';
import 'package:pet_shop_app/models/product_manager.dart';

import 'components/images_form.dart';
import 'components/sizes_form.dart';

class EditProductScreen extends StatefulWidget {

  EditProductScreen(Product p) : product = p != null ? p.clone() : Product();

  final Product product;


  @override
  _EditProductScreen createState() => _EditProductScreen(product);
}



class _EditProductScreen extends State<EditProductScreen> {

  _EditProductScreen(this.product, {this.categoryManager}){
    comboValue();
  }

  var selectedCurrency, selectedType, currencyValue;


  final Product product;
  final CategoryManager categoryManager;
  final Firestore firestore = Firestore.instance;
  var totalList;



  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  List<String> _categoryType=<String>[

  ];

  @override
  Widget build(BuildContext context) {
    comboValue();
    String nameAnuncio;
    if(product.name != null){
      nameAnuncio = 'Editar Produto';
    }else{
      nameAnuncio = 'Adicionar Produto';
    }
    return ChangeNotifierProvider.value(
      value: product,
      child: Scaffold(
        appBar: AppBar(
          title:  Text(nameAnuncio),
          centerTitle: true,
          actions: <Widget>[
            if(product.name != null)
              IconButton(
                icon: Icon(Icons.delete),
                onPressed: (){
                  context.read<ProductManager>().delete(product);
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
                ImagesForm(product),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextFormField(
                      initialValue: product.name,
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
                      onSaved: (name) => product.name = name,
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
                      'R\$ ...',
                      style: TextStyle(
                        fontSize: 22.0,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Divider(),
                    Text('Categoria', style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500)
                    ),
                    StreamBuilder<QuerySnapshot>(
                      stream: Firestore.instance.collection('category').where('deleted', isEqualTo: false).snapshots(),
                      builder: (_,snapshot){
                        if(!snapshot.hasData){
                          Text('Carregando...');
                        }else{
                          List<DropdownMenuItem> currencyItems=[];
                          for(int i = 0; i<snapshot.data.documents.length;i++) {
                            DocumentSnapshot snap = snapshot.data.documents[i];
                            currencyItems.add(
                                DropdownMenuItem(
                                  child: Text(
                                   snap ['name'] as String,
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  value: snap.documentID,
                                )
                            );
                            totalList = snap.documentID;
                            comboValue();

                          }
                          return DropdownButtonFormField(
                            items: currencyItems,
                            onChanged: (currencyValue){
                              comboValue();
                              setState(() {
                                selectedCurrency = currencyValue;
                              });
                            },

                            value: selectedCurrency,

                            //isExpanded: true,
                            hint: Text(
                              'Selecione a categoria'
                            ),
                            onSaved: (category) => product.category,
                          );
                        }
                        return Container();
                      },

                    ),
                  ],
                      ),
                      SizedBox(height: 10),
                      Divider(),
                      Text('Descrição', style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500)
                      ),
                      TextFormField(
                        initialValue: product.description,
                        style: const TextStyle(
                            fontSize: 16
                        ),
                        decoration: const InputDecoration(
                          hintText: 'Descrição',
                          border: InputBorder.none,
                        ),
                        maxLines: null,
                        validator: (desc){
                          if(desc.length < 5)
                            return 'Descrição muito curta';
                          return null;
                        },
                        onSaved: (desc) => product.description = desc,
                      ),
                      SizedBox(height: 10),
                      Divider(),
                      SizesForm(product),
                      SizedBox(height: 10),
                      Divider(),
                Consumer<Product>(
                  builder: (_, product, __){
                    return SizedBox(
                      height: 50,
                      child: RaisedButton(
                        onPressed: !product.loading ? () async{
                          if(formKey.currentState.validate()){
                            formKey.currentState.save();
                            product.category = selectedCurrency;
                            await product.save();

                            context.read<ProductManager>().update(product);

                            Navigator.of(context).pushReplacementNamed('/product', arguments: product);
                          }
                        } : null,
                        child: product.loading ? CircularProgressIndicator(
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
  void comboValue(){
      currencyValue = product.category;
      print('CurrencyValue: $currencyValue');
      print('TotalList: $totalList');
      if(totalList == currencyValue){
        selectedCurrency = currencyValue;
      }

  }



}
