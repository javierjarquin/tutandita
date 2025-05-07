import 'package:flutter/material.dart';
import 'package:tutandita/data/model/tandausuariomodel.dart';

Future<TandaUsuarioModel?> showParticipantDialog(
  BuildContext context, {
  TandaUsuarioModel? initialData,
}) {
  final _name = TextEditingController(
    text: initialData != null ? initialData.name : '',
  );
  final _phone = TextEditingController(
    text: initialData != null ? initialData.phone : '',
  );
  final _number = TextEditingController(
    text: initialData != null ? initialData.numberTicket.toString() : '',
  );

  return showDialog<TandaUsuarioModel>(
    context: context,
    builder:
        (_) => AlertDialog(
          title: Text(
            initialData == null
                ? 'Agregar Participante'
                : 'Modificar Participante',
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _name,
                decoration: const InputDecoration(labelText: 'Nombre'),
              ),
              TextField(
                controller: _phone,
                decoration: const InputDecoration(labelText: 'Teléfono'),
              ),
              TextField(
                controller: _number,
                decoration: const InputDecoration(labelText: 'Número'),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, {
                  'name': _name.text,
                  'phone': _phone.text,
                  'unassignedNumber': _number.text,
                });
              },
              child: const Text('Guardar'),
            ),
          ],
        ),
  );
}
