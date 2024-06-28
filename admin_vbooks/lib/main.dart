import 'package:admin_vbooks/mainpage.dart';
import 'package:flutter/material.dart';
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
        title: appName,
        theme: ThemeData(
            useMaterial3: true,
            colorScheme: ColorScheme.fromSeed(
              seedColor: const Color.fromRGBO(21, 139, 125, 1),
              // TRY THIS: Change to "Brightness.light"
              //           and see that all colors change
              //           to better contrast a light background.
            ).copyWith(background: Colors.white)),
        home: const MainPage());
  }
}
