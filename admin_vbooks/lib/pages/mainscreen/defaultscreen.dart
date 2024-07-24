import 'package:admin_vbooks/admin_acount/accountadmintest.dart';
import 'package:admin_vbooks/admin_acount/acountadmin.dart';
import 'package:admin_vbooks/components/custommainbutton.dart';
import 'package:admin_vbooks/pages/ordermanagement/orderaminpage.dart';
import 'package:admin_vbooks/pages/productmanagement/category/category_list.dart';
import 'package:admin_vbooks/pages/productmanagement/productmanagement.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class MainScreenWidget extends StatelessWidget {
  const MainScreenWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'QUẢN LÝ WEBSITE',
              style: TextStyle(
                color: Colors.teal,
                fontSize: 35,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 100,
            ),
            CustomButton(
              icon: Icons.store,
              text: 'Quản lý đơn hàng',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => OrderAdminPage()),
                );
              },
            ),
            const SizedBox(
              height: 37,
            ),
            CustomButton(
              icon: PhosphorIcons.pen(),
              text: 'Quản lý sản phẩm',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProductManagement()),
                );
              },
            ),
            const SizedBox(
              height: 37,
            ),
            CustomButton(
              icon: CupertinoIcons.person_fill,
              text: 'Quản lý tài khoản',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AccountTest()),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
