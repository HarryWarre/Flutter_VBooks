import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool isLogin = true;
  bool _isCheck = true;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },     
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        TextButton(
                          onPressed: () {
                            setState(() {
                              isLogin = true;
                            });
                          },
                          child: Text(
                            'ĐĂNG NHẬP',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: isLogin ? Colors.teal : Colors.grey,
                            ),
                          ),
                        ),
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                          width: isLogin ? 120 : 0,
                          height: 2,
                          child: Transform.translate(
                            offset: isLogin ? const Offset(0, 0) : const Offset(100, 0),
                            child: Container(
                              width: 100,
                              height: 2,
                              color: Colors.teal,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 32),
                    Column(
                      children: [
                        TextButton(
                          onPressed: () {
                            setState(() {
                              isLogin = false;
                            });
                          },
                          child: Text(
                            'ĐĂNG KÝ',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: !isLogin ? Colors.teal : Colors.grey,
                            ),
                          ),
                        ),
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                          width: !isLogin ? 100 : 0,
                          height: 2,
                          child: Transform.translate(
                            offset: isLogin ? Offset(100, 0) : Offset(0, 0),
                            child: Container(
                              width: 100,
                              height: 2,
                              color: Colors.teal,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 32,
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    'Email/ Số điện thoại',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ),
                const SizedBox(height: 8), // Add some space
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const TextField(
                    textAlign: TextAlign.left, // Align text to the left
                    decoration: InputDecoration(
                      labelText: "Nhập Email / Số điện thoại",
                      floatingLabelStyle: TextStyle(color: Colors.teal),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    'Mật khẩu',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ),

                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: TextField(
                    textAlign: TextAlign.left,
                    obscureText: _isCheck,
                    decoration: InputDecoration(
                      floatingLabelStyle: TextStyle(color: Colors.teal),
                      labelText: "Nhập mật khẩu",
                      border: InputBorder.none,
                      suffixIcon: IconButton(
                        icon: Icon(
                            _isCheck ? Icons.visibility : Icons.visibility_off),
                        color: Colors.grey,
                        onPressed: () {
                          setState(() {
                            _isCheck = !_isCheck;
                          });
                        },
                      ),
                    ),
                  ),
                ),

                Container(
                  alignment: Alignment.centerRight,
                  child: Visibility(
                    visible: isLogin,
                    child: TextButton(
                      onPressed: () {},
                      child: const Text(
                        'Quên mật khẩu?',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: Colors.teal,
                        ),
                      ),
                    ),
                  ),
                ),

                Column(
                  children: [
                    if (!isLogin)
                      const SizedBox(
                          height:
                              14), // Add SizedBox with height 12 above the ElevatedButton when isLogin is false
                    SizedBox(
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
                          isLogin ? 'Đăng nhập' : 'Đăng ký',
                          style: const TextStyle(
                            fontFamily: 'Inter',
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                TextButton(
                  onPressed: () {
                    setState(() {
                      isLogin = !isLogin;
                    });
                  },
                  child: Text.rich(
                    TextSpan(
                      text: !isLogin
                          ? 'Bạn đã có tài khoản? '
                          : 'Bạn chưa có tài khoản? ',
                      style: const TextStyle(
                        color: Colors
                            .black, // Always set this part of text to black
                      ),
                      children: [
                        TextSpan(
                          text:
                              !isLogin ? 'Đăng nhập tại đây' : 'Đăng ký tại đây',
                          style: const TextStyle(
                            color: Colors.teal, // Set this part of text to teal
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
