import 'package:flutter/material.dart';
import 'package:tutandita/domain/entities/user.dart';
import 'package:tutandita/data/repository/loginrepo.dart';
import 'homescreen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _login() async {
    final user = User(
      email: _usernameController.text,
      password: _passwordController.text,
    );
    final loginRepository = Loginrepo();
    bool result = await loginRepository.execute(user);
    if (result) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Login exitoso')));
      //
      //  Navegamos a la siguiente pantalla
      //
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Homescreen()),
      );
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Login fallido')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Fondo con la división diagonal
          Positioned.fill(child: CustomPaint(painter: DiagonalPainter())),

          // Contenido de la pantalla: login, campos de texto y botón
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                SizedBox(height: 35),
                Text(
                  'TuTandita',
                  style: TextStyle(fontSize: 30, fontFamily: 'OpenSans'),
                ),
                SizedBox(
                  height: 120,
                  width: double.infinity,
                  child: Container(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 120,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.asset(
                              'lib/presentation/assets/logo.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Campos de texto para el usuario y la contraseña
                TextField(
                  controller: _usernameController,
                  decoration: InputDecoration(labelText: 'Usuario'),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(labelText: 'Contraseña'),
                ),
                SizedBox(height: 30),
                SizedBox(
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(onPressed: _login, child: Text('Login')),
                      SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: _login,
                        child: Text('Registrarse'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class DiagonalPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()..style = PaintingStyle.fill;

    // Pintar la parte superior (color superior)
    paint.color = Colors.green; // Color de la parte superior
    Path path = Path();
    path.lineTo(0, 0);
    path.lineTo(size.width, 0); // Línea hasta la parte superior derecha
    path.lineTo(size.width, size.height / 2); // Hasta la mitad de la pantalla
    path.close();
    canvas.drawPath(path, paint);

    // Pintar la parte inferior (color inferior)
    paint.color = Colors.white30; // Color de la parte inferior
    path = Path();
    path.moveTo(0, size.height / 2); // Comienza desde la mitad inferior
    path.lineTo(
      size.width,
      0,
    ); // Línea diagonal hasta la parte superior derecha
    path.lineTo(size.width, size.height); // Llega hasta el final de la pantalla
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
