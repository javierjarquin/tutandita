import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:developer' as developer;
import 'package:tutandita/domain/entities/user.dart';
import 'package:tutandita/domain/usecases/login.dart';

class Loginrepo implements LoginUseCase {
  // final String apiUrl = '/api/users/login';
  final String apiUrl =
      'http://localhost:8081/users/login'; // Cambia por la URL de tu API
  final String logFilePath =
      "/home/javier/Documentos/workbench/tutandita/logs.txt";

  @override
  Future<bool> execute(User user) async {
    try {
      // Realizar la solicitud HTTP POST
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': user.email, 'pass': user.password}),
      );

      // Log de la respuesta para el monitoreo
      developer.log('Response: ${response.statusCode}, Body: ${response.body}');

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);

        // Aquí asumimos que el campo 'id' indica si la autenticación fue exitosa
        if (responseData['id'] != null) {
          final ses = await SharedPreferences.getInstance();
          await ses.setInt('id', responseData['id']);
          await ses.setInt('userId', responseData['userId']);

          return true; // Login exitoso
        } else {
          return false; // Login fallido, 'id' no presente
        }
      } else {
        return false; // Error en el servidor
      }
    } catch (e) {
      // Escribir en log si ocurre algún error
      await _writeLog('Error: $e\n');
      developer.log('Error: $e');
      return false;
    }
  }

  // Método para escribir logs en el archivo local
  Future<void> _writeLog(String logEntry) async {
    try {
      final logFile = File(logFilePath);
      await logFile.writeAsString(logEntry, mode: FileMode.append);
    } catch (e) {
      // Si el archivo no puede escribirse, se imprime en consola
      developer.log('Log failed: $logEntry');
    }
  }
}
