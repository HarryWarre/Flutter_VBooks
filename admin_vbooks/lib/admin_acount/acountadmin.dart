// import 'package:admin_vbooks/admin_acount/detailacount.dart';
// import 'package:flutter/material.dart';

// void main() {
//   runApp(MaterialApp(
//     home: AccountManagementPage(),
//   ));
// }


// class AccountManagementPage extends StatelessWidget {
//   final List<User> users = [
//     User(id: 1, name: 'Alice'),
//     User(id: 2, name: 'Bob'),
//     User(id: 3, name: 'Charlie'),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         title: const Text(
//           'Quản lý tài khoản',
//           textAlign: TextAlign.center,
//         ),
//         centerTitle: true,
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back, color: Color.fromRGBO(21, 139, 125, 1)),
//           onPressed: () {
//             Navigator.pop(context); // Quay lại trang trước đó
//           },
//         ),
//       ),
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: <Widget>[
//           Container(                       
//             padding: EdgeInsets.fromLTRB(15, 12, 0, 12), // Lề trái là 35 pixels
//             decoration: BoxDecoration(
//               border: Border(
//                 top: BorderSide(
//                     width: 1.0,
//                     color: Colors.grey[400]!), // Đường viền màu xám phía trên
//                 bottom: BorderSide(
//                     width: 1.0,
//                     color: Colors.grey[400]!), // Đường viền màu xám phía dưới
//               ),
//             ),
//             child: Text(
//               'Danh sách tài khoản',
//               style: TextStyle(
//                 fontSize: 18.0,
//               ),
//               textAlign: TextAlign.start, // Căn chữ về phía trái
//             ),
//           ),

//           Expanded(
//             child: ListView.builder(
//               itemCount: users.length,
//               itemBuilder: (context, index) {
//                 return ListTile(
//                   leading: Icon(
//                     Icons.person,
//                     size: 36, // Kích thước của icon
//                     color: Color.fromRGBO(21, 139, 125, 1), // Màu sắc của icon
//                   ), // Icon person
//                   subtitle: Text('ID: ${users[index].id}'),
//                   title: Text(users[index].name),

//                   // Hiển thị tên người dùng
//                   onTap: () {
//                     // Chuyển đến trang chi tiết tài khoản
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(builder: (context) => UpdateInfoScreen()),
//                     );
//                   },
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }


// class User {
//   final int id;
//   final String name;

//   User({required this.id, required this.name});
// }
