import 'apiservice.dart';
import 'package:http/http.dart' as http;

class ResetPassService{
  final ApiService apiService;

  ResetPassService(this.apiService);

  Future<http.Response> forgotPass(String email){
    var data = {
      'email': email
    };

    return apiService.post('changepassword/forgot-password', data);
  } 

  Future<http.Response> resetPass(String otp, String oldPassword, String newPassword){
    var data = {
      'otp': otp,
      'oldPassword': oldPassword,
      'newPassword': newPassword
    };

    return apiService.post('changepassword/reset-password', data);
  } 
}