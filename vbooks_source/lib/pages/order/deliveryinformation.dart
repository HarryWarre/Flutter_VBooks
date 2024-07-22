// import 'package:flutter/material.dart';
// import 'package:jwt_decoder/jwt_decoder.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:vbooks_source/pages/order/Checkout.dart';

// import '../account/authwidget.dart';

// class ShippingInfoWidget extends StatefulWidget {
//   const ShippingInfoWidget({super.key});

//   @override
//   _ShippingInfoWidgetState createState() => _ShippingInfoWidgetState();
// }

// class _ShippingInfoWidgetState extends State<ShippingInfoWidget> {
//   String address = '...';
//   String phoneNumber = '...';

//   @override
//   void initState() {
//     super.initState();
//     _loadUserInfo();
//   }

//   Future<void> _loadUserInfo() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String? storedToken = prefs.getString('token');
//     if (storedToken != null && storedToken.isNotEmpty) {
//       if (!JwtDecoder.isExpired(storedToken)) {
//         Map<String, dynamic> jwtDecodedToken = JwtDecoder.decode(storedToken);
//         setState(() {
//           address = jwtDecodedToken['address'] ?? '...';
//           phoneNumber = jwtDecodedToken['phoneNumber'] ?? '...';
//         });
//       } else {
//         Navigator.of(context).pushReplacement(MaterialPageRoute(
//           builder: (context) => AuthScreen(),
//         ));
//       }
//     } else {
//       Navigator.of(context).pushReplacement(MaterialPageRoute(
//         builder: (context) => AuthScreen(),
//       ));
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           'Thông tin giao hàng',
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
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 StepWidget(
//                   stepNumber: 1,
//                   step: 'Giao hàng',
//                   isCompleted: true,
//                 ),
//                 StepWidget(
//                   stepNumber: 2,
//                   step: 'Thanh toán',
//                   isCompleted: false,
//                 ),
//                 StepWidget(
//                   stepNumber: 3,
//                   step: 'Kiểm tra',
//                   isCompleted: false,
//                 ),
//               ],
//             ),
//           ),
//           Expanded(
//             child: Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: ShippingForm(
//                 address: address,
//                 phoneNumber: phoneNumber,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class StepWidget extends StatelessWidget {
//   final int stepNumber;
//   final String step;
//   final bool isCompleted;

//   StepWidget(
//       {required this.stepNumber, required this.step, this.isCompleted = false});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         CircleAvatar(
//           backgroundColor:
//               isCompleted ? Color.fromRGBO(21, 139, 125, 1) : Colors.grey,
//           child: Text(
//             stepNumber.toString(),
//             style: TextStyle(color: Colors.white),
//           ),
//         ),
//         SizedBox(height: 5.0),
//         Text(step),
//       ],
//     );
//   }
// }

// class ShippingForm extends StatefulWidget {
//   final String address;
//   final String phoneNumber;

//   const ShippingForm(
//       {required this.address, required this.phoneNumber, Key? key})
//       : super(key: key);

//   @override
//   _ShippingFormState createState() => _ShippingFormState();
// }

// class _ShippingFormState extends State<ShippingForm> {
//   final _formKey = GlobalKey<FormState>();

//   late TextEditingController _nameController = TextEditingController();
//   late TextEditingController _addressController = TextEditingController();
//   late TextEditingController _phoneController = TextEditingController();
//   final TextEditingController _emailController = TextEditingController();

//   @override
//   void initState() {
//     super.initState();
//     _nameController = TextEditingController();
//     _addressController =
//         TextEditingController(text: widget.address); // Khởi tạo với dữ liệu
//     _phoneController =
//         TextEditingController(text: widget.phoneNumber); // Khởi tạo với dữ liệu
//   }

//   @override
//   void dispose() {
//     _nameController.dispose();
//     _addressController.dispose();
//     _phoneController.dispose();
//     _emailController.dispose();
//     super.dispose();
//   }

//   void _submitForm() {
//     if (_formKey.currentState!.validate()) {
//       // Xử lý logic khi form hợp lệ
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Thông tin giao hàng đã được gửi')),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Form(
//       key: _formKey,
//       child: ListView(
//         children: [
//           Padding(
//             padding: EdgeInsets.only(top: 10.0, bottom: 8.0),
//             child: Text('Họ và tên', style: TextStyle(fontSize: 18)),
//           ),
//           TextFormField(
//             controller: _nameController,
//             decoration: const InputDecoration(
//               labelText: 'Họ và tên',
//               border: OutlineInputBorder(),
//             ),
//             validator: (value) {
//               if (value == null || value.isEmpty) {
//                 return 'Vui lòng nhập họ và tên';
//               }
//               return null;
//             },
//           ),
//           Padding(
//             padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
//             child: Text('Địa chỉ', style: TextStyle(fontSize: 18)),
//           ),
//           TextFormField(
//             controller: _addressController,
//             decoration: const InputDecoration(
//               labelText: 'Địa chỉ',
//               border: OutlineInputBorder(),
//             ),
//             validator: (value) {
//               if (value == null || value.isEmpty) {
//                 return 'Vui lòng nhập địa chỉ';
//               }
//               return null;
//             },
//           ),
//           Padding(
//             padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
//             child: Text('Số điện thoại', style: TextStyle(fontSize: 18)),
//           ),
//           TextFormField(
//             controller: _phoneController,
//             decoration: const InputDecoration(
//               labelText: 'Số điện thoại',
//               border: OutlineInputBorder(),
//             ),
//             keyboardType: TextInputType.phone,
//             validator: (value) {
//               if (value == null || value.isEmpty) {
//                 return 'Vui lòng nhập số điện thoại';
//               }
//               if (!RegExp(r'^\d{10,11}$').hasMatch(value)) {
//                 return 'Số điện thoại không hợp lệ';
//               }
//               return null;
//             },
//           ),
//           Padding(
//             padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
//             child: Text('Email', style: TextStyle(fontSize: 18)),
//           ),
//           TextFormField(
//             controller: _emailController,
//             decoration: const InputDecoration(
//               labelText: 'Email',
//               border: OutlineInputBorder(),
//             ),
//             keyboardType: TextInputType.emailAddress,
//             validator: (value) {
//               if (value == null || value.isEmpty) {
//                 return 'Vui lòng nhập email';
//               }
//               if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
//                 return 'Email không hợp lệ';
//               }
//               return null;
//             },
//           ),
//           const SizedBox(height: 32.0),
//           ElevatedButton(
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => const PaymentPage()),
//               );
//             },
//             style: ElevatedButton.styleFrom(
//               padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
//               textStyle: const TextStyle(fontSize: 20),
//               backgroundColor: Color.fromRGBO(21, 139, 125, 1),
//             ),
//             child: const Text(
//               'Xác nhận thông tin',
//               style: TextStyle(color: Colors.white),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// // void main() {
// //   runApp(const MaterialApp(
// //     home: ShippingInfoWidget(),
// //   ));
// // }