import 'package:flutter/material.dart';

class addtanda extends StatelessWidget {
  const addtanda({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text('Agregar Tanda'),
          SizedBox(height: 20),
          TextField(
            decoration: InputDecoration(
              labelText: 'Nombre de la tanda',
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 20),
          TextField(
            decoration: InputDecoration(
              labelText: 'Nombre del organizador',
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 20),
          TextField(
            decoration: InputDecoration(
              labelText: 'Número de participantes',
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 20),
          TextField(
            decoration: InputDecoration(
              labelText: 'Monto de la tanda',
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 20),
          TextField(
            decoration: InputDecoration(
              labelText: 'Frecuencia de la tanda',
              border: OutlineInputBorder(),
            ),
          ),
        ],
      ),
    );
  }
}
