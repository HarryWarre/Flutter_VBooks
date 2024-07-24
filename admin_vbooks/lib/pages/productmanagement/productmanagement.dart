import 'package:admin_vbooks/components/custommainbutton.dart';
import 'package:admin_vbooks/pages/mainscreen/defaultscreen.dart';
import 'package:admin_vbooks/pages/ordermanagement/orderaminpage.dart';
import 'package:admin_vbooks/pages/productmanagement/category/category_list.dart';
import 'package:admin_vbooks/pages/productmanagement/product/product_listtest.dart';
import 'package:admin_vbooks/pages/productmanagement/publisher/publisher_list.dart';
import 'package:flutter/material.dart';

class ProductManagement extends StatelessWidget {
  const ProductManagement({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            // Handle back button press here
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) =>
                    MainScreenWidget(), // Navigate back to ProductBuilder
              ),
            );
          },
        ),
        title: const Text('Quản lý sản phẩm'),
        centerTitle: true,
        
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomButton(
              icon: Icons.app_registration_sharp,
              text: 'Sản phẩm',
              onPressed: () {
                // Action for button
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProductList()),
                );
              },
            ),
            const SizedBox(
              height: 37,
            ),
            CustomButton(
              icon: Icons.window_sharp,
              text: 'Thể loại',
              onPressed: () {
                // Action for button
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CategoryList()),
                );
              },
            ),
            const SizedBox(
              height: 37,
            ),
            CustomButton(
              icon: Icons.book,
              text: 'Nhà xuất bản',
              onPressed: () {
                // Action for button
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PublisherList()),
                );
              },
            ),          
          ],
        ),
      ),
    );
  }
}
