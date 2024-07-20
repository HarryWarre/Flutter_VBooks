import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vbooks_source/pages/account/authwidget.dart';
import 'package:vbooks_source/services/apiservice.dart';
import 'package:vbooks_source/viewmodel/cartviewmodel.dart';

import 'mainpage.dart';
import 'viewmodel/productviewmodel.dart';
import 'viewmodel/categoryviewmodel.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Future.delayed(const Duration(seconds: 1));
  FlutterNativeSplash.remove();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('token'); // Đảm bảo token có thể là null

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProductViewModel()),
        ChangeNotifierProvider(create: (_) => CategoryViewModel()),
        ChangeNotifierProvider(create: (_) => CartViewModel()),
      ],
      child: MyApp(token: token), // Truyền giá trị token vào MyApp
    ),
  );
}

class MyApp extends StatelessWidget {
  final String? token; // Sử dụng String? để cho phép giá trị null

  const MyApp({
    required this.token, // Sử dụng required để đảm bảo giá trị không null
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Kiểm tra giá trị của token
    bool isTokenExpired = token == null || JwtDecoder.isExpired(token!);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: isTokenExpired ? AuthScreen() : Mainpage(token: token!),
    );
  }
}
