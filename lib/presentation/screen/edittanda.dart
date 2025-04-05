import 'package:flutter/material.dart';
import 'package:tutandita/presentation/screen/homescreen.dart';

class EditTandaScreen extends StatefulWidget {
  final Map<String, String> tanda;
  EditTandaScreen({required this.tanda});

  @override
  _EditTandaScreenState createState() => _EditTandaScreenState();
}

class _EditTandaScreenState extends State<EditTandaScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nombreTandaController = TextEditingController();
  final _organizadorController = TextEditingController();
  final _participantesController = TextEditingController();
  final _montoController = TextEditingController();
  String? _frecuencia;
  bool _isSaving = false;

  List<Map<String, String>> _participants = [];

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
    _organizadorController.dispose();
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
                  controller: _organizadorController,
                  decoration: InputDecoration(
                    labelText: 'Nombre del organizador',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingresa el nombre del organizador';
                    }
                    return null;
                  },
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
