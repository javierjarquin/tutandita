import 'package:flutter/material.dart';

class NombreField extends StatelessWidget {
  final TextEditingController controller;
  const NombreField({required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: const InputDecoration(
        labelText: 'Nombre de la tanda',
        border: OutlineInputBorder(),
      ),
      validator: (v) => v == null || v.isEmpty ? 'Ingresa un nombre' : null,
    );
  }
}

class FechaInicioField extends StatelessWidget {
  final TextEditingController controller;
  final Function(DateTime) onDateSelected;

  const FechaInicioField({
    required this.controller,
    required this.onDateSelected,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      readOnly: true,
      onTap: () async {
        final pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2100),
        );
        if (pickedDate != null) onDateSelected(pickedDate);
      },
      decoration: const InputDecoration(
        labelText: 'Fecha de inicio',
        border: OutlineInputBorder(),
      ),
    );
  }
}

class ParticipantesField extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onAddPressed;

  const ParticipantesField({
    required this.controller,
    required this.onAddPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            controller: controller,
            decoration: const InputDecoration(
              labelText: 'Participantes',
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.number,
            validator:
                (v) =>
                    v == null || int.tryParse(v) == null
                        ? 'Número válido requerido'
                        : null,
          ),
        ),
        const SizedBox(width: 10),
        FloatingActionButton(
          onPressed: onAddPressed,
          child: const Icon(Icons.add),
          backgroundColor: Colors.deepPurple,
          shape: const CircleBorder(),
        ),
      ],
    );
  }
}

class MontoField extends StatelessWidget {
  final TextEditingController controller;
  const MontoField({required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: const InputDecoration(
        labelText: 'Monto',
        border: OutlineInputBorder(),
      ),
      keyboardType: TextInputType.number,
      validator:
          (v) =>
              v == null || double.tryParse(v) == null ? 'Monto inválido' : null,
    );
  }
}

class FrecuenciaDropdown extends StatelessWidget {
  final String? value;
  final Function(String?) onChanged;

  const FrecuenciaDropdown({required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      decoration: const InputDecoration(
        labelText: 'Frecuencia',
        border: OutlineInputBorder(),
      ),
      value: value,
      items: const [
        DropdownMenuItem(value: 'SL', child: Text('Semanal')),
        DropdownMenuItem(value: 'QL', child: Text('Quincenal')),
        DropdownMenuItem(value: 'ML', child: Text('Mensual')),
        DropdownMenuItem(value: 'BL', child: Text('Bimestral')),
        DropdownMenuItem(value: 'TL', child: Text('Trimestral')),
      ],
      onChanged: onChanged,
      validator:
          (v) => v == null || v.isEmpty ? 'Selecciona una frecuencia' : null,
    );
  }
}
