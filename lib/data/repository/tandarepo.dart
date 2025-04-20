import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tutandita/data/model/tandamodel.dart';

class TandaRepository {
  //final String _baseUrl = 'api/tandas/user/'; // Cambia por la URL de tu API
  final String _baseUrl = 'http://localhost:8081/tandas/user/';

  final String _createTandaUrl = 'http://localhost:8081/tandas/';
  // Cambia por la URL de tu API

  // Obtener las tandas desde la API
  Future<List<Tandamodel>> fetchTandas() async {
    try {
      final ses = await SharedPreferences.getInstance();
      final userId = ses.getInt('userId');
      if (userId == null) {
        throw Exception('User ID not found in SharedPreferences');
      }
      final response = await http.get(Uri.parse(_baseUrl + userId.toString()));

      if (response.statusCode == 200) {
        // Si la respuesta es exitosa, parsea el JSON
        List<dynamic> data = json.decode(response.body);
        return data.map((json) => Tandamodel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load tandas');
      }
    } catch (e) {
      throw Exception('Failed to load tandas: $e');
    }
  }

  // Crear una nueva tanda
  Future<bool> createTanda(Tandamodel tanda) async {
    try {
      final response = await http.post(
        Uri.parse(_createTandaUrl),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(tanda.toJson()),
      );

      if (response.statusCode == 201) {
        return true; // Tanda creada exitosamente
      } else {
        return false; // Error al crear la tanda
      }
    } catch (e) {
      throw Exception('Failed to create tanda: $e');
    }
  }

  // Editar una tanda
  Future<bool> editTanda(Tandamodel tanda) async {
    try {
      final response = await http.put(
        Uri.parse(_createTandaUrl + tanda.id.toString()),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(tanda.toJson()),
      );

      if (response.statusCode == 200) {
        return true; // Tanda editada exitosamente
      } else {
        return false; // Error al editar la tanda
      }
    } catch (e) {
      throw Exception('Failed to edit tanda: $e');
    }
  }
}
