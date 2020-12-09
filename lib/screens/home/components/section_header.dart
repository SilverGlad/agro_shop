import 'package:flutter/material.dart';
import 'package:pet_shop_app/commom/custom_icon_button.dart';
import 'package:pet_shop_app/models/home_manager.dart';
import 'package:pet_shop_app/models/section.dart';
import 'package:provider/provider.dart';


class SectionHeader extends StatelessWidget {

  SectionHeader();


  @override
  Widget build(BuildContext context) {
    final homeManager = context.watch<HomeManager>();
    final section = context.watch<Section>();
    if(homeManager.editing){
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: TextFormField(
                  initialValue: section.name,
                  decoration: const InputDecoration(
                      hintText: 'Título',
                      isDense: true,
                      border: InputBorder.none
                  ),
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w800,
                    fontSize: 18,
                  ),
                  onChanged: (text) => section.name = text,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 4, right: 4),
                child: CustomIconButton(
                  iconData: Icons.arrow_drop_up,
                  color: Colors.black,
                  onTap: (){
                    homeManager.onMoveUp(section);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 4, right: 4),
                child: CustomIconButton(
                  iconData: Icons.arrow_drop_down,
                  color: Colors.black,
                  onTap: (){
                    homeManager.onMoveDown(section);
                  },
                ),
              ),
              CustomIconButton(
                iconData: Icons.remove,
                color: Colors.black,
                onTap: (){
                  homeManager.removeSection(section);
                },
              ),
            ],
          ),
          if(section.error != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Text(
                section.error,
                style: const TextStyle(
                    color: Colors.red
                ),
              ),
            )
        ],
      );
    } else {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Text(
          section.name ?? "Erro no nome da sessão",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w800,
            fontSize: 18,
          ),
        ),
      );
    }
  }
}