import 'package:admin_vbooks/services/apiservice.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:admin_vbooks/services/orderservice.dart';
import 'package:provider/provider.dart';
import 'package:admin_vbooks/viewmodel/orderdetailviewmodel.dart';

class OrderDetailAdminPage extends StatefulWidget {
  final String idDonHang;
  final String ngayDat;
  final String nguoiDat;
  final String tongTien;
  String trangThai;
  final String diaChi;
  final String soDienThoai;
  final String phuongThucThanhToan;

  OrderDetailAdminPage({
    required this.idDonHang,
    required this.ngayDat,
    required this.nguoiDat,
    required this.tongTien,
    required this.trangThai,
    required this.diaChi,
    required this.soDienThoai,
    required this.phuongThucThanhToan,
  });

  @override
  State<OrderDetailAdminPage> createState() => _OrderDetailAdminPageState();
}

class _OrderDetailAdminPageState extends State<OrderDetailAdminPage> {
  String? selectedStatus;

  @override
  void initState() {
    super.initState();
    selectedStatus = widget.trangThai;

    // Fetch order details
    Future.microtask(() =>
        Provider.of<OrderDetailViewModel>(context, listen: false)
            .fetchOrderDetails(widget.idDonHang));
  }

  void _showStatusDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              backgroundColor: Colors.white,
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Text(
                      'Đổi trạng thái đơn hàng thành:',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                    ),
                  ),
                  Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 8.0,
                    children: _buildStatusButtons(setState),
                  ),
                ],
              ),
              actions: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        child: Text('Hủy',
                            style: TextStyle(
                                color: Color(0xFF158B7D), fontSize: 16)),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                          padding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 40),
                          side: BorderSide(color: Color(0xFF158B7D)),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: ElevatedButton(
                        child: Text('Xác nhận',
                            style:
                                TextStyle(color: Colors.white, fontSize: 16)),
                        onPressed: () async {
                          if (selectedStatus != null &&
                              selectedStatus != widget.trangThai) {
                            final orderService = OrderService(ApiService());
                            try {
                              await orderService.updateOrderStatus(
                                orderId: widget.idDonHang,
                                status: selectedStatus!,
                              );
                              setState(() {
                                widget.trangThai = selectedStatus!;
                              });
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content:
                                        Text('Cập nhật trạng thái thành công')),
                              );
                            } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content:
                                        Text('Cập nhật trạng thái thất bại')),
                              );
                            }
                          }
                          Navigator.of(context).pop();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF158B7D),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                          padding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 30),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        );
      },
    );
  }

  List<Widget> _buildStatusButtons(
      void Function(void Function()) dialogSetState) {
    List<String> statuses = ['Đang xử lý', 'Hoàn tất', 'Bị hủy'];
    statuses.remove(widget.trangThai);
    return statuses
        .map((status) => _buildStatusButton(status, dialogSetState))
        .toList();
  }

  Widget _buildStatusButton(
      String status, void Function(void Function()) dialogSetState) {
    Color borderColor;
    Color backgroundColor;
    Color textColor;

    bool isSelected = selectedStatus == status;

    switch (status) {
      case 'Đang xử lý':
        backgroundColor = isSelected ? Color(0xFFEFCC11) : Colors.white;
        textColor = isSelected ? Colors.white : Color(0xFFEFCC11);
        borderColor = Color(0xFFEFCC11);
        break;
      case 'Hoàn tất':
        backgroundColor = isSelected ? Color(0xFF158B7D) : Colors.white;
        textColor = isSelected ? Colors.white : Color(0xFF158B7D);
        borderColor = Color(0xFF158B7D);
        break;
      case 'Bị hủy':
        backgroundColor = isSelected ? Color(0xFFFF0808) : Colors.white;
        textColor = isSelected ? Colors.white : Color(0xFFFF0808);
        borderColor = Color(0xFFFF0808);
        break;
      default:
        backgroundColor = Colors.white;
        textColor = Colors.black;
        borderColor = Colors.black;
    }

    return GestureDetector(
      onTap: () {
        dialogSetState(() {
          selectedStatus = status;
        });
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 4),
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: borderColor,
            width: 2,
          ),
        ),
        child: Center(
          child: Text(
            status,
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
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
        padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ThongTinDonHang(
              idDonHang: widget.idDonHang,
              ngayDat: widget.ngayDat,
              nguoiDat: widget.nguoiDat,
              tongTien: widget.tongTien,
              trangThai: widget.trangThai,
              phuongThucThanhToan: widget.phuongThucThanhToan,
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
              diaChi: widget.diaChi,
              soDienThoai: widget.soDienThoai,
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
            Consumer<OrderDetailViewModel>(
              builder: (context, orderDetailViewModel, child) {
                if (orderDetailViewModel.isLoading) {
                  return Center(child: CircularProgressIndicator());
                } else if (orderDetailViewModel.errorMessage.isNotEmpty) {
                  return Center(child: Text(orderDetailViewModel.errorMessage));
                } else {
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: orderDetailViewModel.orderDetails.length,
                    itemBuilder: (context, index) {
                      final orderDetail =
                          orderDetailViewModel.orderDetails[index];
                      return SanPhamDaMua(
                        tenSach: orderDetail['productName'],
                        gia: NumberFormat.currency(locale: 'vi', symbol: '₫')
                            .format(orderDetail['price']),
                        soLuong: orderDetail['quantity'],
                        urlHinh: orderDetail['productImage'],
                      );
                    },
                  );
                }
              },
            ),
            SizedBox(height: 15),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showStatusDialog,
        backgroundColor: Color(0xFFE8E9F1),
        shape: CircleBorder(),
        child: Icon(
          Icons.edit,
          color: Color(0xFF158B7D),
        ),
      ),
    );
  }
}

