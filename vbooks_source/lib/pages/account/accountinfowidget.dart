import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AccountInfoWidget extends StatefulWidget {
  const AccountInfoWidget({super.key});

  @override
  State<AccountInfoWidget> createState() => _AccountInfoWidgetState();
}

class _AccountInfoWidgetState extends State<AccountInfoWidget> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [        
          AccountSelectWidget(
              value: 'Thông tin cá nhân',
              iconLeft: Icons.person,
              iconRight: Icons.arrow_forward_ios),
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
              iconRight: Icons.arrow_forward_ios),
              CustomDivider(height: 2,),
              AccountSelectWidget(
              value: 'Lịch sử mua hàng',
              iconLeft: Icons.history,
              iconRight: Icons.arrow_forward_ios),
CustomDivider(height: 2,),
              AccountSelectWidget(
              value: 'Voucher',
              iconLeft: CupertinoIcons.ticket_fill,
              iconRight: Icons.arrow_forward_ios),
CustomDivider(height: 2,),
              AccountSelectWidget(
              value: 'Thông tin cá nhân',
              iconLeft: Icons.logout,
              iconRight: Icons.arrow_forward_ios),
              CustomDivider(height: 2,),
        ],
        
      ),
    );
  }
}




class AccountShoppingRow extends StatelessWidget {
  final String label;
  final String value;

  AccountShoppingRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 2),
      child: Row(
        children: [
          Container(
            width: 200,
            padding: const EdgeInsets.only(right: 12),
            child: Text(
              label,
              style: TextStyle(fontFamily: 'Italic'),
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(left: 15),
              child: Text(
                value,
                style: TextStyle(fontFamily: 'Italic'),
                overflow: TextOverflow.ellipsis, // tránh overflow
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AccountInfoRow extends StatelessWidget {
  final String label;
  final String value;

  AccountInfoRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 2),
      child: Row(
        children: [
          Container(
            width: 100,
            padding: const EdgeInsets.only(right: 12),
            child: Text(
              label,
              style: TextStyle(fontFamily: 'Italic'),
              overflow: TextOverflow.ellipsis, // tránh overflow
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(left: 15),
              child: Text(
                value,
                style: TextStyle(fontFamily: 'Italic'),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AccountSelectWidget extends StatelessWidget {
  final String value;
  final IconData iconLeft;
  final IconData iconRight;

  AccountSelectWidget(
      {required this.value, required this.iconLeft, required this.iconRight});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        iconLeft,
        size: 26,
        color: Colors.teal,
      ),
      title: Text(value),
      trailing: Icon(
        iconRight,
        weight: 16,
        color: Colors.teal,
      ),
      onTap: () {},
    );
  }
}

class CustomDivider extends StatelessWidget {
  final double height;
  final Color color;
  
  CustomDivider({this.height = 2, this.color = Colors.grey});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      color: Colors.grey[400],
      width: double.infinity,
    );
  }
}