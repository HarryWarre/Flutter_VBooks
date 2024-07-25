import 'package:admin_vbooks/admin_acount/detailacount.dart';
import 'package:admin_vbooks/connectApi/accountapi.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: AccountTest(),
  ));
}

class AccountTest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Quản lý tài khoản',
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Color.fromRGBO(21, 139, 125, 1)),
          onPressed: () {
            Navigator.pop(context); // Quay lại trang trước đó
          },
        ),
      ),
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              padding:
                  EdgeInsets.fromLTRB(15, 12, 0, 12), // Lề trái là 35 pixels
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                      width: 1.0,
                      color: Colors.grey[400]!), // Đường viền màu xám phía trên
                  bottom: BorderSide(
                      width: 1.0,
                      color: Colors.grey[400]!), // Đường viền màu xám phía dưới
                ),
              ),
              child: Text(
                'Danh sách tài khoản',
                style: TextStyle(
                  fontSize: 18.0,
                ),
                textAlign: TextAlign.start, // Căn chữ về phía trái
              ),
            ),
            Expanded(
              child: FutureBuilder(
                future: fetchItem(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data?.length,
                      itemBuilder: (context, index) {
                        final item = snapshot.data?[index];
                        return ListTile(
                          leading: Icon(
                            Icons.person,
                            size: 36, // Kích thước của icon
                            color: Color.fromRGBO(
                                21, 139, 125, 1), // Màu sắc của icon
                          ),
                          subtitle: Text('Email: ${item.email}'),
                          title: Text(item.fullName),
                          onTap: () {
                            // Chuyển đến trang chi tiết tài khoản
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => DetailScreen(
                                          email: item.email ?? '',
                                          dob: item.dob ?? '',
                                          fullName: item.fullName ?? '',
                                          phoneNumber: item.phoneNumber ?? '',
                                          sex: item.sex ?? 0,
                                          id: item.id ?? '',
                                        )));
                          },
                        );
                      },
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text(snapshot.error.toString()),
                    );
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ),
          ]),
    );
  }
}
