import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:pet_shop_app/commom/custom_icon_button.dart';
import 'package:pet_shop_app/models/store.dart';


class EditStoreHour extends StatelessWidget {

  EditStoreHour({Key key, this.store}): super(key: key);
  final Store store;


  var maskSegF = new MaskTextInputFormatter(
      mask: '##:##', filter: {"#": RegExp(r'[0-9]')});
  var maskSegT = new MaskTextInputFormatter(
      mask: '##:##', filter: {"#": RegExp(r'[0-9]')});

  var maskTerF = new MaskTextInputFormatter(
      mask: '##:##', filter: {"#": RegExp(r'[0-9]')});
  var maskTerT = new MaskTextInputFormatter(
      mask: '##:##', filter: {"#": RegExp(r'[0-9]')});

  var maskQuaF = new MaskTextInputFormatter(
      mask: '##:##', filter: {"#": RegExp(r'[0-9]')});
  var maskQuaT = new MaskTextInputFormatter(
      mask: '##:##', filter: {"#": RegExp(r'[0-9]')});

  var maskQuiF = new MaskTextInputFormatter(
      mask: '##:##', filter: {"#": RegExp(r'[0-9]')});
  var maskQuiT = new MaskTextInputFormatter(
      mask: '##:##', filter: {"#": RegExp(r'[0-9]')});

  var maskSexF = new MaskTextInputFormatter(
      mask: '##:##', filter: {"#": RegExp(r'[0-9]')});
  var maskSexT = new MaskTextInputFormatter(
      mask: '##:##', filter: {"#": RegExp(r'[0-9]')});

  var maskSabF = new MaskTextInputFormatter(
      mask: '##:##', filter: {"#": RegExp(r'[0-9]')});
  var maskSabT = new MaskTextInputFormatter(
      mask: '##:##', filter: {"#": RegExp(r'[0-9]')});

  var maskDomF = new MaskTextInputFormatter(
      mask: '##:##', filter: {"#": RegExp(r'[0-9]')});
  var maskDomT = new MaskTextInputFormatter(
      mask: '##:##', filter: {"#": RegExp(r'[0-9]')});



