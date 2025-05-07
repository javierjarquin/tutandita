import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tutandita/data/model/tandausuariomodel.dart';

class TandaUsuarioRepository {
  //final String _baseUrl = 'api/tandas/user/'; // Cambia por la URL de tu API
  final String _baseUrl = 'http://localhost:8081/tandaUsuarios/';
  // Obtener las tandas desde la API
  Future<List<TandaUsuarioModel>> fetchTandas() async {
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
        return data.map((json) => TandaUsuarioModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load tandas');
      }
    } catch (e) {
      throw Exception('Failed to load tandas: $e');
    }
  }

  // Crear una nueva tandausuario
  Future<bool> createTandaUsuario(TandaUsuarioModel tanda) async {
    try {
      final response = await http.post(
        Uri.parse(_baseUrl),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(tanda.toJson()),
      );

      if (response.statusCode == 201) {
        return true; // Tandausuario creada exitosamente
      } else {
        return false; // Error al crear la tandausuario
      }
    } catch (e) {
      throw Exception('Failed to create tandausuario: $e');
    }
  }

  Future<List<TandaUsuarioModel>> fetchTandaUsuarioByTandaId(int id) async {
    try {
      final response = await http.get(Uri.parse(_baseUrl + id.toString()));

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response.body);
        final List<TandaUsuarioModel> data =
            jsonList.map((json) => TandaUsuarioModel.fromJson(json)).toList();
        return data;
      } else {
        throw Exception('Failed to load tandausuario');
      }
    } catch (e) {
      throw Exception('Failed to load tandausuario: $e');
    }
  }
}
