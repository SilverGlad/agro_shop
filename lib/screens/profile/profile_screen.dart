import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:pet_shop_app/commom/custom_drawer.dart';
import 'package:pet_shop_app/helpers/validators.dart';
import 'package:pet_shop_app/models/address.dart';
import 'package:pet_shop_app/models/user.dart';
import 'package:pet_shop_app/models/user_manager.dart';
import 'package:provider/provider.dart';
import 'components/address_input_field.dart';
import 'components/cep_input_field.dart';

class ProfileScreen extends StatefulWidget {
  _ProfileScreen createState() => _ProfileScreen();
}

class _ProfileScreen extends State<ProfileScreen> {
  final GlobalKey<FormState> formKey01 = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  final User user = User();

  var estadoCivil;
  var _listaEstadoCivil = [
    'Solteiro(a)',
    'Casado(a)',
    'Separado(a)',
    'Divorciado(a)',
    'Viúvo(a)'
  ];

  //Mascaras para os formFields.
  var maskCPF = new MaskTextInputFormatter(
      mask: '###.###.###-##', filter: {"#": RegExp(r'[0-9]')});
  var maskRG = new MaskTextInputFormatter(
      mask: '##.###.###-#', filter: {"#": RegExp(r'[0-9]')});
  var maskData = new MaskTextInputFormatter(
      mask: '##/##/####', filter: {"#": RegExp(r'[0-9]')});
  var maskExped = new MaskTextInputFormatter(
      mask: '##/##/####', filter: {"#": RegExp(r'[0-9]')});
  var maskTel1 = new MaskTextInputFormatter(
      mask: '(##) ####-#### ', filter: {"#": RegExp(r'[0-9]')});
  var maskCel1 = new MaskTextInputFormatter(
      mask: '(##) # ####-#### ', filter: {"#": RegExp(r'[0-9]')});
  var maskTel2 = new MaskTextInputFormatter(
      mask: '(##) ####-#### ', filter: {"#": RegExp(r'[0-9]')});
  var maskCel2 = new MaskTextInputFormatter(
      mask: '(##) # ####-#### ', filter: {"#": RegExp(r'[0-9]')});

