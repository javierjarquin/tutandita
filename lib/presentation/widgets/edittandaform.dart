import 'package:flutter/material.dart';
import 'package:tutandita/presentation/screen/homescreen.dart';
import '../../../../data/model/tandamodel.dart';
import 'formfield.dart';
import 'package:tutandita/data/model/tandausuariomodel.dart';
import 'package:tutandita/data/repository/tandausuariorepo.dart';
import 'participantlist.dart';
import 'participantformdialog.dart';

class EditTandaForm extends StatefulWidget {
  final Tandamodel tanda;

  const EditTandaForm({Key? key, required this.tanda}) : super(key: key);

  @override
  State<EditTandaForm> createState() => _EditTandaFormState();
}

class _EditTandaFormState extends State<EditTandaForm> {
  final _formKey = GlobalKey<FormState>();
  final _nombreController = TextEditingController();
  final _startDateController = TextEditingController();
  final _participantesController = TextEditingController();
  final _montoController = TextEditingController();

  DateTime? _selectedStartDate;
  String? _frecuencia = 'SL';
  bool _isSaving = false;

  List<TandaUsuarioModel> _participants = [];

  Future<void> _loadParticipants(int tandaId) async {
    try {
      final repo = TandaUsuarioRepository();
      final loaded = await repo.fetchTandaUsuarioByTandaId(tandaId);
      setState(() {
        _participants = loaded;
      });
    } catch (e) {
      print('Error cargando participantes: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    final t = widget.tanda;
    _nombreController.text = t.alias;
    _montoController.text = t.poolAmount.toString();
    _participantesController.text = t.members.toString();
    _frecuencia = t.period.substring(0, 1).toUpperCase() + 'L';
    if (t.startDate != null) {
      _startDateController.text =
          "${t.startDate!.year}-${t.startDate!.month.toString().padLeft(2, '0')}-${t.startDate!.day.toString().padLeft(2, '0')}";
    }

    _loadParticipants(t.id); // <-- AÑADIR ESTO
  }

  Future<void> _saveTanda() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isSaving = true);
    await Future.delayed(const Duration(seconds: 2));
    setState(() => _isSaving = false);

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => Homescreen()),
    );
  }

  void _addParticipant() async {
    final result = await showParticipantDialog(context);
    if (result != null) {
      if (result is TandaUsuarioModel) {
        setState(() => _participants.add(result));
      }
    }
  }

  void _modifyParticipant(int index) async {
    final result = await showParticipantDialog(
      context,
      initialData: _participants[index],
    );
    if (result != null) {
      setState(() => _participants[index] = result);
    }
  }

  void _deleteParticipant(int index) {
    setState(() => _participants.removeAt(index));
  }

  @override
  void dispose() {
    _nombreController.dispose();
    _startDateController.dispose();
    _participantesController.dispose();
    _montoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(25),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            NombreField(controller: _nombreController),
            const SizedBox(height: 20),
            FechaInicioField(
              controller: _startDateController,
              onDateSelected: (date) {
                setState(() {
                  _selectedStartDate = date;
                  _startDateController.text =
                      "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
                });
              },
            ),
            const SizedBox(height: 20),
            ParticipantesField(
              controller: _participantesController,
              onAddPressed: _addParticipant,
            ),
            const SizedBox(height: 20),
            MontoField(controller: _montoController),
            const SizedBox(height: 20),
            FrecuenciaDropdown(
              value: _frecuencia,
              onChanged: (value) {
                setState(() => _frecuencia = value);
              },
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _isSaving ? null : _saveTanda,
                child:
                    _isSaving
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text('Guardar'),
              ),
            ),
            const SizedBox(height: 20),
            ParticipantList(
              participants: _participants,
              onEdit: _modifyParticipant,
              onDelete: _deleteParticipant,
            ),
          ],
        ),
      ),
    );
  }
}
