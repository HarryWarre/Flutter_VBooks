import 'package:http/http.dart' as http;
import 'apiservice.dart';

class AdminService {
  final ApiService apiService;

  AdminService(this.apiService);


  Future<http.Response> login(String email, String password) {
    var data = {
      'email': email,
      'password': password,
    };
    return apiService.post('admin/login', data);
  }

  Future<http.Response> logout() {
    return apiService.post('admin/logout', {});
  }

}
