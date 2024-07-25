import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vbooks_source/data/model/accountmodel.dart';
import 'package:vbooks_source/pages/account/authwidget.dart';
import 'package:vbooks_source/services/accountservice.dart';
import 'package:vbooks_source/services/apiservice.dart';

class UpdateInfoScreen extends StatefulWidget {
  @override
  _UpdateInfoScreenState createState() => _UpdateInfoScreenState();
}

class _UpdateInfoScreenState extends State<UpdateInfoScreen> {
  TextEditingController _dateController = TextEditingController();
  String _gender = 'Nam';
  TextEditingController _phoneNumber = TextEditingController();
  TextEditingController _address = TextEditingController();
  TextEditingController _fullName = TextEditingController();
  late int takeGender;
  late SharedPreferences prefer;
  late AccountService _accountService;
  late ApiService _apiService;
  String token = '';
  String _id = '';
  late DateTime takeTime;

  @override
  void initState() {
    super.initState();
    _apiService = ApiService();
    _accountService = AccountService(_apiService);
    takeTime = DateTime.now(); // Khởi tạo takeTime với giá trị mặc định
    _loadToken();
    initSharedPref(); // Khởi tạo SharedPreferences
  }

  void initSharedPref() async {
    prefer = await SharedPreferences.getInstance();
  }

  void updateAccount() async {
    if (_phoneNumber.text.isEmpty ||
        _address.text.isEmpty ||
        _fullName.text.isEmpty ||
        takeTime == null ||
        takeGender == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Vui lòng nhập đầy đủ thông tin'),
          duration: Duration(seconds: 3),
        ),
      );
      return; // Thoát khỏi hàm nếu có thông tin thiếu
    }

    var response = await _accountService.update(
      _id,
      _fullName.text,
      _address.text,
      _phoneNumber.text,
      takeTime,
      takeGender,
    );

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Thay đổi thông tin thành công'),
          duration: Duration(seconds: 2),
        ),
      );

      // Cập nhật SharedPreferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      // await prefs.setString('email', _email.text);
      await prefs.setString('fullName', _fullName.text);
      await prefs.setString('address', _address.text);
      await prefs.setString('phoneNumber', _phoneNumber.text);
      await prefs.setInt('gender', takeGender);
      await prefs.setString('dob', _dateController.text);
      await prefs.setString('id', _id);
    } else {
      var jsonResponse = jsonDecode(response.body);
      String errorMessage =
          jsonResponse['message'] ?? 'Cập nhật không thành công';

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMessage),
          duration: Duration(seconds: 3),
        ),
      );
    }
  }

  Future<void> _loadToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? storedToken = prefs.getString('token');
    if (storedToken != null && storedToken.isNotEmpty) {
      if (JwtDecoder.isExpired(storedToken)) {
        setState(() {
          token = 'Invalid token';
        });

        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => AuthScreen(),
        ));
      } else {
        setState(() {
          token = storedToken;
          Map<String, dynamic> jwtDecodedToken = JwtDecoder.decode(token);
          _id = jwtDecodedToken['_id'];
        });
      }
    } else {
      setState(() {
        token = 'Invalid token';
      });
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
            'Thông tin của tôi',
          ),
        ),
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(22, 20, 20, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    'Họ tên',
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
                    controller: _fullName,
                    textAlign: TextAlign.left,
                    decoration: InputDecoration(
                      labelText: 'Nhập họ tên',
                      floatingLabelStyle: TextStyle(color: Colors.teal),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    'Địa chỉ',
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
                    controller: _address,
                    textAlign: TextAlign.left,
                    decoration: InputDecoration(
                      floatingLabelStyle: TextStyle(color: Colors.teal),
                      labelText: 'Nhập địa chỉ',
                      border: InputBorder.none,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    'Số điện thoại',
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
                    controller: _phoneNumber,
                    keyboardType: TextInputType.phone,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    decoration: InputDecoration(
                      floatingLabelStyle: TextStyle(color: Colors.teal),
                      border: InputBorder.none,
                      labelText: 'Nhập số điện thoại',
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    'Ngày sinh',
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
                    controller: _dateController,
                    decoration: InputDecoration(
                      suffixIcon: Icon(CupertinoIcons.calendar),
                      labelText: 'DD/MM/YYYY',
                      border: InputBorder.none,
                    ),
                    onTap: () {
                      _selectDate();
                    },
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    'Giới tính',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ),
                const SizedBox(height: 4), // Adjusted spacing here
                Row(
                  children: [
                    Expanded(
                      child: RadioListTile<String>(
                        title: Text('Nam'),
                        value: (takeGender = 1).toString(),
                        groupValue: _gender.toString(),
                        onChanged: (value) {
                          setState(() {
                            _gender = value!;
                          });
                        },
                        activeColor: Colors.teal,
                      ),
                    ),
                    const SizedBox(
                      width: 100,
                    ),
                    Expanded(
                      child: RadioListTile<String>(
                        title: Text('Nữ'),
                        value: (takeGender = 2).toString(),
                        groupValue: _gender,
                        onChanged: (value) {
                          setState(() {
                            _gender = value!;
                          });
                        },
                        activeColor: Colors.teal,
                      ),
                    ),
                  ],
                ),

                const SizedBox(
                  height: 16,
                ),
                Column(
                  children: [
                    Center(
                      child: SizedBox(
                        width: 320,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {
                            updateAccount();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.teal,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Text(
                            'Cập nhật thông tin',
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

  Future<void> _selectDate() async {
    DateTime? _picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (_picked != null) {
      setState(() {
        _dateController.text = _picked.toString().split(" ")[0];
        takeTime = DateTime.parse(_dateController.text);
      });
    }
  }
}
