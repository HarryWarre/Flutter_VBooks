import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:vbooks_source/pages/components/passwordfield.dart';
import 'package:vbooks_source/pages/components/scafformessenger.dart';
import 'package:vbooks_source/services/apiservice.dart';
import 'package:vbooks_source/services/resetpasswordservice.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _otpController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmpassController = TextEditingController();
  late ApiService _apiService;
  late ResetPassService _resetPassService;

  @override
  void initState() {
    super.initState();
    _apiService = ApiService();
    _resetPassService = ResetPassService(_apiService);
  }

  void takeOTP() async {
    if (_emailController.text.isEmpty) {
      final messenger = ScaffoldMessenger.of(context);
      final errorSnackBar = MessengerSnackBar(
        message: 'Vui lòng nhập email',
        messenger: messenger,
      );
      errorSnackBar.show();
      return;
    }

    var response = await _resetPassService.forgotPass(_emailController.text);

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
        _passwordController.text.isEmpty ||
        _confirmpassController.text.isEmpty) {
      final messenger = ScaffoldMessenger.of(context);
      final errorSnackBar = MessengerSnackBar(
        message: 'Vui lòng nhập đầy đủ thông tin',
        messenger: messenger,
      );
      errorSnackBar.show();
      return;
    }

    if (_passwordController.text != _confirmpassController.text) {
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
      _passwordController.text,
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
          title: Text('Quên mật khẩu'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(22, 0, 20, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Email',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _emailController,
                        textAlign: TextAlign.left,
                        decoration: InputDecoration(
                          labelText: 'Nhập email',
                          floatingLabelStyle: TextStyle(
                            color: Colors.teal,
                          ),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        takeOTP();
                      },
                      child: Text(
                        'Nhận mã OTP',
                        style: TextStyle(color: Colors.teal),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              PasswordInputField(
                labelText: 'Mật khẩu mới',
                hintText: 'Nhập mật khẩu mới',
                content: _passwordController,
              ),
              SizedBox(height: 16),
              PasswordInputField(
                labelText: 'Xác nhận mật khẩu',
                hintText: 'Nhập lại mật khẩu',
                content: _confirmpassController,
              ),
              SizedBox(height: 32),
              Center(
                child: Text(
                  'Nhập mã xác nhận được gửi tới Email của bạn',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
              SizedBox(height: 16),
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
              SizedBox(height: 32),
              Center(
                child: Text(
                  'Nếu có vấn để gì thì xin hãy gọi 1800 9090',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
              SizedBox(height: 32),
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
                      style: TextStyle(
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
        ),
      ),
    );
  }
}
