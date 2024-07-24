import 'package:admin_vbooks/connectApi/apiservice.dart';
import 'package:admin_vbooks/connectApi/categoryservice.dart';
import 'package:admin_vbooks/connectApi/productservice.dart';
import 'package:admin_vbooks/connectApi/publisherservice.dart';
import 'package:admin_vbooks/viewmodel/categoryviewmodel.dart';
import 'package:admin_vbooks/viewmodel/productviewmodel.dart';
import 'package:admin_vbooks/viewmodel/publisherviewmodel.dart';
import 'package:admin_vbooks/viewmodel/orderviewmodel.dart';
import 'package:admin_vbooks/viewmodel/orderdetailviewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:admin_vbooks/pages/mainscreen/defaultscreen.dart';


void main() {
  final _apiService = ApiService();
  final _categoryService = CategoryService(_apiService);
  final _publisherService = PublisherService(_apiService);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CategoryViewModel(_categoryService)),
        ChangeNotifierProvider(create: (_) => PublisherViewModel(_publisherService)),
        ChangeNotifierProvider(create: (_) => ProductViewModel()),
        ChangeNotifierProvider(create: (_) => OrderViewModel()),
        ChangeNotifierProvider(create: (_) => OrderDetailViewModel()),
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