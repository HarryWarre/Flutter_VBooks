import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vbooks_source/pages/components/passwordfield.dart';

class ChangePasswordWidget extends StatefulWidget {
  @override
  _ChangePasswordWidgetState createState() => _ChangePasswordWidgetState();
}

class _ChangePasswordWidgetState extends State<ChangePasswordWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },   
      child: Scaffold(    
        appBar: AppBar(centerTitle: true,
      title: Text('Đổi mật khẩu',),),   
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(22, 20, 20, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PasswordInputField(labelText: 'Mật khẩu cũ',hintText: 'Nhập mật khẩu cũ',),
                const SizedBox(height: 16),
                PasswordInputField(labelText: 'Mật khẩu mới',hintText: 'Nhập mật khẩu cũ',),
                const SizedBox(height: 16),
                PasswordInputField(labelText: 'Xác nhận mật khẩu mới',hintText: 'Nhập lại mật khẩu mới',),
                const SizedBox(height: 32),
                Column(
                  children: [
                    Center(
                      child: SizedBox(
                        width: 320,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {},
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