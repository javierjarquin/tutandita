import 'package:flutter/material.dart';
import 'package:tutandita/presentation/screen/addtanda.dart';
import 'package:tutandita/presentation/screen/edittanda.dart'; // Importa la pantalla de edición

class Homescreen extends StatelessWidget {
  Future<List<Map<String, String>>> _fetchTandas() async {
    // Hardcoded examples
    await Future.delayed(Duration(seconds: 1)); // Simulate network delay
    return [
      {
        'title': 'Tanda 1',
        'usermanager': 'Juan Pérez',
        'participants': '10',
        'amount': '5000',
        'period': 'Mensual',
      },
      {
        'title': 'Tanda 2',
        'usermanager': 'María López',
        'participants': '8',
        'amount': '3000',
        'period': 'Quincenal',
      },
      {
        'title': 'Tanda 3',
        'usermanager': 'Carlos García',
        'participants': '12',
        'amount': '7000',
        'period': 'Semanal',
      },
    ];
  }

  void _addtanda(BuildContext context) async {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => addtanda()),
    );
  }

  void _editTanda(BuildContext context, Map<String, String> tanda) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EditTandaScreen(tanda: tanda)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Map<String, String>>>(
        future: _fetchTandas(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No tandas available'));
          } else {
            final tandas = snapshot.data!;
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text(
                      'Tandas',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'OpenSans',
                      ),
                    ),
                    SizedBox(height: 20),
                    ...tandas.map(
                      (tanda) => Padding(
                        padding: const EdgeInsets.only(bottom: 20.0),
                        child: _buildCard(context, tanda),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addtanda(context),
        backgroundColor: Colors.deepPurple,
        shape: CircleBorder(),
        child: Icon(Icons.add, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 8.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(icon: Icon(Icons.home), onPressed: () {}),
            SizedBox(width: 40),
            IconButton(icon: Icon(Icons.settings), onPressed: () {}),
          ],
        ),
      ),
    );
  }

  Widget _buildCard(BuildContext context, Map<String, String> tanda) {
    return GestureDetector(
      onTap: () => _editTanda(context, tanda),
      child: Card(
        color: const Color.fromARGB(255, 37, 36, 36),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    tanda['title']!,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Spacer(),
                  Text(
                    'Estatus: Activa',
                    style: TextStyle(color: Colors.green),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  Text(
                    'Organizador: ${tanda['usermanager']}',
                    style: TextStyle(color: Colors.grey[400]),
                  ),
                  Spacer(),
                  Text(
                    'Participantes: ${tanda['participants']}',
                    style: TextStyle(color: Colors.grey[400]),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  Text(
                    'Monto: ${tanda['amount']}',
                    style: TextStyle(color: Colors.grey[400]),
                  ),
                  Spacer(),
                  Text(
                    'Periodo: ${tanda['period']}',
                    style: TextStyle(color: Colors.grey[400]),
                  ),
                ],
              ),
              SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }
}