  final ScrollController listViewController = ScrollController();


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
          key: scaffoldKey,
          drawer: CustomDrawer(),
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: const Text('Meu perfil'),
            centerTitle: true,
          ),
          body: Center(
            child: Form(
              key: formKey01,
              child: Consumer<UserManager>(
                builder: (_, userManager, __) {
                  final address = userManager.address ?? Address();
                  return SingleChildScrollView(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Card(
                              margin: const EdgeInsets.symmetric(horizontal: 16),
                              child: ListView(
                                padding: const EdgeInsets.all(16),
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                children: <Widget>[
                                  TextFormField(
                                    initialValue: userManager.user.name,
                                    decoration: const InputDecoration(
                                        hintText: 'Nome Completo'),
                                    enabled: !userManager.loading,
                                    validator: (name) {
                                      if (name.isEmpty)
                                        return 'Campo obrigatório';
                                      else if (name.trim().split(' ').length <= 1)
                                        return 'Preencha seu Nome completo';
                                      return null;
                                    },
                                    onSaved: (name) => userManager.user.name = name,
                                  ),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  TextFormField(
                                    initialValue: userManager.user.dtn,
                                    decoration: const InputDecoration(
                                        hintText: 'Data de nascimento'),
                                    inputFormatters: [maskData],
                                    keyboardType: TextInputType.number,
                                    enabled: !userManager.loading,
                                    validator: (dtn) {
                                      if (dtn.isEmpty) return 'Campo obrigatório';
                                      return null;
                                    },
                                    onSaved: (dtn) => userManager.user.dtn = dtn,
                                  ),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  TextFormField(
                                    initialValue: userManager.user.cpf,
                                    decoration:
                                    const InputDecoration(hintText: 'CPF'),
                                    inputFormatters: [maskCPF],
                                    keyboardType: TextInputType.number,
                                    enabled: !userManager.loading,
                                    validator: (cpf) {
                                      if (cpf.isEmpty) return 'Campo obrigatório';
                                      return null;
                                    },
                                    onSaved: (cpf) => userManager.user.cpf = cpf,
                                  ),
                                ]
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Card(
                              margin: const EdgeInsets.symmetric(horizontal: 16),
                              child: ListView(
                                padding: const EdgeInsets.all(16),
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                children: <Widget>[
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        'Endereço',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16,
                                        ),
                                      ),
                                      CepInputField(address),
                                      AddressInputField(address),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Card(
                              margin: const EdgeInsets.symmetric(horizontal: 16),
                              child: ListView(
                                padding: const EdgeInsets.all(16),
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                children: <Widget>[
                                  TextFormField(
                                    initialValue: userManager.user.tel1,
                                    decoration: const InputDecoration(
                                        hintText: 'Telefone 1'),
                                    inputFormatters: [maskTel1],
                                    keyboardType: TextInputType.number,
                                    enabled: !userManager.loading,
                                    validator: (tel1) {
                                      if (tel1.isEmpty)
                                        return 'Campo obrigatório';
                                      return null;
                                    },
                                    onSaved: (tel1) => userManager.user.tel1 = tel1,
                                  ),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  TextFormField(
                                    initialValue: userManager.user.tel2,
                                    decoration: const InputDecoration(
                                        hintText: 'Telefone 2'),
                                    inputFormatters: [maskTel2],
                                    keyboardType: TextInputType.number,
                                    enabled: !userManager.loading,
                                    validator: (tel2) {
                                      if (tel2.isEmpty)
                                        return 'Campo obrigatório';
                                      return null;
                                    },
                                    onSaved: (tel2) => userManager.user.tel2 = tel2,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Card(
                              margin: const EdgeInsets.symmetric(horizontal: 16),
                              child: ListView(
                                padding: const EdgeInsets.all(16),
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                children: <Widget>[
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  TextFormField(
                                    initialValue: userManager.user.email,
                                    decoration:
                                    const InputDecoration(hintText: 'E-mail'),
                                    keyboardType: TextInputType.emailAddress,
                                    enabled: !userManager.loading,
                                    validator: (email) {
                                      if (email.isEmpty)
                                        return 'Campo obrigatório';
                                      else if (!emailValid(email))
                                        return 'E-mail inválido';
                                      return null;
                                    },
                                    onSaved: (email) => userManager.user.email = email,
                                  ),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: RaisedButton(
                              materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                              color: Theme.of(context).primaryColor,
                              disabledColor:
                              Theme.of(context).primaryColor.withAlpha(100),
                              textColor: Colors.white,
                              onPressed: userManager.loading
                                  ? null
                                  : () {
                                if (formKey01.currentState.validate()) {
                                  formKey01.currentState.save();

                                  if (userManager.user.password !=
                                      userManager.user.confirmPassword) {
                                    scaffoldKey.currentState
                                        .showSnackBar(const SnackBar(
                                      content:
                                      Text('Senhas não coincidem!'),
                                      backgroundColor: Colors.red,
                                    ));
                                    return;
                                  }

                                  userManager.setAddress(address);

                                  userManager.signUp(
                                      user: user,
                                      onSuccess: () {
                                        Navigator.of(context).pop();
                                      },
                                      onFail: (e) {
                                        scaffoldKey.currentState
                                            .showSnackBar(SnackBar(
                                          content: Text(
                                              'Falha ao cadastrar: $e'),
                                          backgroundColor: Colors.red,
                                        ));
                                      });

                                }
                              },
                              child: userManager.loading
                                  ? CircularProgressIndicator(
                                valueColor:
                                AlwaysStoppedAnimation(Colors.white),
                              )
                                  : const Text(
                                'Criar Conta',
                                style: TextStyle(fontSize: 15),
                              ),
                            ),
                          ),
                        ],
                      )
                  );
                },
              ),
            ),
          ),
        ));
  }
}
