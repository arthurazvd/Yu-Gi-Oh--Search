import 'dart:convert';
import 'package:http/http.dart' as http;
import '../card/card_model.dart';

class ApiService {
  static const String _baseUrl = 'https://db.ygoprodeck.com/api/v7/cardinfo.php'; // URL base da API

  // Método para buscar cartas com uma consulta opcional
  Future<List<CardModel>> fetchCards([String query = '']) async {
    final response = await http.get(Uri.parse('$_baseUrl?fname=$query')); // Faz a requisição GET com a consulta

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body)['data']; // Decodifica o JSON e extrai os dados
      return data.map((json) => CardModel.fromJson(json)).toList(); // Converte os dados para uma lista de CardModel
    } else {
      throw Exception('Failed to load cards'); // Lança uma exceção se a requisição falhar
    }
  }
}
