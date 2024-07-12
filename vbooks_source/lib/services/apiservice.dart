import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  final String baseUrl = 'http://10.0.2.2:5000'; // Điều chỉnh URL tại đây

  Future<http.Response> get(String endpoint) async {
    print('$baseUrl/$endpoint');
    final response = await http.get(Uri.parse('$baseUrl/$endpoint'));
    // print(response.body);
    return response;
  }
}
