import 'package:flutter/material.dart';

class AuthWidget extends StatefulWidget {
  const AuthWidget({super.key});

  @override
  State<AuthWidget> createState() => _AuthWidgetState();
}

class _AuthWidgetState extends State<AuthWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Row(
        mainAxisAlignment:
            MainAxisAlignment.center, // căn giữa các phần tử ngang hàng
        children: [
          Column(
            mainAxisAlignment:
                MainAxisAlignment.center, // căn giữa các phần tử dọc
            children: [
              Text(
                'Đăng nhập',
                style: TextStyle(fontSize: 25, fontFamily: 'Inter'),
              ),
            ],
          ),
          SizedBox(width: 20), // Khoảng cách giữa các cột (tùy chọn)
          Column(
            mainAxisAlignment:
                MainAxisAlignment.center, // căn giữa các phần tử dọc
            children: [
              Text(
                'Đăng ký',
                style: TextStyle(fontSize: 25, fontFamily: 'Inter'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
