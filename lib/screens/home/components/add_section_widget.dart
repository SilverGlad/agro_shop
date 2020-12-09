import 'package:flutter/material.dart';
import 'package:pet_shop_app/models/home_manager.dart';
import 'package:pet_shop_app/models/section.dart';

class AddSectionWidget extends StatelessWidget {

  const AddSectionWidget(this.homeManager);

  final HomeManager homeManager;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: FlatButton(
            onPressed: (){
              homeManager.addSection(Section(type: 'List'));
            },
            textColor: Colors.black,
            child: const Text('Adicionar lista'),
          ),
        ),
        Expanded(
          child: FlatButton(
            onPressed: (){
              homeManager.addSection(Section(type: 'Staggered'));
            },
            textColor: Colors.black,
            child: const Text('Adicionar grade'),
          ),
        )
      ],
    );
  }
}
