import 'package:flutter/material.dart';
import 'package:vbooks_source/pages/home/testwidget.dart';

import '../../component/searchform.dart';
import 'fearturedwidget.dart';

class HomeWidget extends StatelessWidget {
  const HomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          // Child 1
          const Center(
            child: SearchWidget(),
          ),
          // Child 2
          Container(
            height: 300,
            color: Colors.white,
            child: Center(
              child: FeaturedListWidget(),
            ),
          ),
        ],
      ),
    );
  }
}
