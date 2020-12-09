import 'package:flutter/material.dart';
import 'package:pet_shop_app/models/page_manager.dart';
import 'package:provider/provider.dart';

class MenuIconTile extends StatelessWidget {

  MenuIconTile({this.iconData, this.title, this.page});

  final IconData iconData;
  final String title;
  final int page;

  @override
  Widget build(BuildContext context) {

    final int curPage = context
        .watch<PageManager>()
        .page;

    final Color primaryColor = Theme.of(context).primaryColor;


    return InkWell(
      onTap: (){
        context.read<PageManager>().setPage(page);

      },
      child: SizedBox(
        height: 60,
        child: Column(
          children: [
            Icon(
              iconData,
              color: Color.fromARGB(255, 30, 158, 8),
            ),
            Text(title),
          ],
        ),
      ),
    );
  }
}
