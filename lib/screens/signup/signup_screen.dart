import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:pet_shop_app/helpers/validators.dart';
import 'package:pet_shop_app/models/address.dart';
import 'package:pet_shop_app/models/user.dart';
import 'package:pet_shop_app/models/user_manager.dart';
import 'package:provider/provider.dart';

import 'components/address_input_field.dart';
import 'components/cep_input_field.dart';

class SignUpScreen extends StatefulWidget {
  _SignUpScreen createState() => _SignUpScreen();
}

class _SignUpScreen extends State<SignUpScreen> {
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
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: const Text(
              'Criar Conta',
              style: TextStyle(color: Colors.white),
            ),
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
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                              color: Colors.black,
                              width: 1,
                            ),
                          ),
                          margin: const EdgeInsets.symmetric(horizontal: 16),
                          child: ListView(
                            padding: const EdgeInsets.all(16),
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            children: <Widget>[
                              TextFormField(
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
                                onSaved: (name) => user.name = name,
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              TextFormField(
                                decoration: const InputDecoration(
                                    hintText: 'Data de nascimento'),
                                inputFormatters: [maskData],
                                keyboardType: TextInputType.number,
                                enabled: !userManager.loading,
                                validator: (dtn) {
                                  if (dtn.isEmpty) return 'Campo obrigatório';
                                  return null;
                                },
                                onSaved: (dtn) => user.dtn = dtn,
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              TextFormField(
                                decoration:
                                    const InputDecoration(hintText: 'CPF'),
                                inputFormatters: [maskCPF],
                                keyboardType: TextInputType.number,
                                enabled: !userManager.loading,
                                validator: (cpf) {
                                  if (cpf.isEmpty) return 'Campo obrigatório';
                                  return null;
                                },
                                onSaved: (cpf) => user.cpf = cpf,
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
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                              color: Colors.black,
                              width: 1,
                            ),
                          ),
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
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                              color: Colors.black,
                              width: 1,
                            ),
                          ),
                          margin: const EdgeInsets.symmetric(horizontal: 16),
                          child: ListView(
                            padding: const EdgeInsets.all(16),
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            children: <Widget>[
                              TextFormField(
                                decoration: const InputDecoration(
                                    hintText: 'Telefone 1'),
                                inputFormatters: [maskTel1],
                                keyboardType: TextInputType.number,
                                enabled: !userManager.loading,
                                validator: (tel1) {
                                  if (tel1.isEmpty) return 'Campo obrigatório';
                                  return null;
                                },
                                onSaved: (tel1) => user.tel1 = tel1,
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              TextFormField(
                                decoration: const InputDecoration(
                                    hintText: 'Telefone 2'),
                                inputFormatters: [maskTel2],
                                keyboardType: TextInputType.number,
                                enabled: !userManager.loading,
                                validator: (tel2) {
                                  if (tel2.isEmpty) return 'Campo obrigatório';
                                  return null;
                                },
                                onSaved: (tel2) => user.tel2 = tel2,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                              color: Colors.black,
                              width: 1,
                            ),
                          ),
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
                                onSaved: (email) => user.email = email,
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              TextFormField(
                                decoration:
                                    const InputDecoration(hintText: 'Senha'),
                                obscureText: true,
                                enabled: !userManager.loading,
                                validator: (pass) {
                                  if (pass.isEmpty)
                                    return 'Campo obrigatório';
                                  else if (pass.length < 6)
                                    return 'Senha muito curta';
                                  return null;
                                },
                                onSaved: (pass) => user.password = pass,
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              TextFormField(
                                decoration: const InputDecoration(
                                    hintText: 'Repita a Senha'),
                                obscureText: true,
                                enabled: !userManager.loading,
                                validator: (pass) {
                                  if (pass.isEmpty)
                                    return 'Campo obrigatório';
                                  else if (pass.length < 6)
                                    return 'Senha muito curta';
                                  return null;
                                },
                                onSaved: (pass) => user.confirmPassword = pass,
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

                                    if (user.password != user.confirmPassword) {
                                      scaffoldKey.currentState
                                          .showSnackBar(const SnackBar(
                                        content: Text('Senhas não coincidem!'),
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
                                            content:
                                                Text('Falha ao cadastrar: $e'),
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
                  ));
                },
              ),
            ),
          ),
        ));
  }
}
