import 'dart:io';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pet_shop_app/models/store.dart';
import 'package:pet_shop_app/models/store_manager.dart';
import 'package:provider/provider.dart';
import 'image_source_sheet.dart';

class ImagesFormStore extends StatefulWidget {
  ImagesFormStore(this.store);
  final Store store;
  _ImagesFormStore createState() => _ImagesFormStore(store);
}



class _ImagesFormStore extends State<ImagesFormStore> {
  _ImagesFormStore(this.store);
  final Store store;
  final ImagePicker picker = ImagePicker();
  File imageFile;
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return FormField(
      onSaved: (image) => store.newImage = imageFile ?? store.image,
      builder:(state) {
        return Consumer<StoreManager>(
          builder: (_, storeManager, __) {
            return Stack(
              children: <Widget>[
                AspectRatio(
                aspectRatio: 1,
                child: Consumer<StoreManager>(
                  builder: (_, storeManager, __) {
                    if (store.image != null && imageFile == null) {
                      return loading == true ? CircularProgressIndicator() : Image
                          .network(store.image, fit: BoxFit.cover,);
                    } else if (imageFile != null) {
                      return loading == true ? CircularProgressIndicator() : Image
                          .file(imageFile, fit: BoxFit.cover,);
                    } else
                      return loading == true
                          ? CircularProgressIndicator()
                          : IconButton(
                        icon: Icon(Icons.add_a_photo, size: 50,),
                        onPressed: () async {
                          setState(() {
                            loading = true;
                          });
                          final PickedFile file =
                          await picker.getImage(source: ImageSource.gallery);
                          file != null? imageFile = File(file.path): null;
                          setState(() {
                            loading = false;
                          });
                        },
                      );
                  },
                ),
              ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: store.image != null && loading != true || imageFile != null && loading != true ? Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white
                      ),

                      child: IconButton(
                        icon: Icon(Icons.delete, color: Colors.red,),
                        onPressed: (){
                          setState(() {
                            imageFile = null;
                            store.image = null;
                          });
                        },
                      ),
                    ): Container(),
                  ),
                )
              ]);
          },
        );
      },
    );
  }
}
