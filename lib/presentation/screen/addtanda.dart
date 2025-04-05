import 'package:flutter/material.dart';
import 'package:tutandita/presentation/screen/homescreen.dart';

class addtanda extends StatelessWidget {
  const addtanda({super.key});

  void _savetanda(BuildContext context) async {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => Homescreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text(
            'Agregar Tanda',
            style: TextStyle(fontSize: 30, fontFamily: 'OpenSans'),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              children: [
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
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          labelText: 'Número de participantes',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    SizedBox(width: 20),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          labelText: 'Monto de la tanda',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: 'Frecuencia de la tanda',
                    border: OutlineInputBorder(),
                  ),
                  items: [
                    DropdownMenuItem(value: 'Semanal', child: Text('Semanal')),
                    DropdownMenuItem(
                      value: 'Quincena',
                      child: Text('Quincena'),
                    ),
                    DropdownMenuItem(value: 'Mensual', child: Text('Mensual')),
                    DropdownMenuItem(
                      value: 'Bimestral',
                      child: Text('Bimestral'),
                    ),
                    DropdownMenuItem(
                      value: 'Trimestral',
                      child: Text('Trimestral'),
                    ),
                  ],
                  onChanged: (value) {
                    // Handle selection change
                  },
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () => _savetanda(context),
                  child: Text('Guardar'),
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }

  Future<bool> saveTanda() async {
    // Simulate API call
    await Future.delayed(Duration(seconds: 2));
    return true; // Return true if saved successfully, false otherwise
  }
}
