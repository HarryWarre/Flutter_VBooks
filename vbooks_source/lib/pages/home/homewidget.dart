import 'package:flutter/material.dart';
import 'package:vbooks_source/pages/home/hotwidget.dart';
import 'package:vbooks_source/pages/home/testwidget.dart';
import '../../data/model/typelistmodel.dart';
import '../../data/provider/typeproductslist.dart';
import '../components/searchform.dart';
import '../components/typelistdart.dart';
import 'fearturedwidget.dart';
import '../../conf/const.dart';

class HomeWidget extends StatelessWidget {
  const HomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          // Search form
          const Center(
            child: SearchWidget(),
          ),
          // Feartured List
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Nổi bật',
                  style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    // Use SeeMoreWidget to fetch and handle featured data
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            const TypeList(data: 'Dữ liệu bạn muốn truyền'),
                      ),
                    );
                  },
                  child: const Text(
                    'xem thêm',
                    style: TextStyle(
                      color: primaryColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 270,
            color: Colors.white,
            child: Center(
              child: FeaturedListWidget(),
            ),
          ),

          // Hot
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Bán chạy',
                  style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    // Add your onPressed code here!
                  },
                  child: const Text(
                    'xem thêm',
                    style: TextStyle(
                      color: primaryColor,
                    ),
                  ),
                ),
              ],
            ),
          ),

          Container(
            height: 270,
            color: Colors.white,
            child: const Center(
              child: HotProductList(),
            ),
          ),
        ],
      ),
    );
  }
}
