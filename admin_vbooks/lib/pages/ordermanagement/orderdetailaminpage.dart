import 'package:flutter/material.dart';

class OrderDetailAdminPage extends StatefulWidget {
  final String idDonHang;
  final String ngayDat;
  final String nguoiDat;
  final String tongTien;
  String trangThai;

  OrderDetailAdminPage({
    required this.idDonHang,
    required this.ngayDat,
    required this.nguoiDat,
    required this.tongTien,
    required this.trangThai,
  });

  @override
  State<OrderDetailAdminPage> createState() => _OrderDetailAdminPageState();
}

class _OrderDetailAdminPageState extends State<OrderDetailAdminPage> {
  bool showConfirmButton = false;
  String searchQuery = '';
  int currentPage = 1;
  int pageSize = 10;
  String? selectedStatus;

  @override
  void initState() {
    super.initState();
    selectedStatus = widget.trangThai;
  }

  void _confirmCompletion() {
    setState(() {
      if (selectedStatus != null) {
        widget.trangThai = selectedStatus!;
        showConfirmButton = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Chi tiết đơn hàng',
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ThongTinDonHang(
              idDonHang: widget.idDonHang,
              ngayDat: widget.ngayDat,
              nguoiDat: widget.nguoiDat,
              tongTien: widget.tongTien,
              trangThai: widget.trangThai,
              selectedStatus: selectedStatus,
              showConfirmButton: showConfirmButton,
              onStatusChanged: (String? newStatus) {
                setState(() {
                  selectedStatus = newStatus;
                });
              },
            ),
            SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
              child: Text(
                'Thông tin người nhận',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 10),
            ThongTinNguoiDat(
              nguoiDat: widget.nguoiDat,
              diaChi: '828 Sư Vạn Hạnh, Phường 13, Quận 10, TP.HCM',
              soDienThoai: '0909372940',
            ),
            SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
              child: Text(
                'Sản phẩm đã mua',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 10),
            SanPhamDaMua(
              tenSach: 'To Kill Mocking Bird',
              gia: '25.000đ',
              soLuong: 1,
              urlHinh: 'assets/mockingbird.jpg',
            ),
            SanPhamDaMua(
              tenSach: 'Breathing room',
              gia: '25.000đ',
              soLuong: 1,
              urlHinh: 'assets/breathingroom.jpg',
            ),
            SizedBox(height: 15),
            if (showConfirmButton)
              Center(
                child: Column(
                  children: [
                    SizedBox(
                      width: 400,
                      child: ElevatedButton(
                        onPressed: _confirmCompletion,
                        child: Text(
                          'Hoàn thành',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF158B7D),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
      floatingActionButton: !showConfirmButton
          ? FloatingActionButton(
              onPressed: () {
                setState(() {
                  showConfirmButton = true;
                });
              },
              backgroundColor: Color(0xFFE8E9F1),
              shape: CircleBorder(),
              child: Icon(
                Icons.edit,
                color: Color(0xFF158B7D),
              ),
            )
          : null,
    );
  }
}

class ThongTinDonHang extends StatelessWidget {
  final String idDonHang;
  final String ngayDat;
  final String nguoiDat;
  final String tongTien;
  final String trangThai;
  final String? selectedStatus;
  final bool showConfirmButton;
  final ValueChanged<String?> onStatusChanged;

  const ThongTinDonHang({
    required this.idDonHang,
    required this.ngayDat,
    required this.nguoiDat,
    required this.tongTien,
    required this.trangThai,
    required this.selectedStatus,
    required this.showConfirmButton,
    required this.onStatusChanged,
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

    return Container(
      padding: const EdgeInsets.fromLTRB(8, 16, 8, 0),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0xFFE5E5E5), width: 1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Mã đơn hàng: $idDonHang',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          showConfirmButton
              ? DropdownButton<String>(
                  value: selectedStatus,
                  items: <String>['Đang xử lý', 'Hoàn tất', 'Bị hủy']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: onStatusChanged,
                )
              : Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: statusColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        'Đơn hàng $trangThai',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
          SizedBox(height: 8),
          Text('Ngày mua: $ngayDat', style: TextStyle(fontSize: 16)),
          Text('Tổng tiền: $tongTien', style: TextStyle(fontSize: 16)),
          Text('Ghi chú: Giao hàng trước 5h chiều',
              style: TextStyle(fontSize: 16)),
          Text('Phương thức vận chuyển: Giao hàng tiêu chuẩn',
              style: TextStyle(fontSize: 16)),
          Text('Phương thức thanh toán: Ví MoMo',
              style: TextStyle(fontSize: 16)),
          SizedBox(height: 16),
        ],
      ),
    );
  }
}

class ThongTinNguoiDat extends StatelessWidget {
  final String nguoiDat;
  final String diaChi;
  final String soDienThoai;

  const ThongTinNguoiDat({
    required this.nguoiDat,
    required this.diaChi,
    required this.soDienThoai,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: Color(0xFFE5E5E5), width: 1),
          bottom: BorderSide(color: Color(0xFFE5E5E5), width: 1),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 16),
          Text('Người nhận: $nguoiDat', style: TextStyle(fontSize: 16)),
          Text('Địa chỉ: $diaChi', style: TextStyle(fontSize: 16)),
          Text('Số điện thoại: $soDienThoai', style: TextStyle(fontSize: 16)),
          SizedBox(height: 16),
        ],
      ),
    );
  }
}

class SanPhamDaMua extends StatelessWidget {
  final String tenSach;
  final String gia;
  final int soLuong;
  final String urlHinh;

  const SanPhamDaMua({
    required this.tenSach,
    required this.gia,
    required this.soLuong,
    required this.urlHinh,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(border: Border.all(color: Color(0xFFB6B6B6))),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            urlHinh,
            width: 150,
            height: 150,
            fit: BoxFit.cover,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 34),
                Text(tenSach,
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                SizedBox(height: 4),
                Text(gia, style: TextStyle(fontSize: 16)),
                SizedBox(height: 4),
                Text('Số lượng: $soLuong', style: TextStyle(fontSize: 16)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
