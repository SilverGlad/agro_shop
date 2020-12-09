import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';


class ImageSourceSheet extends StatelessWidget {

  ImageSourceSheet({this.onImageSelected});

  final Function(File) onImageSelected;

  final ImagePicker picker = ImagePicker();



  @override
  Widget build(BuildContext context) {

    Future<void> editImage(String path) async{
      final File croppedFile = await ImageCropper.cropImage(
          sourcePath: path,
          aspectRatio: const CropAspectRatio(
              ratioX: 1.0, ratioY: 1.0),
          androidUiSettings: AndroidUiSettings(
            toolbarTitle: 'Editar imagem',
            toolbarColor: Theme.of(context).primaryColor,
            toolbarWidgetColor: Colors.white,
          ),
          iosUiSettings: const IOSUiSettings(
            title: 'Editar imagem',
            cancelButtonTitle: 'Cancelar',
            doneButtonTitle: 'Concluir',
          )

      );
      if(croppedFile != null){
        onImageSelected(croppedFile);
      }
    }

    if(Platform.isAndroid)
      return BottomSheet(
        onClosing: (){},
        builder: (_) => Container(
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
          child: Column(
            mainAxisSize: MainAxisSize.min,

            crossAxisAlignment: CrossAxisAlignment.stretch,
            children:<Widget> [
              FlatButton(
                onPressed: () async{
                  final PickedFile file =
                  await picker.getImage(source: ImageSource.camera);
                  editImage(file.path);
                },
                child: const Text('Câmera'),
              ),
              FlatButton(
                onPressed: () async{
                  final PickedFile file =
                  await picker.getImage(source: ImageSource.gallery);
                  editImage(file.path);
                },
                child: const Text('Galeria'),
              ),
            ],
          ),
        ),
      );
    else if(Platform.isIOS)
      return CupertinoActionSheet(
        title: const Text('Selecionar foto para o Item'),
        message: const Text('Escolha a origem da foto'),
        cancelButton: CupertinoActionSheetAction(
          onPressed:() {
            Navigator.of(context).pop();
          },
          child: const Text('Cancelar'),
        ),
        actions: <Widget>[
          CupertinoActionSheetAction(
            onPressed: () async{
              final PickedFile file =
              await picker.getImage(source: ImageSource.camera);
              editImage(file.path);
            },
            child: const Text('Câmera'),
          ),
          CupertinoActionSheetAction(
            onPressed: () async{
              final PickedFile file =
              await picker.getImage(source: ImageSource.gallery);
              editImage(file.path);
            },
            child: const Text('Galeria'),
          ),
        ],
      );
  }
}
