import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tutandita/data/model/tandausuariomodel.dart';

class TandaUsuarioRepository {
  //final String _baseUrl = 'api/tandas/user/'; // Cambia por la URL de tu API
  final String _baseUrl = 'http://localhost:8081/tandaUsuarios/';
  // Obtener las tandas desde la API
  Future<List<Tandausuariomodel>> fetchTandas() async {
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
        return data.map((json) => Tandausuariomodel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load tandas');
      }
    } catch (e) {
      throw Exception('Failed to load tandas: $e');
    }
  }
}
