import 'package:flutter/material.dart';
import 'package:vbooks_source/pages/home/hotwidget.dart';
import '../components/search/searchform.dart';
import '../components/typelistdart.dart';
import 'fearturedwidget.dart';
import '../../conf/const.dart';

class HomeWidget extends StatelessWidget {
  const HomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            // Search form
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
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
                      String title = 'Nổi bật';
                      String json = 'feartured';
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              TypeList(title: title, type: json),
                        ),
                      );
                    },
                    child: const Text(
                      'Xem thêm',
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
                      // Use SeeMoreWidget to fetch and handle featured data
                      String title = 'Bán chạy';
                      String json = 'hot';
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              TypeList(title: title, type: json),
                        ),
                      );
                    },
                    child: const Text(
                      'Xem thêm',
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
      ),
    );
  }
}
