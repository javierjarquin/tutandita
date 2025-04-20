import 'package:flutter/material.dart';
import 'package:tutandita/presentation/screen/homescreen.dart';
import 'package:tutandita/data/model/tandamodel.dart';

class EditTandaScreen extends StatefulWidget {
  final Tandamodel tanda;
  EditTandaScreen({required this.tanda});

  @override
  _EditTandaScreenState createState() => _EditTandaScreenState();
}

class _EditTandaScreenState extends State<EditTandaScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nombreTandaController = TextEditingController();
  final _startDateController = TextEditingController();
  final _participantesController = TextEditingController();
  final _montoController = TextEditingController();
  DateTime? _selectedStartDate;

  String? _frecuencia = 'Semanal'; // Valor por defecto
  bool _isSaving = false;

  List<Map<String, String>> _participants = [];

  @override
  void initState() {
    super.initState();

    final tanda = widget.tanda;

    _nombreTandaController.text = tanda.alias;
    _montoController.text = tanda.poolAmount.toString();
    _participantesController.text = tanda.members.toString();
    _frecuencia =
        "${tanda.period[0]}${tanda.period[tanda.period.length - 1]}"
            .toUpperCase();

    // Si ya hay fecha, formatearla en yyyy-MM-dd para el date picker
    if (tanda.startDate != null) {
      final date = tanda.startDate;
      _selectedStartDate = date;
      _startDateController.text =
          "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
    }

    // Aquí puedes cargar participantes si el modelo los tiene
    // Por ejemplo:
    // _participants = tanda.participants.map((p) => {
    //   'name': p.name,
    //   'phone': p.phone,
    //   'unassignedNumber': p.unassignedNumber.toString(),
    // }).toList();
  }

  Future<void> _savetanda(BuildContext context) async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isSaving = true;
    });

    final success = await saveTanda();

    setState(() {
      _isSaving = false;
    });

    if (success) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Homescreen()),
      );
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error al guardar la tanda')));
    }
  }

  Future<bool> saveTanda() async {
    await Future.delayed(Duration(seconds: 2));
    return true;
  }

  Future<void> _deleteParticipant(int index) async {
    // Aquí puedes conectar con tu API para eliminar el participante
    setState(() {
      _participants.removeAt(index);
    });
  }

  Future<void> _modifyParticipant(int index) async {
    final participant = _participants[index];
    final _nameController = TextEditingController(text: participant['name']);
    final _phoneController = TextEditingController(text: participant['phone']);
    final _unassignedNumberController = TextEditingController(
      text: participant['unassignedNumber'],
    );

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Modificar Participante'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Nombre'),
              ),
              TextField(
                controller: _phoneController,
                decoration: InputDecoration(labelText: 'Número de Teléfono'),
                keyboardType: TextInputType.phone,
              ),
              TextField(
                controller: _unassignedNumberController,
                decoration: InputDecoration(labelText: 'Número sin asignar'),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _participants[index] = {
                    'name': _nameController.text,
                    'phone': _phoneController.text,
                    'unassignedNumber': _unassignedNumberController.text,
                  };
                });
                Navigator.of(context).pop();
              },
              child: Text('Guardar'),
            ),
          ],
        );
      },
    );
  }

  void _showAddParticipantModal(BuildContext context) {
    final _nameController = TextEditingController();
    final _phoneController = TextEditingController();
    final _unassignedNumberController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Agregar Participante'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Nombre'),
              ),
              TextField(
                controller: _phoneController,
                decoration: InputDecoration(labelText: 'Número de Teléfono'),
                keyboardType: TextInputType.phone,
              ),
              TextField(
                controller: _unassignedNumberController,
                decoration: InputDecoration(labelText: 'Número sin asignar'),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _participants.add({
                    'name':
                        _nameController.text.isEmpty
                            ? 'Nombre Fake'
                            : _nameController.text,
                    'phone':
                        _phoneController.text.isEmpty
                            ? '123456789'
                            : _phoneController.text,
                    'unassignedNumber':
                        _unassignedNumberController.text.isEmpty
                            ? '0'
                            : _unassignedNumberController.text,
                  });
                });
                Navigator.of(context).pop();
              },
              child: Text('Agregar'),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _nombreTandaController.dispose();
    _startDateController.dispose();
    _participantesController.dispose();
    _montoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Editar Tanda',
          style: TextStyle(fontSize: 30, fontFamily: 'OpenSans'),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                TextFormField(
                  controller: _nombreTandaController,
                  decoration: InputDecoration(
                    labelText: 'Nombre de la tanda',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingresa el nombre de la tanda';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                TextFormField(
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

                SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _participantesController,
                        decoration: InputDecoration(
                          labelText: 'Número de participantes',
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor ingresa el número de participantes';
                          }
                          if (int.tryParse(value) == null) {
                            return 'Debe ser un número válido';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(width: 10),
                    FloatingActionButton(
                      onPressed: () => _showAddParticipantModal(context),
                      backgroundColor: Colors.deepPurple,
                      shape: CircleBorder(),
                      child: Icon(Icons.add, color: Colors.white),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _montoController,
                        decoration: InputDecoration(
                          labelText: 'Monto de la tanda',
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor ingresa el monto de la tanda';
                          }
                          if (double.tryParse(value) == null) {
                            return 'Debe ser un monto válido';
                          }
                          return null;
                        },
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
                  value: _frecuencia,
                  items: [
                    DropdownMenuItem(value: 'SL', child: Text('Semanal')),
                    DropdownMenuItem(value: 'QL', child: Text('Quincena')),
                    DropdownMenuItem(value: 'ML', child: Text('Mensual')),
                    DropdownMenuItem(value: 'BL', child: Text('Bimestral')),
                    DropdownMenuItem(value: 'TL', child: Text('Trimestral')),
                  ],
                  onChanged: (value) {
                    setState(() {
                      _frecuencia = value;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor selecciona una frecuencia';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _isSaving ? null : () => _savetanda(context),
                    child:
                        _isSaving
                            ? CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(
                                Colors.white,
                              ),
                            )
                            : Text('Guardar'),
                  ),
                ),
                SizedBox(height: 20),
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: _participants.length,
                  itemBuilder: (context, index) {
                    final participant = _participants[index];
                    return ListTile(
                      title: Text(participant['name'] ?? 'Sin nombre'),
                      subtitle: Text(
                        'Tel: ${participant['phone']}, Número: ${participant['unassignedNumber']}',
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () => _modifyParticipant(index),
                          ),
                          IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () => _deleteParticipant(index),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
