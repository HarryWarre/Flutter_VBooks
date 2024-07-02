import 'package:flutter/material.dart';
import 'package:vbooks_source/pages/order/orderdetailpage.dart';

class OrderMainPage extends StatefulWidget {
  const OrderMainPage({super.key});

  @override
  State<OrderMainPage> createState() => _OrderMainPageState();
}

class _OrderMainPageState extends State<OrderMainPage>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;
  List<Map<String, String>> allOrders = [];
  List<Map<String, String>> filteredOrders = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _tabController?.addListener(_filterOrders);
    allOrders = [
      {
        'idDonHang': '000001',
        'ngayDat': '06/04/2024',
        'nguoiDat': 'Lưu Chí Hùng',
        'tongTien': '50.000đ',
        'trangThai': 'Hoàn tất',
      },
      {
        'idDonHang': '000002',
        'ngayDat': '07/04/2024',
        'nguoiDat': 'Lưu Chí Hùng',
        'tongTien': '70.000đ',
        'trangThai': 'Đang xử lý',
      },
      {
        'idDonHang': '000003',
        'ngayDat': '08/04/2024',
        'nguoiDat': 'Lưu Chí Hùng',
        'tongTien': '30.000đ',
        'trangThai': 'Bị hủy',
      },
      {
        'idDonHang': '000004',
        'ngayDat': '09/04/2024',
        'nguoiDat': 'Lưu Chí Hùng',
        'tongTien': '30.000đ',
        'trangThai': 'Bị hủy',
      },
    ];
    _filterOrders();
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
          filteredOrders = allOrders.where((order) => order['trangThai'] == 'Đang xử lý').toList();
          break;
        case 2:
          filteredOrders = allOrders.where((order) => order['trangThai'] == 'Hoàn tất').toList();
          break;
        case 3:
          filteredOrders = allOrders.where((order) => order['trangThai'] == 'Bị hủy').toList();
          break;
        default:
          filteredOrders = allOrders;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Đơn hàng',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
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
              idDonHang: order['idDonHang']!,
              ngayDat: order['ngayDat']!,
              nguoiDat: order['nguoiDat']!,
              tongTien: order['tongTien']!,
              trangThai: order['trangThai']!,
            );
          },
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
        height: 180,
        decoration: BoxDecoration(
          border:
              Border(bottom: BorderSide(color: Color(0xFFE5E5E5), width: 1)),
        ),
        child: Row(
          children: [
            Expanded(
              flex: 6,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    idDonHang,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Ngày mua: $ngayDat',
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Người nhận: $nguoiDat',
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Tổng tiền: $tongTien',
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 20),
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