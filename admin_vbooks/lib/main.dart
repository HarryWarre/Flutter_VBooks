import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:admin_vbooks/pages/mainscreen/defaultscreen.dart';
import 'package:admin_vbooks/services/apiservice.dart';
import 'package:admin_vbooks/services/categoryservice.dart';
import 'package:admin_vbooks/services/categoryviewmodel.dart';

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
      theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromRGBO(37, 195, 177, 1.000),
          ),
          dialogTheme: const DialogTheme(backgroundColor: Colors.white)),
      home: const MainScreenWidget(),
    );
  }
}
