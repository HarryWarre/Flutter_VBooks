import 'dart:convert';
import 'package:http/http.dart' as http;
import 'apiservice.dart';

class AccountService {
  final ApiService apiService;

  AccountService(this.apiService);

  Future<http.Response> register(String email, String password) {
    var data = {
      'email': email,
      'password': password,
    };
    return apiService.post('account/register', data);
  }

  Future<http.Response> login(String email, String password) {
    var data = {
      'email': email,
      'password': password,
    };
    return apiService.post('account/login', data);
  }

 Future<http.Response> update(String userId, String fullName, String address, String phoneNumber, DateTime bod, int sex) async {
    var data = {
      'fullName': fullName,
      'address': address,
      'phoneNumber': phoneNumber,
      'bod': bod.toIso8601String(), // Chuyển đổi thành chuỗi ISO 8601 để gửi lên server
      'sex': sex,
    };
  
    return apiService.put('account/update/$userId', data); // Giả sử API endpoint là '/account/:id'
  }

   Future<http.Response> getAccountById(String id) async {
    final response = await apiService.get('account/$id');
    return response;
  }
  
}
