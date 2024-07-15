import 'package:flutter/material.dart';
import 'package:vbooks_source/pages/home/hotwidget.dart';
import '../../services/apiservice.dart';
import '../../services/productservice.dart';
import '../components/search/searchform.dart';
import '../components/typelistdart.dart';
import 'fearturedwidget.dart';
import '../../conf/const.dart';

class HomeWidget extends StatelessWidget {
  HomeWidget({super.key});
  final apiService = ApiService();
  final productService = ProductService(ApiService());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Search form
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              child: SearchWidget(),
            ),

            // Featured List
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TypeList(
                            productService: productService,
                            title: 'Danh sách sản phẩm',
                          ),
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

            // // Use a ListView for featured products
            // FeaturedListWidget(productService: productService),

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
                          builder: (context) => TypeList(
                            productService: productService,
                            title: 'Danh sách sản phẩm',
                          ),
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

            // // Use a ListView for hot products
            // HotProductList(productService: productService),
          ],
        ),
      ),
    );
  }
}
