import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ChangePasswordWidget extends StatefulWidget {
  @override
  _ChangePasswordWidgetState createState() => _ChangePasswordWidgetState();
}

class _ChangePasswordWidgetState extends State<ChangePasswordWidget> {
  bool _isCheckOldPass = true;
  bool _isCheckNewPass =  true;
  bool _isCheckConfirmPass = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(22, 0, 20, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    'Mật khẩu hiện tại',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: TextField(
                    textAlign: TextAlign.left,
                    obscureText: _isCheckOldPass,
                    decoration: InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      labelText: "Nhập mật khẩu hiện tại",
                      border: InputBorder.none,
                      suffixIcon: IconButton(
                        icon: Icon(
                            _isCheckOldPass ? Icons.visibility : Icons.visibility_off),
                        color: Colors.grey,
                        onPressed: () {
                          setState(() {
                            _isCheckOldPass = !_isCheckOldPass;
                          });
                        },
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    'Mật khẩu mới',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: TextField(
                    textAlign: TextAlign.left,
                    obscureText: _isCheckNewPass,
                    decoration: InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      labelText: "Nhập mật khẩu mới",
                      border: InputBorder.none,
                      suffixIcon: IconButton(
                        icon: Icon(
                            _isCheckNewPass ? Icons.visibility : Icons.visibility_off),
                        color: Colors.grey,
                        onPressed: () {
                          setState(() {
                            _isCheckNewPass = !_isCheckNewPass;
                          });
                        },
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    'Xác nhận mật khẩu mới',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: TextField(
                    textAlign: TextAlign.left,
                    obscureText: _isCheckConfirmPass,
                    decoration: InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      labelText: "Nhập lại mật khẩu mới",
                      border: InputBorder.none,
                      suffixIcon: IconButton(
                        icon: Icon(
                            _isCheckConfirmPass ? Icons.visibility : Icons.visibility_off),
                        color: Colors.grey,
                        onPressed: () {
                          setState(() {
                            _isCheckConfirmPass = !_isCheckConfirmPass;
                          });
                        },
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                        
                const SizedBox(height: 16,),
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