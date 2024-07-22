import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:admin_vbooks/pages/mainscreen/defaultscreen.dart';
import 'package:admin_vbooks/services/apiservice.dart';
import 'package:admin_vbooks/services/categoryservice.dart';
import 'package:admin_vbooks/services/categoryviewmodel.dart';

void main() {
  final apiService = ApiService();
  final categoryService = CategoryService(apiService);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => CategoryViewModel(categoryService),
        ),
        // Thêm các provider khác ở đây nếu cần
      ],
      child: MyApp(),
    ),
  );
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
        dialogTheme: const DialogTheme(backgroundColor: Colors.white),
      ),
      home: const MainScreenWidget(), // Đảm bảo rằng MainScreenWidget được định nghĩa và hoạt động tốt
    );
  }
}
