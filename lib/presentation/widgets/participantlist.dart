import 'package:flutter/material.dart';
import 'package:tutandita/data/model/tandausuariomodel.dart';

class ParticipantList extends StatelessWidget {
  final List<TandaUsuarioModel> participants;
  final void Function(int) onEdit;
  final void Function(int) onDelete;

  const ParticipantList({
    required this.participants,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: participants.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (_, i) {
        final p = participants[i];
        return ListTile(
          title: Text(p.name ?? 'Sin nombre'),
          subtitle: Text("Tel: ${p.phone} - Número: ${p.numberTicket}"),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () => onEdit(i),
              ),
              IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () => onDelete(i),
              ),
            ],
          ),
        );
      },
    );
  }
}
