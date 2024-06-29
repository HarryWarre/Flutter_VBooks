import 'package:admin_vbooks/components/custommainbutton.dart';
import 'package:admin_vbooks/pages/productmanagement/category/category_list.dart';
import 'package:admin_vbooks/pages/productmanagement/product/product_data.dart';
import 'package:admin_vbooks/pages/productmanagement/product/product_list.dart';
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
            // Action for back button
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
            )
          ],
        ),
      ),
    );
  }
}
