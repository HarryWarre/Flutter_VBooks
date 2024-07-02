import 'package:admin_vbooks/pages/auth/login.dart';
import 'package:admin_vbooks/pages/productmanagement/productmanagement.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
// Include the Google Fonts package to provide more text format options
// https://pub.dev/packages/google_fonts

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const appName = 'Custom Themes';

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: appName,
      // debugShowCheckedModeBanner: false,
      // theme: ThemeData(
      //     useMaterial3: true,
      //     primaryColor: primary,
      //     primaryColorLight: primary,
      //     cardColor: Colors.white),
      theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromRGBO(37, 195, 177, 1.000),
          ),
          dialogTheme: const DialogTheme(backgroundColor: Colors.white)),
      home: AuthScreen(),
    );
  }
}
