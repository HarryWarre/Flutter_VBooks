import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vbooks_source/pages/account/accountpersonalwidget.dart';
import 'package:vbooks_source/pages/account/authwidget.dart';
import 'package:vbooks_source/pages/account/favoritebook.dart';
import 'package:vbooks_source/pages/components/widgetforscreen.dart';
import 'package:vbooks_source/services/accountservice.dart';

import '../../services/apiservice.dart';
import '../order/ordermainpage.dart';

class AccountInfoWidget extends StatefulWidget {
  const AccountInfoWidget({super.key});

  @override
  State<AccountInfoWidget> createState() => _AccountInfoWidgetState();
}

class _AccountInfoWidgetState extends State<AccountInfoWidget> {
  String token = '';
  String email = '';
  String fullName = '';
  String address = '';
  String id = '';
  late ApiService _apiService;
  late AccountService accountService;
  @override
  void initState() {
    super.initState();
    _apiService = ApiService();
    _loadToken();
    accountService = AccountService(_apiService);
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
          email = jwtDecodedToken['email'] ?? '...';
          fullName = jwtDecodedToken['fullName'] ?? '...';
          address = jwtDecodedToken['address'] ?? '...';
          id = jwtDecodedToken['_id'] ?? '...';
          print(fullName + address + id);
          print(token);
        });
      }
    } else {
      setState(() {
        token = 'Invalid token';
      });
    }
  }

  Future<void> _confirmDeleteAccount() async {
    bool? confirmed = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Xác nhận xóa'),
          content: Text('Bạn có chắc chắn muốn xóa tài khoản id: $id không?'),
          actions: <Widget>[
            TextButton(
              child: Text('Hủy'),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
            TextButton(
              child: Text('Xác nhận'),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
            ),
          ],
        );
      },
    );

    if (confirmed == true) {
      await _deleteAccount();
    }
  }

  Future<void> _deleteAccount() async {
    try {
      final response = await accountService.deleteAccount(id);

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text('Account deleted: ${responseData['message']}')),
        );
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => AuthScreen(),
        ));
      } else if (response.statusCode == 404) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text('Account not found: ${responseData['message']}')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Thông tin tài khoản'),
      ),
      body: ListView(
        children: [
          AccountSelectWidget(
            value: 'Thông tin cá nhân',
            iconLeft: CupertinoIcons.person,
            iconRight: Icons.arrow_forward_ios,
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => AccountPersonalWidget()));
            },
          ),
          CustomDivider(height: 2),
          const SizedBox(height: 20),
          AccountInfoRow(label: 'Họ và tên', value: fullName),
          AccountInfoRow(label: 'Email', value: email),
          AccountInfoRow(label: 'Địa chỉ', value: address),
          const SizedBox(height: 20),
          CustomDivider(height: 2),
          const SizedBox(height: 8),
          AccountShoppingRow(
              label: 'Số đơn hàng đặt thành công', value: '1 đơn hàng'),
          AccountShoppingRow(
              label: 'Số tiền đã thanh toán', value: '150.000.000.000 VNĐ'),
          const SizedBox(height: 26),
          CustomDivider(height: 6),
          AccountSelectWidget(
            value: 'Sản phẩm yêu thích',
            iconLeft: Icons.favorite,
            iconRight: Icons.arrow_forward_ios,
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => FavoriteScreen()));
            },
          ),
          CustomDivider(height: 2),
          AccountSelectWidget(
            value: 'Lịch sử mua hàng',
            iconLeft: Icons.history,
            iconRight: Icons.arrow_forward_ios,
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => OrderMainPage()));
            },
          ),
          CustomDivider(height: 2),
          AccountSelectWidget(
            value: 'Đăng xuất',
            iconLeft: Icons.logout,
            iconRight: Icons.arrow_forward_ios,
            onTap: () {
              logout(context);
            },
          ),
          CustomDivider(height: 2),
          AccountSelectWidget(
            value: 'Xóa tài khoản',
            iconLeft: Icons.delete,
            iconRight: Icons.arrow_forward_ios,
            onTap: _confirmDeleteAccount,
          ),
          CustomDivider(height: 2),
        ],
      ),
    );
  }
}

void logout(BuildContext context) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.remove('token'); // Xóa token từ SharedPreferences

  // Quay về màn hình đăng nhập và loại bỏ các route cũ
  Navigator.of(context).pushAndRemoveUntil(
    MaterialPageRoute(builder: (context) => AuthScreen()),
    (Route<dynamic> route) => false, // Loại bỏ tất cả các route cũ khỏi stack
  );
}
