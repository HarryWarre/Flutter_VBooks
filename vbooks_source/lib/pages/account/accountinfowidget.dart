import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vbooks_source/pages/account/accountpersonalwidget.dart';
import 'package:vbooks_source/pages/account/authwidget.dart';
import 'package:vbooks_source/pages/account/favoritebook.dart';
import 'package:vbooks_source/pages/components/widgetforscreen.dart';

class AccountInfoWidget extends StatefulWidget {
  const AccountInfoWidget({super.key});

  @override
  State<AccountInfoWidget> createState() => _AccountInfoWidgetState();
}

class _AccountInfoWidgetState extends State<AccountInfoWidget> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text('Thông tin tài khoản',),),
      body: ListView(
        children: [        
          AccountSelectWidget(
              value: 'Thông tin cá nhân',
              iconLeft: CupertinoIcons.person,
              iconRight: Icons.arrow_forward_ios,
              onTap: () {
                 Navigator.of(context).push(MaterialPageRoute(builder: (context) => AccountPersonalWidget()));
              },
              ),
              
          CustomDivider(height: 2,),
          SizedBox(
            height: 20,
          ),
          AccountInfoRow(label: 'Họ và tên', value: 'Ngô Trung Đạt'),
          AccountInfoRow(label: 'Email', value: 'ngotrungdat@gmail.com'),
          AccountInfoRow(label: 'Địa chỉ', value: '828 Su Vạn Hạnh P12 Q10'),
          SizedBox(
            height: 20,
          ),
          CustomDivider(height: 2,),
          SizedBox(
            height: 8,
          ),
          AccountShoppingRow(
              label: 'Số đơn hàng đặt thành công', value: '1 dơn hàng'),
          AccountShoppingRow(
              label: 'Số tiền đã thanh toán', value: '150.000.000.000 VNĐ'),
              SizedBox(
            height: 26,
          ),
         CustomDivider(height: 6,),
            AccountSelectWidget(
              value: 'Sản phẩm yêu thích',
              iconLeft: Icons.favorite,
              iconRight: Icons.arrow_forward_ios,
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => FavoriteScreen()));
              },
              ),
              CustomDivider(height: 2,),
              AccountSelectWidget(
              value: 'Lịch sử mua hàng',
              iconLeft: Icons.history,
              iconRight: Icons.arrow_forward_ios,
              onTap: () {
                
              },
              ),
CustomDivider(height: 2,),
              AccountSelectWidget(
              value: 'Voucher',
              iconLeft: CupertinoIcons.ticket_fill,
              iconRight: Icons.arrow_forward_ios,
              onTap: () {
                
              },
              ),
CustomDivider(height: 2,),
              AccountSelectWidget(
              value: 'Đăng xuất',
              iconLeft: Icons.logout,
              iconRight: Icons.arrow_forward_ios,
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=> AuthScreen()));
              },),
              CustomDivider(height: 2,),
        ],
        
      ),
    );
  }
}




