// lib/presentation/screen/homescreen.dart
import 'package:flutter/material.dart';
import 'package:tutandita/data/repository/tandarepo.dart';
import 'package:tutandita/data/model/tandamodel.dart';
import 'package:tutandita/presentation/screen/addtanda.dart';
import 'package:tutandita/presentation/screen/edittanda.dart';

class Homescreen extends StatelessWidget {
  final TandaRepository tandaRepository =
      TandaRepository(); // Instancia del repositorio

  Future<List<Tandamodel>> _fetchTandas() async {
    return await tandaRepository
        .fetchTandas(); // Usamos el repositorio para obtener las tandas
  }

  void _addtanda(BuildContext context) async {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => AddTanda()),
    );
  }

  void _editTanda(BuildContext context, Tandamodel tanda) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EditTandaScreen(tanda: tanda)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Tandamodel>>(
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

  Widget _buildCard(BuildContext context, Tandamodel tanda) {
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
                    tanda.alias,
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
                    'Organizador: ${tanda.usercreation}',
                    style: TextStyle(color: Colors.grey[400]),
                  ),
                  Spacer(),
                  Text(
                    'Participantes: ${tanda.members}',
                    style: TextStyle(color: Colors.grey[400]),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  Text(
                    'Monto: ${tanda.poolAmount}',
                    style: TextStyle(color: Colors.grey[400]),
                  ),
                  Spacer(),
                  Text(
                    'Periodo: ${tanda.period}',
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
