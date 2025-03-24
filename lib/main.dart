import 'package:flutter/material.dart';
import 'package:tutandita/presentation/screen/loginscreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login App',
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.blueGrey,
        brightness: Brightness.dark,
      ),
      home: LoginScreen(),
    );
  }
}
