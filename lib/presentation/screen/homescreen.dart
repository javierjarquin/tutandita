import 'package:flutter/material.dart';
import 'package:tutandita/presentation/screen/addtanda.dart';

class Homescreen extends StatelessWidget {
  void _addtanda(BuildContext context) async {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => addtanda()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
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
              _buildCard(
                context,
                'Tanda 1',
                'Doña pelos',
                '11',
                '1000',
                'Semanal',
              ),
              SizedBox(height: 20),
              _buildCard(
                context,
                'Tanda 2',
                'Doña pelos',
                '11',
                '1000',
                'Semanal',
              ),
              SizedBox(height: 20),
              _buildCard(
                context,
                'Tanda 3',
                'Doña pelos',
                '11',
                '1000',
                'Semanal',
              ),
            ],
          ),
        ),
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

  Widget _buildCard(
    BuildContext context,
    String title,
    String usermanager,
    String participants,
    String amount,
    String period,
  ) {
    return Card(
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
                  title,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Spacer(),
                Text('Estatus: Activa', style: TextStyle(color: Colors.green)),
              ],
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Text(
                  'Organizador: $usermanager',
                  style: TextStyle(color: Colors.grey[400]),
                ),
                Spacer(),
                Text(
                  'Participantes: $participants',
                  style: TextStyle(color: Colors.grey[400]),
                ),
              ],
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Text(
                  'Monto: $amount',
                  style: TextStyle(color: Colors.grey[400]),
                ),
                Spacer(),
                Text(
                  'Periodo: $period',
                  style: TextStyle(color: Colors.grey[400]),
                ),
              ],
            ),
            SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}
