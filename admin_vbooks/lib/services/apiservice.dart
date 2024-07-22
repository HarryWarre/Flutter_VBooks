import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl;

  ApiService({this.baseUrl = 'http://192.168.1.7:5000'}); // Thay đổi baseUrl nếu cần

  // Phương thức GET để lấy dữ liệu từ API
  Future<http.Response> get(String endpoint) async {
    final url = Uri.parse('$baseUrl/$endpoint'); // Tạo URL từ baseUrl và endpoint
    try {
      final response = await http.get(url);

      // Kiểm tra trạng thái HTTP để đảm bảo yêu cầu thành công
      if (response.statusCode == 200) {
        return response;
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      // Xử lý lỗi
      throw Exception('Error fetching data: $e');
    }
  }
 Future<http.Response> post(String endpoint, {required String body}) async {
    final url = Uri.parse('$baseUrl/$endpoint');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: body,
      );
      return response;
    } catch (e) {
      throw Exception('Error posting data: $e');
    }
  }

  Future<http.Response> put(String endpoint, {required String body}) async {
    final url = Uri.parse('$baseUrl/$endpoint');
    try {
      final response = await http.put(
        url,
        headers: {'Content-Type': 'application/json'},
        body: body,
      );
      return response;
    } catch (e) {
      throw Exception('Error putting data: $e');
    }
  }
   Future<http.Response> delete(String endpoint) async {
    final url = Uri.parse('$baseUrl/$endpoint');
    try {
      final response = await http.delete(url);
      return response;
    } catch (e) {
      throw Exception('Error deleting data: $e');
    }
  }
}