import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  final String baseUrl = 'http://10.0.2.2:5000'; // Điều chỉnh URL tại đây

  Future<http.Response> get(String endpoint) async {
    final url = '$baseUrl/$endpoint';
    print('GET request to: $url'); // In ra URL của yêu cầu GET
    final response = await http.get(Uri.parse(url));
    print(
        'Response status: ${response.statusCode}'); // In ra mã trạng thái của phản hồi
    print('Response body: ${response.body}'); // In ra nội dung của phản hồi
    return response;
  }

  Future<http.Response> post(String endpoint, Map<String, dynamic> data) async {
    final url = '$baseUrl/$endpoint';
    print('POST request to: $url'); // In ra URL của yêu cầu POST
    print('Request body: ${jsonEncode(data)}'); // In ra nội dung yêu cầu POST
    final response = await http.post(
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
}
