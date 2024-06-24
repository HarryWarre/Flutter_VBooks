import 'package:flutter/material.dart';
import 'package:vbooks_source/pages/admin/orderdetailadminpage.dart';

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
  List<Map<String, String>> allOrders = [
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
    {
      'idDonHang': '000005',
      'ngayDat': '10/04/2024',
      'nguoiDat': 'Phạm Minh Đức',
      'tongTien': '50.000đ',
      'trangThai': 'Đang xử lý',
    },
    {
      'idDonHang': '000006',
      'ngayDat': '12/04/2024',
      'nguoiDat': 'Ngô Trung Đạt',
      'tongTien': '30.000đ',
      'trangThai': 'Hoàn tất',
    },
    {
      'idDonHang': '000007',
      'ngayDat': '13/04/2024',
      'nguoiDat': 'Phan Hoàng Việt',
      'tongTien': '55.000đ',
      'trangThai': 'Đang xử lý',
    },
  ];

  List<Map<String, String>> get filteredOrders {
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

  List<Map<String, String>> get paginatedOrders {
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
                  SizedBox(width: 2),
                  Expanded(
                    flex: 1,
                    child: DropdownButtonFormField<String>(
                      value: selectedFilter,
                      items: ['Tất cả', 'Hoàn tất', 'Đang xử lý', 'Bị hủy']
                          .map((status) => DropdownMenuItem(
                                child: Text(status),
                                value: status,
                              ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedFilter = value!;
                          currentPage = 1;
                        });
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(horizontal: 12),
                      ),
                    ),
                  ),
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
                    idDonHang: order['idDonHang']!,
                    ngayDat: order['ngayDat']!,
                    nguoiDat: order['nguoiDat']!,
                    tongTien: order['tongTien']!,
                    trangThai: order['trangThai']!,
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
            builder: (context) => OrderDetailAdminPage(
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