  @override
  Widget build(BuildContext context) {
    return store.name == null? Column(
      children: [
        Row(
          children: <Widget>[
            Expanded(
              flex: 30,
              child: Text('Segunda'),
            ),
            const SizedBox(width: 4,),
            Expanded(
              flex: 30,
              child: TextFormField(
                inputFormatters: [maskSegF],
                decoration: const InputDecoration(
                  labelText: 'Abre as:',
                  isDense: true,
                ),
                keyboardType: TextInputType.number,
              ),
            ),
            const SizedBox(width: 4,),
            Expanded(
              flex: 40,
              child: TextFormField(
                inputFormatters: [maskSegT],
                decoration: const InputDecoration(
                  labelText: 'Fecha as:',
                  isDense: true,
                ),
                keyboardType: TextInputType.number,
              ),
            ),
            CustomIconButton(
              iconData: Icons.backspace,
              color: Colors.red,
            ),
          ],
        ),
        Row(
          children: <Widget>[
            Expanded(
              flex: 30,
              child: Text('Terça'),
            ),
            const SizedBox(width: 4,),
            Expanded(
              flex: 30,
              child: TextFormField(
                inputFormatters: [maskTerF],
                decoration: const InputDecoration(
                  labelText: 'Abre as:',
                  isDense: true,
                ),
                keyboardType: TextInputType.number,
              ),
            ),
            const SizedBox(width: 4,),
            Expanded(
              flex: 40,
              child: TextFormField(
                inputFormatters: [maskTerT],
                decoration: const InputDecoration(
                  labelText: 'Fecha as:',
                  isDense: true,
                ),
                keyboardType: TextInputType.number,
              ),
            ),
            CustomIconButton(
              iconData: Icons.backspace,
              color: Colors.red,
            ),
          ],
        ),
        Row(
          children: <Widget>[
            Expanded(
              flex: 30,
              child: Text('Quarta'),
            ),
            const SizedBox(width: 4,),
            Expanded(
              flex: 30,
              child: TextFormField(
                inputFormatters: [maskQuaF],
                decoration: const InputDecoration(
                  labelText: 'Abre as:',
                  isDense: true,
                ),
                keyboardType: TextInputType.number,
              ),
            ),
            const SizedBox(width: 4,),
            Expanded(
              flex: 40,
              child: TextFormField(
                inputFormatters: [maskQuaT],
                decoration: const InputDecoration(
                  labelText: 'Fecha as:',
                  isDense: true,
                ),
                keyboardType: TextInputType.number,
              ),
            ),
            CustomIconButton(
              iconData: Icons.backspace,
              color: Colors.red,
            ),
          ],
        ),
        Row(
          children: <Widget>[
            Expanded(
              flex: 30,
              child: Text('Quinta'),
            ),
            const SizedBox(width: 4,),
            Expanded(
              flex: 30,
              child: TextFormField(
                inputFormatters: [maskQuiF],
                decoration: const InputDecoration(
                  labelText: 'Abre as:',
                  isDense: true,
                ),
                keyboardType: TextInputType.number,
              ),
            ),
            const SizedBox(width: 4,),
            Expanded(
              flex: 40,
              child: TextFormField(
                inputFormatters: [maskQuiT],
                decoration: const InputDecoration(
                  labelText: 'Fecha as:',
                  isDense: true,
                ),
                keyboardType: TextInputType.number,
              ),
            ),
            CustomIconButton(
              iconData: Icons.backspace,
              color: Colors.red,
            ),
          ],
        ),
        Row(
          children: <Widget>[
            Expanded(
              flex: 30,
              child: Text('Sexta'),
            ),
            const SizedBox(width: 4,),
            Expanded(
              flex: 30,
              child: TextFormField(
                inputFormatters: [maskSexF],
                decoration: const InputDecoration(
                  labelText: 'Abre as:',
                  isDense: true,
                ),
                keyboardType: TextInputType.number,
              ),
            ),
            const SizedBox(width: 4,),
            Expanded(
              flex: 40,
              child: TextFormField(
                inputFormatters: [maskSexT],
                decoration: const InputDecoration(
                  labelText: 'Fecha as:',
                  isDense: true,
                ),
                keyboardType: TextInputType.number,
              ),
            ),
            CustomIconButton(
              iconData: Icons.backspace,
              color: Colors.red,
            ),
          ],
        ),
        Row(
          children: <Widget>[
            Expanded(
              flex: 30,
              child: Text('Sábado'),
            ),
            const SizedBox(width: 4,),
            Expanded(
              flex: 30,
              child: TextFormField(
                inputFormatters: [maskSabF],
                decoration: const InputDecoration(
                  labelText: 'Abre as:',
                  isDense: true,
                ),
                keyboardType: TextInputType.number,
              ),
            ),
            const SizedBox(width: 4,),
            Expanded(
              flex: 40,
              child: TextFormField(
                inputFormatters: [maskSabT],
                decoration: const InputDecoration(
                  labelText: 'Fecha as:',
                  isDense: true,
                ),
                keyboardType: TextInputType.number,
              ),
            ),
            CustomIconButton(
              iconData: Icons.backspace,
              color: Colors.red,
            ),
          ],
        ),
        Row(
          children: <Widget>[
            Expanded(
              flex: 30,
              child: Text('Domingo'),
            ),
            const SizedBox(width: 4,),
            Expanded(
              flex: 30,
              child: TextFormField(
                inputFormatters: [maskDomF],
                decoration: const InputDecoration(
                  labelText: 'Abre as:',
                  isDense: true,
                ),
                keyboardType: TextInputType.number,
              ),
            ),
            const SizedBox(width: 4,),
            Expanded(
              flex: 40,
              child: TextFormField(
                inputFormatters: [maskDomT],
                decoration: const InputDecoration(
                  labelText: 'Fecha as:',
                  isDense: true,
                ),
                keyboardType: TextInputType.number,
              ),
            ),
            CustomIconButton(
              iconData: Icons.backspace,
              color: Colors.red,
            ),
          ],
        ),
      ],
    ): Column(
      children: [
        Row(
          children: <Widget>[
            Expanded(
              flex: 30,
              child: Text('Segunda'),
            ),
            const SizedBox(width: 4,),
            Expanded(
              flex: 30,
              child: TextFormField(
                initialValue:store.opening['monday'] != null? store.opening['monday']['from'].format(context).toString():null,
                inputFormatters: [maskSegF],
                decoration: const InputDecoration(
                  labelText: 'Abre as:',
                  isDense: true,
                ),
                keyboardType: TextInputType.number,
              ),
            ),
            const SizedBox(width: 4,),
            Expanded(
              flex: 40,
              child: TextFormField(
                initialValue:store.opening['monday'] != null? store.opening['monday']['to'].format(context).toString():null,
                inputFormatters: [maskSegT],
                decoration: const InputDecoration(
                    labelText: 'Fecha as:',
                    isDense: true,
                ),
                keyboardType: TextInputType.number,
              ),
            ),
            CustomIconButton(
              iconData: Icons.backspace,
              color: Colors.red,
            ),
          ],
        ),
        Row(
          children: <Widget>[
            Expanded(
              flex: 30,
              child: Text('Terça'),
            ),
            const SizedBox(width: 4,),
            Expanded(
              flex: 30,
              child: TextFormField(
                initialValue:store.opening['tuesday'] != null? store.opening['tuesday']['from'].format(context).toString():null,
                inputFormatters: [maskTerF],
                decoration: const InputDecoration(
                  labelText: 'Abre as:',
                  isDense: true,
                ),
                keyboardType: TextInputType.number,
              ),
            ),
            const SizedBox(width: 4,),
            Expanded(
              flex: 40,
              child: TextFormField(
                initialValue:store.opening['tuesday'] != null? store.opening['tuesday']['to'].format(context).toString():null,
                inputFormatters: [maskTerT],
                decoration: const InputDecoration(
                  labelText: 'Fecha as:',
                  isDense: true,
                ),
                keyboardType: TextInputType.number,
              ),
            ),
            CustomIconButton(
              iconData: Icons.backspace,
              color: Colors.red,
            ),
          ],
        ),
        Row(
          children: <Widget>[
            Expanded(
              flex: 30,
              child: Text('Quarta'),
            ),
            const SizedBox(width: 4,),
            Expanded(
              flex: 30,
              child: TextFormField(
                initialValue:store.opening['wednesday'] != null? store.opening['wednesday']['from'].format(context).toString():null,
                inputFormatters: [maskQuaF],
                decoration: const InputDecoration(
                  labelText: 'Abre as:',
                  isDense: true,
                ),
                keyboardType: TextInputType.number,
              ),
            ),
            const SizedBox(width: 4,),
            Expanded(
              flex: 40,
              child: TextFormField(
                initialValue:store.opening['wednesday'] != null? store.opening['wednesday']['to'].format(context).toString():null,
                inputFormatters: [maskQuaT],
                decoration: const InputDecoration(
                  labelText: 'Fecha as:',
                  isDense: true,
                ),
                keyboardType: TextInputType.number,
              ),
            ),
            CustomIconButton(
              iconData: Icons.backspace,
              color: Colors.red,
            ),
          ],
        ),
        Row(
          children: <Widget>[
            Expanded(
              flex: 30,
              child: Text('Quinta'),
            ),
            const SizedBox(width: 4,),
            Expanded(
              flex: 30,
              child: TextFormField(
                initialValue:store.opening['thursday'] != null? store.opening['thursday']['from'].format(context).toString():null,
                inputFormatters: [maskQuiF],
                decoration: const InputDecoration(
                  labelText: 'Abre as:',
                  isDense: true,
                ),
                keyboardType: TextInputType.number,
              ),
            ),
            const SizedBox(width: 4,),
            Expanded(
              flex: 40,
              child: TextFormField(
                initialValue:store.opening['thursday'] != null? store.opening['thursday']['to'].format(context).toString():null,
                inputFormatters: [maskQuiT],
                decoration: const InputDecoration(
                  labelText: 'Fecha as:',
                  isDense: true,
                ),
                keyboardType: TextInputType.number,
              ),
            ),
            CustomIconButton(
              iconData: Icons.backspace,
              color: Colors.red,
            ),
          ],
        ),
        Row(
          children: <Widget>[
            Expanded(
              flex: 30,
              child: Text('Sexta'),
            ),
            const SizedBox(width: 4,),
            Expanded(
              flex: 30,
              child: TextFormField(
                initialValue:store.opening['friday'] != null? store.opening['friday']['from'].format(context).toString():null,
                inputFormatters: [maskSexF],
                decoration: const InputDecoration(
                  labelText: 'Abre as:',
                  isDense: true,
                ),
                keyboardType: TextInputType.number,
              ),
            ),
            const SizedBox(width: 4,),
            Expanded(
              flex: 40,
              child: TextFormField(
                initialValue:store.opening['friday'] != null? store.opening['friday']['to'].format(context).toString():null,
                inputFormatters: [maskSexT],
                decoration: const InputDecoration(
                  labelText: 'Fecha as:',
                  isDense: true,
                ),
                keyboardType: TextInputType.number,
              ),
            ),
            CustomIconButton(
              iconData: Icons.backspace,
              color: Colors.red,
            ),
          ],
        ),
        Row(
          children: <Widget>[
            Expanded(
              flex: 30,
              child: Text('Sábado'),
            ),
            const SizedBox(width: 4,),
            Expanded(
              flex: 30,
              child: TextFormField(
                initialValue:store.opening['saturday'] != null? store.opening['saturday']['from'].format(context).toString(): null,
                inputFormatters: [maskSabF],
                decoration: const InputDecoration(
                  labelText: 'Abre as:',
                  isDense: true,
                ),
                keyboardType: TextInputType.number,
              ),
            ),
            const SizedBox(width: 4,),
            Expanded(
              flex: 40,
              child: TextFormField(
                initialValue:store.opening['saturday'] != null? store.opening['saturday']['to'].format(context).toString(): '',
                inputFormatters: [maskSabT],
                decoration: const InputDecoration(
                  labelText: 'Fecha as:',
                  isDense: true,
                ),
                keyboardType: TextInputType.number,
              ),
            ),
            CustomIconButton(
              iconData: Icons.backspace,
              color: Colors.red,
            ),
          ],
        ),
        Row(
          children: <Widget>[
            Expanded(
              flex: 30,
              child: Text('Domingo'),
            ),
            const SizedBox(width: 4,),
            Expanded(
              flex: 30,
              child: TextFormField(
                initialValue:store.opening['sunday'] != null? store.opening['sunday']['from'].format(context).toString() : null,
                inputFormatters: [maskDomF],
                decoration: const InputDecoration(
                  labelText: 'Abre as:',
                  isDense: true,
                ),
                keyboardType: TextInputType.number,
              ),
            ),
            const SizedBox(width: 4,),
            Expanded(
              flex: 40,
              child: TextFormField(
                initialValue: store.opening['sunday'] != null? store.opening['sunday']['to'].format(context).toString() : null,
                inputFormatters: [maskDomT],
                decoration: const InputDecoration(
                  labelText: 'Fecha as:',
                  isDense: true,
                ),
                keyboardType: TextInputType.number,
              ),
            ),
            CustomIconButton(
              iconData: Icons.backspace,
              color: Colors.red,
            ),
          ],
        ),
      ],
    );
  }
}