class ThongTinDonHang extends StatelessWidget {
  final String idDonHang;
  final String ngayDat;
  final String nguoiDat;
  final String tongTien;
  final String trangThai;
  final String phuongThucThanhToan;

  const ThongTinDonHang({
    required this.idDonHang,
    required this.ngayDat,
    required this.nguoiDat,
    required this.tongTien,
    required this.trangThai,
    required this.phuongThucThanhToan,
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

    DateTime dateTime = DateTime.parse(ngayDat);
    String formattedDate = DateFormat('dd/MM/yyyy').format(dateTime);
    String formattedTongTien = NumberFormat.currency(locale: 'vi', symbol: '₫')
        .format(double.parse(tongTien));

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0xFFE5E5E5), width: 1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Mã đơn hàng: $idDonHang',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Row(
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
          Text('Ngày mua: $formattedDate', style: TextStyle(fontSize: 16)),
          SizedBox(height: 8),
          Text('Tổng tiền: $formattedTongTien', style: TextStyle(fontSize: 16)),
          SizedBox(height: 8),
          Text('Phương thức vận chuyển: Giao hàng tiêu chuẩn',
              style: TextStyle(fontSize: 16)),
          SizedBox(height: 8),
          Text('Phương thức thanh toán: $phuongThucThanhToan',
              style: TextStyle(fontSize: 16)),
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
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      decoration: BoxDecoration(
        border: Border(
            bottom: BorderSide(color: Color(0xFFE5E5E5), width: 1),
            top: BorderSide(color: Color(0xFFE5E5E5), width: 1)),
      ),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Tên: $nguoiDat', style: TextStyle(fontSize: 16)),
          SizedBox(height: 8),
          Text('Địa chỉ: $diaChi', style: TextStyle(fontSize: 16)),
          SizedBox(height: 8),
          Text('Số điện thoại: $soDienThoai', style: TextStyle(fontSize: 16)),
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
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0xFFE5E5E5), width: 1)),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.asset(
              'assets/images/product/${urlHinh}',
              width: 100,
              height: 150,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: 100,
                  height: 150,
                  color: Colors.white,
                  child: Icon(
                    Icons.image_not_supported,
                    color: Colors.grey,
                    size: 50,
                  ),
                );
              },
            ),
          ),
          SizedBox(width: 8),
          Expanded(
            child: Container(
              height: 100, 
              child: Align(
                alignment: Alignment.centerLeft,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      tenSach,
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    Text('Giá: $gia', style: TextStyle(fontSize: 16)),
                    SizedBox(height: 10),
                    Text('Số lượng: $soLuong', style: TextStyle(fontSize: 16)),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

