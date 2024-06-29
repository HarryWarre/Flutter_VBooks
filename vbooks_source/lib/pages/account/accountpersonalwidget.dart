import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vbooks_source/pages/account/changepasswordwidget.dart';
import 'package:vbooks_source/pages/account/updateinfowidget.dart';
import 'package:vbooks_source/pages/components/widgetforscreen.dart';

class AccountPersonalWidget extends StatefulWidget {
  const AccountPersonalWidget({super.key});

  @override
  State<AccountPersonalWidget> createState() => _AccountPersonalWidgetState();
}

class _AccountPersonalWidgetState extends State<AccountPersonalWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      children: [
        AccountSelectWidget(
          iconLeft: CupertinoIcons.person_fill,
          value: 'Thông tin của tôi',
          iconRight: Icons.arrow_forward_ios,
          onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => UpdateInfoScreen()));
          },
        ),
        CustomDivider(
          height: 2,
        ),
        AccountSelectWidget(
          iconLeft: Icons.key,
          value: 'Đổi mật khẩu',
          iconRight: Icons.arrow_forward_ios,
          onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => ChangePasswordWidget()));
              },
        ),
        CustomDivider(
          height: 2,
        ),
      ],
    ));
  }
}
