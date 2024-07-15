import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vbooks_source/pages/account/authwidget.dart';
import 'package:vbooks_source/services/apiservice.dart';

import 'mainpage.dart';
import 'viewmodel/productviewmodel.dart';
import 'viewmodel/categoryviewmodel.dart';

Future<void> main() async {
  await Future.delayed(const Duration(seconds: 3));
  FlutterNativeSplash.remove();
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProductViewModel()),
        ChangeNotifierProvider(create: (_) => CategoryViewModel()),
      ],
      child: MyApp(token: prefs.getString('token'),),
    ),
  );
}

class MyApp extends StatelessWidget {
  final token;
  const MyApp({
    @required this.token,
    Key? key,

  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: (JwtDecoder.isExpired(token) == false) ? Mainpage(token: token): AuthScreen(),
    );
  }
}
