import 'package:flutter/material.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:pet_shop_app/commom/custom_icon_button.dart';
import 'package:pet_shop_app/models/store.dart';
import 'package:pet_shop_app/models/user_manager.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';


class StoreCard extends StatelessWidget {

  const StoreCard(this.store);

  final Store store;

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;

    Color colorForStatus(PartnerStatus status){
      switch(status){
        case PartnerStatus.closed:
          return Colors.red;
        case PartnerStatus.open:
          return Colors.green;
        case PartnerStatus.closing:
          return Colors.orange;
        default:
          return Colors.green;
      }
    }

    void showError(){
      Scaffold.of(context).showSnackBar(
          const SnackBar(
            content: Text('Esta função não está disponível neste dispositivo'),
            backgroundColor: Colors.red,
          )
      );
    }

    Future<void> openPhone() async {
      if(await canLaunch('tel:${store.cleanPhone}')){
        launch('tel:${store.cleanPhone}');
      } else {
        showError();
      }
    }

    Future<void > openMap() async {
      try {
        final availableMaps = await MapLauncher.installedMaps;

        showModalBottomSheet(
            context: context,
            builder: (_) {
              return SafeArea(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    for(final map in availableMaps)
                      ListTile(
                        onTap: (){
                          map.showMarker(
                            coords: Coords(store.address.lat, store.address.long),
                            title: store.name,
                            description: store.addressText,
                          );
                          Navigator.of(context).pop();
                        },
                        title: Text(map.mapName),
                        leading: Image(
                          image: map.icon,
                          width: 30,
                          height: 30,
                        ),
                      )
                  ],
                ),
              );
            }
        );
      } catch (e){
        showError();
      }
    }


    return Consumer<UserManager>(
      builder: (_, userManager, __){
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          child: Column(
            children: <Widget>[
              Container(
                height: 160,
                child: Stack(
                  fit: StackFit.expand,
                  children: <Widget>[
                    Image.network(
                      store.image,
                      fit: BoxFit.cover,
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: Container(
                        decoration: BoxDecoration(
                            color: colorForStatus(store.status),
                            borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(8)
                            )
                        ),
                        padding: const EdgeInsets.all(8),
                        child: Text(
                          store.statusText,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w800,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                    userManager.adminEnabled == true? Align(
                      alignment: Alignment.topLeft,
                      child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: const BorderRadius.only(
                                  bottomLeft: Radius.circular(8)
                              )
                          ),
                          padding: const EdgeInsets.all(8),
                          child: IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: (){
                              Navigator.of(context).pushNamed('/edit_store_screen', arguments: store);
                            },
                          )
                      ),
                    ): Container(),
                  ],
                ),
              ),
              Container(
                height: 140,
                color: primaryColor,
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            store.name,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w800,
                              fontSize: 17,
                            ),
                          ),
                          Text(
                            store.addressText,
                            style: TextStyle(color: Colors.white),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                          Text(
                            store.openingText,
                            style: const TextStyle(
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        CustomIconButton(
                          iconData: Icons.map,
                          color: Colors.white,
                          onTap: (){
                            openMap();
                          },
                        ),
                        CustomIconButton(
                          iconData: Icons.phone,
                          color: Colors.white,
                          onTap: (){
                            openPhone();
                          },
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}