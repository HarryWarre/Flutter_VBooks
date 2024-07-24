import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  final String baseUrl = 'http://192.168.0.104:5000'; // Điều chỉnh URL tại đây

  Future<http.Response> get(String endpoint) async {
    print('$baseUrl/$endpoint');
    final response = await http.get(Uri.parse('$baseUrl/$endpoint'));
    // print(response.body);
    return response;
  }

  Future<http.Response> post(String endpoint, Map<String, dynamic> data) async {
    print('$baseUrl/$endpoint');
    final response = await http.post(
      Uri.parse('$baseUrl/$endpoint'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(data),
    );
    return response;
  }

  Future<http.Response> put(String endpoint, Map<String, dynamic> data) async {
    final response = await http.put(
      Uri.parse('$baseUrl/$endpoint'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(data),
    );
    return response;
  }
}
