import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  final String baseUrl = 'http://192.168.0.104:5000';

  Future<http.Response> get(String endpoint) async {
    final url = '$baseUrl/$endpoint';
    print('GET request to: $url');
    final response = await http.get(Uri.parse(url));
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    return response;
  }

  Future<http.Response> post(String endpoint, Map<String, dynamic> data) async {
    final url = '$baseUrl/$endpoint';
    print('POST request to: $url');
    print('Request body: ${jsonEncode(data)}');
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(data),
      );
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      return response;
    } catch (e) {
      print('Error: $e');
      rethrow;
    }
  }

  Future<http.Response> put(String endpoint, Map<String, dynamic> data) async {
    final url = '$baseUrl/$endpoint';
    print('PUT request to: $url'); // In ra URL của yêu cầu PUT
    print('Request body: ${jsonEncode(data)}'); // In ra nội dung yêu cầu PUT
    final response = await http.put(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(data),
    );
    print(
        'Response status: ${response.statusCode}'); // In ra mã trạng thái của phản hồi
    print('Response body: ${response.body}'); // In ra nội dung của phản hồi
    return response;
  }

  Future<http.Response> patch(
      String endpoint, Map<String, dynamic> data) async {
    final url = '$baseUrl/$endpoint';
    print('PATCH request to: $url'); // In ra URL của yêu cầu PATCH
    print('Request body: ${jsonEncode(data)}'); // In ra nội dung yêu cầu PATCH
    final response = await http.patch(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(data),
    );
    print(
        'Response status: ${response.statusCode}'); // In ra mã trạng thái của phản hồi
    print('Response body: ${response.body}'); // In ra nội dung của phản hồi
    return response;
  }

  Future<http.Response> delete(String endpoint) async {
    final url = '$baseUrl/$endpoint';
    print('DELETE request to: $url'); // In ra URL của yêu cầu DELETE
    final response = await http.delete(Uri.parse(url));
    print(
        'Response status: ${response.statusCode}'); // In ra mã trạng thái của phản hồi
    print('Response body: ${response.body}'); // In ra nội dung của phản hồi
    return response;
  }

  Future<http.Response> deleteWithBody(
    String endpoint, {
    Map<String, String>? headers,
    required String body,
  }) async {
    final url = Uri.parse('$baseUrl/$endpoint');
    print('DELETE request to: $url');
    final response = await http.delete(
      url,
      headers: headers ?? {'Content-Type': 'application/json'},
      body: body,
    );
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    return response;
  }
}
