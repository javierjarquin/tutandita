import 'package:flutter/material.dart';
import 'package:tutandita/presentation/widgets/edittandaform.dart';
import '../../../data/model/tandamodel.dart';

class EditTandaScreen extends StatelessWidget {
  final Tandamodel tanda;

  const EditTandaScreen({Key? key, required this.tanda}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Editar Tanda',
          style: TextStyle(fontSize: 30, fontFamily: 'OpenSans'),
        ),
      ),
      body: EditTandaForm(tanda: tanda),
    );
  }
}
