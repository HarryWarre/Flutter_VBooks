import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vbooks_source/pages/components/button.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(12, 8, 8, 8),
        child: ListView(
          // thay bằng Consumer và ListView.seperated khi có data
          scrollDirection: Axis.vertical,
          addAutomaticKeepAlives: true,
          children: [
            _buildBookItem(
                'assets/spy.png', 'Spy x Family', '40.000 VNĐ', _test),
            _buildBookItem(
                'assets/spy.png', 'Sách C# cơ bản', '241.200 đ', _test),
            _buildBookItem('assets/spy.png', 'Sample Book', '123.000 đ', _test),
            _buildBookItem('assets/spy.png', 'Sample Book', '123.000 đ', _test),
            _buildBookItem('assets/spy.png', 'Sample Book', '123.000 đ', _test),
            _buildBookItem('assets/spy.png', 'Sample Book', '123.000 đ', _test),
          ],
        ),
      ),
    );
  }

  Widget _buildBookItem(
      String imagePath, String title, String price, VoidCallback onPressed) {
    return Container(
      height: 140,
      width: 335,
      padding: EdgeInsets.fromLTRB(12, 8, 12, 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // Image.asset(imagePath, width: 90, height: 100, fit: BoxFit.cover),
          FittedBox(
            child: Image.asset(imagePath),
            fit: BoxFit.fill,
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      overflow: TextOverflow.ellipsis),
                ),
                Text(
                  price,
                  style: TextStyle(color: Colors.teal),
                ),
                SizedBox(height: 30),
                Button(
                    width: 120,
                    height: 30,
                    text: 'Mua ngay',
                    onPressed: onPressed),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.fromLTRB(0, 70, 0, 0),
            child: IconButton(
              icon: const Icon(CupertinoIcons.delete),
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }

  void _test() {
    print('hello');
  }
}
