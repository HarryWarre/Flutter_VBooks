import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vbooks_source/conf/const.dart';
import 'package:vbooks_source/pages/account/authwidget.dart';
import 'package:vbooks_source/pages/components/passwordfield.dart';
import 'package:vbooks_source/pages/components/scafformessenger.dart';
import 'package:vbooks_source/services/apiservice.dart';
import 'package:vbooks_source/services/resetpasswordservice.dart';

class ChangePasswordWidget extends StatefulWidget {
  @override
  _ChangePasswordWidgetState createState() => _ChangePasswordWidgetState();
}

class _ChangePasswordWidgetState extends State<ChangePasswordWidget> {
  TextEditingController _newPassword = TextEditingController();
  TextEditingController _confirmNewPassword = TextEditingController();
  TextEditingController _otpController = TextEditingController();
  late ApiService _apiService;
  late ResetPassService _resetPassService;
  late SharedPreferences prefer;
  String _token = '';
  String _id = '';
  String _email = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _apiService = ApiService();
    _resetPassService = ResetPassService(_apiService);
    _loadToken();
  }
  
  Future<void> _loadToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? storedToken = prefs.getString('token');
    if (storedToken != null && storedToken.isNotEmpty) {
      if (JwtDecoder.isExpired(storedToken)) {
        setState(() {
          _token = 'Invalid token';
        });
        
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => AuthScreen(),
        ));
      } else {
        setState(() {
          _token = storedToken;
          Map<String, dynamic> jwtDecodedToken = JwtDecoder.decode(_token);
          _email = jwtDecodedToken['email'] ?? '...';
          _id = jwtDecodedToken['_id'] ?? '...';
          print(_email);
          print(_id);
          print(_token);
        });
      }
    } else {
      setState(() {
        _token = 'Invalid token';
      });
    }
  }

  void _takeOTP() async {
    var response = await _resetPassService.forgotPass(_email);
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      String message = jsonResponse['message'];
      final messenger = ScaffoldMessenger.of(context);
      final errorSnackBar = MessengerSnackBar(
        message: message,
        messenger: messenger,
      );
      errorSnackBar.show();
    } else {
      final messenger = ScaffoldMessenger.of(context);
      final errorSnackBar = MessengerSnackBar(
        message: 'Đã gửi tới email này vui lòng đợi',
        messenger: messenger,
      );
      errorSnackBar.show();
    }
  }

  void resetPassword() async {
    if (_otpController.text.isEmpty ||
        _newPassword.text.isEmpty ||
        _confirmNewPassword.text.isEmpty) {
      final messenger = ScaffoldMessenger.of(context);
      final errorSnackBar = MessengerSnackBar(
        message: 'Vui lòng nhập đầy đủ thông tin',
        messenger: messenger,
      );
      errorSnackBar.show();
      return;
    }

    if (_newPassword.text != _confirmNewPassword.text) {
      final messenger = ScaffoldMessenger.of(context);
      final errorSnackBar = MessengerSnackBar(
        message: 'Mật khẩu không khớp',
        messenger: messenger,
      );
      errorSnackBar.show();
      return;
    }

    var response = await _resetPassService.resetPass(
      _otpController.text,
      _newPassword.text,
    );

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      String message = jsonResponse['message'];
      final messenger = ScaffoldMessenger.of(context);
      final errorSnackBar = MessengerSnackBar(
        message: message,
        messenger: messenger,
      );
      errorSnackBar.show();
    } else {
      var jsonResponse = jsonDecode(response.body);
      String message = jsonResponse['message'];
      final messenger = ScaffoldMessenger.of(context);
      final errorSnackBar = MessengerSnackBar(
        message: message,
        messenger: messenger,
      );
      errorSnackBar.show();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Đổi mật khẩu',
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(22, 20, 20, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PasswordInputField(
                  labelText: 'Mật khẩu mới',
                  hintText: 'Nhập mật khẩu mới',
                  content: _newPassword,
                ),
                const SizedBox(height: 16),
                PasswordInputField(
                  labelText: 'Xác nhận mật khẩu mới',
                  hintText: 'Nhập lại mật khẩu mới',
                  content: _confirmNewPassword,
                ),
                TextButton(
                  onPressed: () {
                    _takeOTP();
                  },
                  child: Text(
                    'Nhận mã OTP',
                    style: TextStyle(color: primaryColor, fontSize: 14),
                  ),
                ),
                const SizedBox(height: 16),
                const Center(
                  child: Text(
                    'Nhập mã xác nhận được gửi tới Email của bạn',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 32,
                ),
                Center(
                  child: OtpTextField(
                    numberOfFields: 5,
                    keyboardType: TextInputType.number,
                    enabledBorderColor: Colors.grey,
                    showFieldAsBox: false,
                    margin: EdgeInsets.only(right: 16.0),
                    focusedBorderColor: Colors.teal,
                    onSubmit: (String verificationCode) {
                      setState(() {
                        _otpController.text = verificationCode;
                      });
                    },
                  ),
                ),
                const SizedBox(
                  height: 32,
                ),
                Column(
                  children: [
                    Center(
                      child: SizedBox(
                        width: 320,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {
                            resetPassword();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.teal,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Text(
                            'Đổi mật khẩu',
                            style: const TextStyle(
                              fontFamily: 'Inter',
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
