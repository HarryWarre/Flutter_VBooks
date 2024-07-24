import 'package:admin_vbooks/pages/ordermanagement/orderdetailaminpage.dart';
import 'package:admin_vbooks/viewmodel/orderviewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class OrderAdminPage extends StatefulWidget {
  const OrderAdminPage({super.key});

  @override
  State<OrderAdminPage> createState() => _OrderAdminPageState();
}

class _OrderAdminPageState extends State<OrderAdminPage> {
  int currentPage = 1;
  int pageSize = 5;
  String searchQuery = '';
  String selectedFilter = 'Tất cả';
  List<Map<String, dynamic>> allOrders = [];

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, _fetchAllOrders);
  }

  Future<void> _fetchAllOrders() async {
    final orderViewModel = Provider.of<OrderViewModel>(context, listen: false);
    await orderViewModel.fetchAllOrders();
    setState(() {
      allOrders = orderViewModel.orders;
    });
  }

  List<Map<String, dynamic>> get filteredOrders {
    var orders = allOrders;

    if (searchQuery.isNotEmpty) {
      orders = orders.where((order) {
        return order['idDonHang']!.contains(searchQuery) ||
               order['nguoiDat']!.contains(searchQuery);
      }).toList();
    }

    if (selectedFilter != 'Tất cả') {
      orders = orders.where((order) {
        return order['trangThai'] == selectedFilter;
      }).toList();
    }

    return orders;
  }

  List<Map<String, dynamic>> get paginatedOrders {
    int start = (currentPage - 1) * pageSize;
    int end = start + pageSize;
    return filteredOrders.sublist(
      start,
      end > filteredOrders.length ? filteredOrders.length : end,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Quản lý đơn hàng',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: SizedBox(
                      height: 47,
                      child: TextField(
                        decoration: InputDecoration(
                          labelText: 'Tìm kiếm',
                          prefixIcon: Icon(Icons.search),
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (value) {
                          setState(() {
                            searchQuery = value;
                            currentPage = 1;
                          });
                        },
                      ),
                    ),
                  ),
                  // SizedBox(width: 2),
                  // Expanded(
                  //   flex: 1,
                  //   child: DropdownButtonFormField<String>(
                  //     value: selectedFilter,
                  //     items: ['Tất cả', 'Hoàn tất', 'Đang xử lý', 'Bị hủy']
                  //         .map((status) => DropdownMenuItem(
                  //               child: Text(status),
                  //               value: status,
                  //             ))
                  //         .toList(),
                  //     onChanged: (value) {
                  //       setState(() {
                  //         selectedFilter = value!;
                  //         currentPage = 1;
                  //       });
                  //     },
                  //     decoration: InputDecoration(
                  //       border: OutlineInputBorder(),
                  //       contentPadding: EdgeInsets.symmetric(horizontal: 12),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.fromLTRB(0, 16, 0, 0),
                itemCount: paginatedOrders.length,
                itemBuilder: (context, index) {
                  final order = paginatedOrders[index];
                  return OrderContainer(
                    idDonHang: order['idDonHang'] ?? 'N/A',
                    ngayDat: order['orderDate'] ?? 'N/A',
                    nguoiDat: order['nguoiDat'] ?? 'N/A',
                    tongTien: order['totalAmount'] ?? '0',
                    trangThai: order['status'] ?? 'N/A',
                    diaChi: order['address'] ?? 'N/A',
                    soDienThoai: order['phoneNumber'] ?? 'N/A',
                    phuongThucThanhToan: order['paymentMethodId'] ?? 'N/A',
                  );
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: currentPage > 1
                      ? () {
                          setState(() {
                            currentPage--;
                          });
                        }
                      : null,
                ),
                Text('$currentPage / ${(filteredOrders.length / pageSize).ceil()}'),
                IconButton(
                  icon: Icon(Icons.arrow_forward),
                  onPressed: currentPage <
                          (filteredOrders.length / pageSize).ceil()
                      ? () {
                          setState(() {
                            currentPage++;
                          });
                        }
                      : null,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class OrderContainer extends StatelessWidget {
  final String idDonHang;
  final String ngayDat;
  final String nguoiDat;
  final String tongTien;
  final String trangThai;
  final String diaChi;
  final String soDienThoai;
  final String phuongThucThanhToan;

  const OrderContainer({
    required this.idDonHang,
    required this.ngayDat,
    required this.nguoiDat,
    required this.tongTien,
    required this.trangThai,
    required this.diaChi,
    required this.soDienThoai,
    required this.phuongThucThanhToan,
  });

  String formatCurrency(String amount) {
    final formatter = NumberFormat.currency(locale: 'vi_VN', symbol: '₫');
    double value = double.tryParse(amount) ?? 0;
    return formatter.format(value);
  }

  @override
  Widget build(BuildContext context) {
    Color statusColor;

    switch (trangThai) {
      case 'Đang xử lý':
        statusColor = Color(0xFFEFCC11);
        break;
      case 'Bị hủy':
        statusColor = Color(0xFFFF0808);
        break;
      default:
        statusColor = Color(0xFF158B7D);
    }

    DateTime dateTime = DateTime.parse(ngayDat);
    String formattedDate = DateFormat('dd/MM/yyyy').format(dateTime);

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => OrderDetailAdminPage(
              idDonHang: idDonHang,
              ngayDat: ngayDat,
              nguoiDat: nguoiDat,
              tongTien: tongTien,
              trangThai: trangThai,
              diaChi: diaChi,
              soDienThoai: soDienThoai,
              phuongThucThanhToan: phuongThucThanhToan,
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16.0),
        padding: const EdgeInsets.all(16.0),
        height: 200,
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Color(0xFFE5E5E5), width: 1)),
        ),
        child: Row(
          children: [
            Expanded(
              flex: 6,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center, // Centering vertically
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    idDonHang,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Ngày mua: $formattedDate',
                    style: TextStyle(fontSize: 18),
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Người nhận: $nguoiDat',
                    style: TextStyle(fontSize: 18),
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Tổng tiền: ${formatCurrency(tongTien)}',
                    style: TextStyle(fontSize: 18),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: Center(
                child: Container(
                  width: 90,
                  height: 30,
                  decoration: BoxDecoration(
                    color: statusColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: Text(
                      trangThai,
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

