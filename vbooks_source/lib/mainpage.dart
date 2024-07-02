import 'package:flutter/material.dart';
import 'package:vbooks_source/pages/account/accountpersonalwidget.dart';
import 'package:vbooks_source/pages/account/authwidget.dart';
import 'package:vbooks_source/pages/account/accountinfowidget.dart';
import 'package:vbooks_source/pages/cart/cartwidget.dart';
import 'package:vbooks_source/pages/order/ordermainpage.dart';

// import 'pages/account/accountwidget.dart';
import 'pages/category/categorywidget.dart';
import 'pages/home/homeWidget.dart';

class Mainpage extends StatefulWidget {
  const Mainpage({super.key});

  @override
  State<Mainpage> createState() => _MainpageState();
}

class _MainpageState extends State<Mainpage> {
  int _selectedIndex = 0;

  static const List<String> _titles = <String>[
    'Trang chủ',
    'Thể loại',
    'Giỏ hàng',
    'Tài khoản'
  ];

  static final List<Widget> _widgetOptions = <Widget>[
    HomeWidget(),
    CategoryWidget(),
    CartWidget(),
    AccountInfoWidget(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(0.0),
          child: AppBar(),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Trang chủ',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.window_sharp),
              label: 'Thể loại',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_bag),
              label: 'Giỏ hàng',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Tài khoản',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: const Color.fromRGBO(21, 139, 125, 1),
          unselectedItemColor: const Color.fromRGBO(212, 214, 221, 1),
          onTap: _onItemTapped,
          showSelectedLabels: true,
          showUnselectedLabels: true,
        ),
      ),
    );
  }
}
