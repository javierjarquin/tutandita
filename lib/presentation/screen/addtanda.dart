import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tutandita/presentation/screen/homescreen.dart';
import 'package:tutandita/data/model/tandamodel.dart';
import 'package:tutandita/data/repository/tandarepo.dart'; // Asegúrate de tener esto

class AddTanda extends StatefulWidget {
  const AddTanda({super.key});

  @override
  State<AddTanda> createState() => _AddTandaState();
}

class _AddTandaState extends State<AddTanda> {
  final TextEditingController _aliasController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _membersController = TextEditingController();
  final TextEditingController _startDateController = TextEditingController();
  DateTime? _selectedStartDate;

  String _selectedPeriod = 'SL'; // Valor por defecto

  void _saveTanda(BuildContext context) async {
    try {
      final ses = await SharedPreferences.getInstance();
      final userId = ses.getInt('userId');
      if (userId == null) {
        throw Exception('User ID not found in SharedPreferences');
      }

      final tanda = Tandamodel(
        id: 0,
        alias: _aliasController.text,
        poolAmount: double.parse(_amountController.text),
        period: _selectedPeriod,
        members: int.parse(_membersController.text),
        startDate:
            _startDateController.text.isNotEmpty
                ? DateTime.parse(_startDateController.text).toUtc()
                : DateTime.now().toUtc(),
        endDate: DateTime.now().toUtc(),
        totalEndPool: 0.0,
        creationUserId: userId,
        usercreation: 'User 1',
      );

      await TandaRepository().createTanda(
        tanda,
      ); // Asegúrate de tener este método

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Homescreen()),
      );
    } catch (e) {
      print('Error al guardar la tanda: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 40),
            const Text(
              'Agregar Tanda',
              style: TextStyle(fontSize: 30, fontFamily: 'OpenSans'),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: Column(
                children: [
                  TextField(
                    controller: _aliasController,
                    decoration: const InputDecoration(
                      labelText: 'Nombre de la tanda',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: _startDateController,
                    readOnly: true,
                    onTap: () async {
                      final pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100),
                      );

                      if (pickedDate != null) {
                        setState(() {
                          _selectedStartDate = pickedDate;
                          _startDateController.text =
                              "${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}";
                        });
                      }
                    },
                    decoration: const InputDecoration(
                      labelText: 'Fecha de inicio',
                      border: OutlineInputBorder(),
                    ),
                  ),

                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _membersController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            labelText: 'Número de participantes',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: TextField(
                          controller: _amountController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            labelText: 'Monto de la tanda',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  DropdownButtonFormField<String>(
                    decoration: const InputDecoration(
                      labelText: 'Frecuencia de la tanda',
                      border: OutlineInputBorder(),
                    ),
                    value: _selectedPeriod,
                    items: const [
                      DropdownMenuItem(value: 'SL', child: Text('Semanal')),
                      DropdownMenuItem(value: 'QL', child: Text('Quincenal')),
                      DropdownMenuItem(value: 'ML', child: Text('Mensual')),
                      DropdownMenuItem(value: 'BL', child: Text('Bimestral')),
                      DropdownMenuItem(value: 'TL', child: Text('Trimestral')),
                    ],
                    onChanged: (value) {
                      setState(() {
                        _selectedPeriod = value!;
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () => _saveTanda(context),
                    child: const Text('Guardar'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
