import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
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
                        // Implement your logic for OTP request
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
              Center(child: Text('Nhập mã xác nhận được gửi tới Email của bạn',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14,),),),
              SizedBox(height: 16),
              Center(
                child: OtpTextField(
                  numberOfFields: 5,
                  keyboardType: TextInputType.number,
                  enabledBorderColor: Colors.grey,
                  showFieldAsBox: false,
                  margin: EdgeInsets.only(right: 16.0),
                  focusedBorderColor: Colors.teal,
                  onCodeChanged: (String code) {
                    // Handle validation or checks here
                  },
                  onSubmit: (String verificationCode) {
                    
                  },
                ),
              ),
               SizedBox(height: 16),
              Center(child: Text('Nếu có vấn để gì thì xin hãy gọi 1800 9090',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14,),),),

              SizedBox(height: 32),
              Center(
                child: SizedBox(
                  width: 320,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      // Implement your logic for password change
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
