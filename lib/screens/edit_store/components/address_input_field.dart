import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pet_shop_app/models/address.dart';
import 'package:pet_shop_app/models/store_manager.dart';
import 'package:provider/provider.dart';


class AddressInputField extends StatelessWidget {

  const AddressInputField(this.address);

  final Address address;


  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    final storeManager = context.watch<StoreManager>();
    String emptyValidator(String text) =>
        text.isEmpty ? 'Campo obrigatório' : null;


    if(address.zipCode != null)
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          TextFormField(
            enabled: !storeManager.loading,
            initialValue: address.street,
            decoration: const InputDecoration(
              isDense: true,
              labelText: 'Rua/Avenida',
              hintText: 'Av. Brasil',
            ),
            validator: emptyValidator,
            onSaved: (t) => address.street = t,
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: TextFormField(
                  enabled: true,
                  initialValue: address.number,
                  decoration: const InputDecoration(
                    isDense: true,
                    labelText: 'Número',
                    hintText: '123',
                  ),
                  keyboardType: TextInputType.number,
                  validator: emptyValidator,
                  onSaved: (t) => address.number = t,
                ),
              ),
              const SizedBox(
                width: 16,
              ),
              Expanded(
                child: TextFormField(
                  initialValue: address.complement,
                  decoration: const InputDecoration(
                    isDense: true,
                    labelText: 'Complemento',
                    hintText: 'Opcional',
                  ),
                  onSaved: (t) => address.complement = t,
                ),
              ),
            ],
          ),
          TextFormField(
            initialValue: address.district,
            decoration: const InputDecoration(
              isDense: true,
              labelText: 'Bairro',
              hintText: 'Guanabara',
            ),
            validator: emptyValidator,
            onSaved: (t) => address.district = t,
          ),
          Row(
            children: <Widget>[
              Expanded(
                flex: 3,
                child: TextFormField(
                  enabled: false,
                  initialValue: address.city,
                  decoration: const InputDecoration(
                    isDense: true,
                    labelText: 'Cidade',
                    hintText: 'Campinas',
                  ),
                  validator: emptyValidator,
                  onSaved: (t) => address.city = t,
                ),
              ),
              const SizedBox(
                width: 16,
              ),
              Expanded(
                child: TextFormField(
                  autocorrect: false,
                  enabled: false,
                  textCapitalization: TextCapitalization.characters,
                  initialValue: address.state,
                  decoration: const InputDecoration(
                    isDense: true,
                    labelText: 'UF',
                    hintText: 'SP',
                    counterText: '',
                  ),
                  maxLength: 2,
                  validator: (e) {
                    if (e.isEmpty) {
                      return 'Campo obrigatório';
                    } else if (e.length != 2) {
                      return 'Inválido';
                    }
                    return null;
                  },
                  onSaved: (t) => address.state = t,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8,),
          if(storeManager.loading)
            LinearProgressIndicator(
              valueColor: AlwaysStoppedAnimation(primaryColor),
              backgroundColor: Colors.transparent,
            ),
        ],
      );
    else if(address.zipCode != null)
      return Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: Text(
            '${address.street}, ${address.number}\n${address.district}\n'
                '${address.city} - ${address.state}'
        ),
      );
    else return Container();
  }
}