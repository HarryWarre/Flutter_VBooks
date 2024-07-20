import 'apiservice.dart';
import 'package:http/http.dart' as http;

class ResetPassService{
  final ApiService apiService;

  ResetPassService(this.apiService);

  Future<http.Response> forgotPass(String email) async {
    var data = {
      'email': email
    };

    return await apiService.post('changepassword/forgot-password', data);
  } 

  Future<http.Response> resetPass(String otp,  String newPassword) async {
    var data = {
      'otp': otp,
      'newPassword': newPassword
    };

    return await apiService.post('changepassword/reset-password', data);
  } 
}