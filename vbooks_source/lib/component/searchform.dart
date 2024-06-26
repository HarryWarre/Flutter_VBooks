import 'package:flutter/material.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(248, 249, 254, 1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: const Row(
        children: [
          Icon(Icons.search, size: 24),
          SizedBox(width: 15),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Tìm kiếm',
                hintStyle: TextStyle(color: Color.fromRGBO(143, 144, 152, 1)),
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
