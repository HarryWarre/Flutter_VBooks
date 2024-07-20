import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:vbooks_source/services/apiservice.dart';
import 'package:vbooks_source/viewmodel/orderviewmodel.dart';
import 'package:vbooks_source/pages/order/orderdetailpage.dart';

class OrderMainPage extends StatefulWidget {
  const OrderMainPage({super.key});

  @override
  State<OrderMainPage> createState() => _OrderMainPageState();
}

class _OrderMainPageState extends State<OrderMainPage>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;
  List<Map<String, dynamic>> allOrders = [];
  List<Map<String, dynamic>> filteredOrders = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _tabController?.addListener(_filterOrders);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchOrders();
    });
  }

  @override
  void dispose() {
    _tabController?.removeListener(_filterOrders);
    _tabController?.dispose();
    super.dispose();
  }

  void _filterOrders() {
    setState(() {
      switch (_tabController?.index) {
        case 1:
          filteredOrders = allOrders
              .where((order) => order['status'] == 'Đang xử lý')
              .toList();
          break;
        case 2:
          filteredOrders = allOrders
              .where((order) => order['status'] == 'Hoàn tất')
              .toList();
          break;
        case 3:
          filteredOrders =
              allOrders.where((order) => order['status'] == 'Bị hủy').toList();
          break;
        default:
          filteredOrders = allOrders;
      }
    });
  }

  Future<void> _fetchOrders() async {
    final orderViewModel = Provider.of<OrderViewModel>(context, listen: false);
    await orderViewModel
        .fetchOrders('6697f90c6d89802072662ad6'); // Replace with actual user ID
    setState(() {
      allOrders = orderViewModel.orders;
      _filterOrders();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Đơn hàng',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        bottom: TabBar(
          controller: _tabController,
          labelStyle: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
          unselectedLabelStyle: TextStyle(fontSize: 14.0),
          indicatorColor: Color(0xFF158B7D),
          labelColor: Color(0xFF158B7D),
          unselectedLabelColor: Colors.grey,
          tabs: [
            Tab(text: 'Tất cả'),
            Tab(text: 'Đang xử lý'),
            Tab(text: 'Hoàn tất'),
            Tab(text: 'Bị hủy'),
          ],
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.fromLTRB(0, 16, 0, 0),
        itemCount: filteredOrders.length,
        itemBuilder: (context, index) {
          final order = filteredOrders[index];
          return OrderContainer(
            idDonHang: order['_id']!,
            ngayDat: order['orderDate']!,
            nguoiDat: order[
                'userId']!, // This might need adjustment based on actual data
            tongTien: order['totalAmount'].toString(),
            trangThai: order['status']!,
          );
        },
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

  const OrderContainer({
    required this.idDonHang,
    required this.ngayDat,
    required this.nguoiDat,
    required this.tongTien,
    required this.trangThai,
  });

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

    // Convert the date to DD/MM/YYYY format
    DateTime dateTime = DateTime.parse(ngayDat);
    String formattedDate = DateFormat('dd/MM/yyyy').format(dateTime);

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => OrderDetailPage(
              idDonHang: idDonHang,
              ngayDat: ngayDat,
              nguoiDat: nguoiDat,
              tongTien: tongTien,
              trangThai: trangThai,
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16.0),
        padding: const EdgeInsets.all(16.0),
        height: 200, // Đặt một chiều cao cố định nếu cần
        decoration: BoxDecoration(
          border:
              Border(bottom: BorderSide(color: Color(0xFFE5E5E5), width: 1)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              flex: 6,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Hiện tại đã bị bỏ qua, có thể thêm lại nếu cần
                  // Text(
                  //   idDonHang,
                  //   style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  // ),
                  SizedBox(height: 5),
                  Text(
                    'Ngày mua: $formattedDate',
                    style: TextStyle(fontSize: 18),
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Người nhận: $nguoiDat',
                    style: TextStyle(fontSize: 18),
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Tổng tiền: $tongTien',
                    style: TextStyle(fontSize: 18),
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
            SizedBox(width: 8),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8),
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
                      overflow: TextOverflow.ellipsis,
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
