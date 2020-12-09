import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pet_shop_app/helpers/validators.dart';
import 'package:pet_shop_app/models/user.dart';
import 'package:pet_shop_app/models/user_manager.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';


class LoginScreen extends StatelessWidget {

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.white,
            Colors.white,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Scaffold(
        backgroundColor:  Colors.transparent,
        key: scaffoldKey,
        appBar: AppBar(
          title: const Text('Entrar', style: TextStyle(color: Colors.white),),
          centerTitle: true,
          actions: <Widget>[
            FlatButton(
              onPressed: (){
                Navigator.of(context).pushNamed('/signup');
              },
              textColor: Colors.white,
              child: const Text(
                'CRIAR CONTA',
                style: TextStyle(fontSize: 14),
              ),
            )
          ],
        ),
        body: Center(
          child: Column(
            children: [
              AspectRatio(
                aspectRatio: 1.5,
                child: Image.network(
                    'https://firebasestorage.googleapis.com/v0/b/petshop-462fa.appspot.com/o/logo%2Flogo-petshop-produtos-para-animais-com-pata-digital-arte-digital.jpg?alt=media&token=9777faa3-271d-488e-8010-a04176a365e8'),
              ),
              Card(
                elevation: 6,
                shape: RoundedRectangleBorder(
                    side: BorderSide(
                      color: Colors.black,
                      width: 1,
                    ),
                ),
                margin: const EdgeInsets.symmetric(horizontal: 16),
                child: Form(
                  key: formKey,
                  child: Consumer<UserManager>(
                    builder: (_, userManager, child){
                      if(userManager.loadingFace){
                        return Padding(
                          padding: const EdgeInsets.all(16),
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation(Colors.white),
                          ),
                        );
                      }
                      return ListView(
                        padding: const EdgeInsets.all(16),
                        shrinkWrap: true,
                        children: <Widget>[
                          TextFormField(
                            controller: emailController,
                            enabled: !userManager.loading,
                            decoration: const InputDecoration(hintText: 'E-mail'),
                            keyboardType: TextInputType.emailAddress,
                            autocorrect: false,
                            validator: (email){
                              if(!emailValid(email))
                                return 'E-mail inválido';
                              return null;
                            },
                          ),
                          const SizedBox(height: 16,),
                          TextFormField(
                            controller: passController,
                            enabled: !userManager.loading,
                            decoration: const InputDecoration(hintText: 'Senha'),
                            autocorrect: false,
                            obscureText: true,
                            validator: (pass){
                              if(pass.isEmpty || pass.length < 6)
                                return 'Senha inválida';
                              return null;
                            },
                          ),
                          child,
                          const SizedBox(height: 16,),
                          RaisedButton(
                            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            onPressed: userManager.loading ? null : (){
                              if(formKey.currentState.validate()){
                                userManager.signIn(
                                    user: User(
                                        email: emailController.text,
                                        password: passController.text
                                    ),
                                    onFail: (e){
                                      scaffoldKey.currentState.showSnackBar(
                                          SnackBar(
                                            content: Text('Falha ao entrar: $e'),
                                            backgroundColor: Colors.red,
                                          )
                                      );
                                    },
                                    onSuccess: (){
                                      Navigator.of(context).pop();
                                    }
                                );
                              }
                            },
                            color: Theme.of(context).primaryColor,
                            disabledColor: Theme.of(context).primaryColor
                                .withAlpha(100),
                            textColor: Colors.white,
                            child: userManager.loading ?
                            CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation(Colors.white),
                            ) :
                            const Text(
                              'Entrar',
                              style: TextStyle(
                                  fontSize: 15
                              ),
                            ),
                          ),
                         /* SignInButton(
                            Buttons.Facebook,
                            text: 'Entrar com Facebook',
                            onPressed: (){
                              userManager.facebookLogin(
                                  onFail: (e){
                                scaffoldKey.currentState.showSnackBar(
                                    SnackBar(
                                      content: Text('Falha ao entrar: $e'),
                                      backgroundColor: Colors.red,
                                    )
                                );
                              },
                              onSuccess: (){
                              Navigator.of(context).pop();
                                }
                              );
                            },
                          )*/
                        ],
                      );
                    },
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: FlatButton(
                        onPressed: (){
                          Firestore.instance.collection('teste').add({'teste': 'teste'});
                        },
                        padding: EdgeInsets.zero,
                        child: const Text(
                            'Esqueci minha senha'
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}