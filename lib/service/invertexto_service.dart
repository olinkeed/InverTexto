import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

class InvertextoApiService {
  final String _token = "28388|jiEAFXMAK8MzwzBPXYD3aZLXj3701udG";
  Future<Map<String, dynamic>> convertePorExtenso(String? valor) async {
    try {
      final uri = Uri.parse(
        "https://api.invertexto.com/v1/number-to-words"
        "?token=$_token&number=$valor"
        "&language=pt¤cy=BRL",
      );
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Erro ${response.statusCode}: ${response.body}');
      }
    } on SocketException {
      throw Exception('Erro de conexão com a internet');
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> buscaCEP(String? valor) async {
    try {
      final uri = Uri.parse(
        "https://api.invertexto.com/v1/cep/$valor"
        "?token=$_token",
      );
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Erro ${response.statusCode}: ${response.body}');
      }
    } on SocketException {
      throw Exception('Erro de conexão com a internet');
    } catch (e) {
      rethrow;
    }
  }

  // adicao
  Future<dynamic> buscaFeriados(String ano) async {
    final uri = Uri.parse(
      "https://api.invertexto.com/v1/holidays/$ano?token=$_token",
    );
    try {
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        return json.decode(response.body);
      }
      throw Exception('Erro ${response.statusCode}: ${response.body}');
    } on SocketException {
      throw Exception('Erro de conexão com a internet');
    }
  }

  // adicao
  Future<Map<String, dynamic>> buscaCnpj(String cnpj) async {
    final uri = Uri.https('api.invertexto.com', '/v1/cnpj/$cnpj', {
      'token': _token,
    });
    try {
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        return json.decode(response.body) as Map<String, dynamic>;
      }
      throw Exception('Erro ${response.statusCode}: ${response.body}');
    } on SocketException {
      throw Exception('Erro de conexão com a internet');
    }
  }

  // adicao
  Future<dynamic> validaEmail(String email) async {
    final uri = Uri.https('api.invertexto.com', '/v1/email-validator/$email', {
      'token': _token,
    });
    try {
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        return json.decode(response.body);
      }
      throw Exception('Erro ${response.statusCode}: ${response.body}');
    } on SocketException {
      throw Exception('Erro de conexão com a internet');
    }
  }
}
