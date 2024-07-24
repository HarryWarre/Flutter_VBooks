import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vbooks_source/mainpage.dart';
import 'package:vbooks_source/pages/account/forgotpassword.dart';
import 'package:vbooks_source/services/accountservice.dart';
import 'package:vbooks_source/services/apiservice.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool _isCheck = true;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  late ApiService _apiService;
  late AccountService _accountService;
  late SharedPreferences prefer;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      setState(() {});
    });
    _apiService = ApiService();
    _accountService = AccountService(_apiService);
    initSharedPref();
  }

  void initSharedPref() async {
    prefer = await SharedPreferences.getInstance();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void registerUser() async {
  if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Vui lòng nhập đầy đủ thông tin'),
        duration: Duration(seconds: 3),
      ),
    );
    return; // Dừng hàm nếu không nhập đầy đủ thông tin
  }

  if (_emailController.text.isNotEmpty && _passwordController.text.isNotEmpty) {
    var response = await _accountService.register(
      _emailController.text, _passwordController.text);

    if (response.statusCode == 200) {
      // Thành công, hiển thị thông báo và chuyển sang tab đăng nhập
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Đăng ký thành công'),
          duration: Duration(seconds: 2),
        ),
      );
      
      // Chuyển sang tab đăng nhập (nếu `_tabController` đã khởi tạo và không bị null)
      _passwordController.clear();
      _tabController.animateTo(0);

    } else {
      // Đăng ký thất bại, xử lý thông báo lỗi
      var jsonResponse = jsonDecode(response.body);
      String errorMessage = jsonResponse['message'] ?? 'Đăng ký không thành công';
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMessage),
          duration: Duration(seconds: 3),
        ),
      );
    }
  }
}

  void loginUser() async {
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
   
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Vui lòng nhập đầy đủ thông tin'),
        duration: Duration(seconds: 3),
      ),
    );
    return; // Dừng hàm nếu không nhập đầy đủ thông tin
  }

  if (_emailController.text.isNotEmpty && _passwordController.text.isNotEmpty) {
    var response = await _accountService.login(_emailController.text, _passwordController.text);
    var jsonResponse = jsonDecode(response.body);
    _passwordController.clear();
    if (response.statusCode == 200) {
      var myToken = jsonResponse['token'];
      prefer.setString('token', myToken);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Mainpage(token: myToken)),
      );
    } else {
      // Hiển thị SnackBar khi đăng nhập không thành công
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(jsonResponse['message']), // Hiển thị thông điệp từ server
          duration: Duration(seconds: 3), // Thiết lập thời gian hiển thị SnackBar
        ),
      );
    }
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
          automaticallyImplyLeading: false,
        ),
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: [
                TabBar(
                  controller: _tabController,
                  indicatorColor: Colors.teal,
                  labelColor: Colors.teal,
                  unselectedLabelColor: Colors.grey,
                  tabs: [
                    Tab(
                      child: Text(
                        'ĐĂNG NHẬP',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Tab(
                      child: Text(
                        'ĐĂNG KÝ',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
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
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: TextField(
                    controller: _emailController,
                    textAlign: TextAlign.left,
                    decoration: const InputDecoration(
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
                    controller: _passwordController,
                    textAlign: TextAlign.left,
                    obscureText: _isCheck,
                    decoration: InputDecoration(
                      floatingLabelStyle: TextStyle(color: Colors.teal),
                      labelText: "Nhập mật khẩu",
                      border: InputBorder.none,
                      suffixIcon: IconButton(
                        icon: Icon(_isCheck
                            ? Icons.visibility
                            : Icons.visibility_off),
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
                    visible: _tabController.index == 0,
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ForgotPassword(),
                        ));
                      },
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
                    if (_tabController.index == 1)
                      const SizedBox(height: 14),
                    SizedBox(
                      width: 320,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_tabController.index == 0) {
                            loginUser();
                          } else {
                            registerUser();
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.teal,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          _tabController.index == 0 ? 'Đăng nhập' : 'Đăng ký',
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
                    _tabController.animateTo(
                      _tabController.index == 0 ? 1 : 0,
                    );
                  },
                  child: Text.rich(
                    TextSpan(
                      text: _tabController.index == 1
                          ? 'Bạn đã có tài khoản? '
                          : 'Bạn chưa có tài khoản? ',
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                      children: [
                        TextSpan(
                          text: _tabController.index == 1
                              ? 'Đăng nhập tại đây'
                              : 'Đăng ký tại đây',
                          style: const TextStyle(
                            color: Colors.teal,
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
