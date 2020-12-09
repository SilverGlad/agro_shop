import 'package:flutter/material.dart';
import 'package:pet_shop_app/models/page_manager.dart';
import 'package:pet_shop_app/models/user_manager.dart';
import 'package:provider/provider.dart';


class CustomDrawerHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(32, 24, 16, 8),
      height: 400,
      child: Consumer<UserManager>(
        builder: (_, userManager, __) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              AspectRatio(
                aspectRatio: 1,
                child: Image.network(
                    'https://firebasestorage.googleapis.com/v0/b/petshop-462fa.appspot.com/o/logo%2Flogo-petshop-produtos-para-animais-com-pata-digital-arte-digital.jpg?alt=media&token=9777faa3-271d-488e-8010-a04176a365e8'),
              ),
              Text(
                'Olá, ${userManager.user?.name ?? ''}',
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 105, 190, 90),
                ),
              ),
              GestureDetector(
                onTap: () {
                  if (userManager.isLoggedIn) {
                    context.read<PageManager>().setPage(0);
                    userManager.signOut();
                  } else {
                    Navigator.of(context).pushNamed('/login');
                  }
                },
                child: Text(
                  userManager.isLoggedIn ? 'Sair' : 'Entre ou Cadastre-se ->',
                  style: TextStyle(
                    color: Color.fromARGB(255, 105, 190, 90),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
