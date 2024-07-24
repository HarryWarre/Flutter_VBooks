import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vbooks_source/conf/const.dart';
import 'package:vbooks_source/pages/account/authwidget.dart';
import 'package:vbooks_source/services/apiservice.dart';
import 'package:vbooks_source/services/favoriteservice.dart';
import '../../data/model/productmodel.dart'; // Adjust the import path as needed
import 'detail.dart'; // Thêm import đến trang chi tiết

class HorizontalProductCard extends StatefulWidget {
  final Product product;
  const HorizontalProductCard({Key? key, required this.product}) : super(key: key);

  @override
  _HorizontalProductCardState createState() => _HorizontalProductCardState();
}

class _HorizontalProductCardState extends State<HorizontalProductCard> {
  bool _isFavorite = false;
  String token = '';
  String accountId = '';

  @override
  void initState() {
    super.initState();
    _loadToken();
  }

  Future<void> _loadToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? storedToken = prefs.getString('token');
    if (storedToken != null && storedToken.isNotEmpty) {
      if (JwtDecoder.isExpired(storedToken)) {
        setState(() {
          token = 'Invalid token';
        });

        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => AuthScreen(),
        ));
      } else {
        setState(() {
          token = storedToken;
          Map<String, dynamic> jwtDecodedToken = JwtDecoder.decode(token);
          accountId = jwtDecodedToken['_id'] ?? '...';
          _checkIfFavorite(); // Gọi sau khi tải token
        });
      }
    } else {
      setState(() {
        token = 'Invalid token';
      });
    }
  }

  Future<void> _checkIfFavorite() async {
    if (widget.product.id != null) {
      _isFavorite = await FavoriteService(ApiService()).isFavorite(accountId, widget.product.id!);
      setState(() {});
    } else {
      print('Product ID is null');
    }
  }

  Future<void> _toggleFavorite() async {
    if (widget.product.id != null) {
      if (_isFavorite) {
        await FavoriteService(ApiService()).deleteFavorite(accountId, widget.product.id!);
      } else {
        await FavoriteService(ApiService()).addFavorite(accountId, widget.product.id!);
      }
      setState(() {
        _isFavorite = !_isFavorite;
      });
    } else {
      print('Product ID is null');
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Detail(book: widget.product),
          ),
        );
      },
      child: Card(
        elevation: 0,
        color: Colors.white,
        child: Stack(
          children: [
            Row(
              children: [
                // Product Image
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.network(
                    widget.product.img ??
                        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSHBG4wkUg3Je8cRpQtDiiOhytiqLh29ydVmQ&s', // Sử dụng URL từ sản phẩm
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
                const SizedBox(width: 16.0),
                // Product Information
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.product.name!,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '${NumberFormat('###,###,###').format(widget.product.price!)} Đ',
                        style: const TextStyle(
                          fontSize: 14,
                          color: Color.fromRGBO(21, 139, 125, 1),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            // Heart Icon
            Positioned(
              top: 8.0,
              right: 8.0,
              child: IconButton(
                icon: Icon(
                  Icons.favorite,
                  color: _isFavorite ? primaryColor : Colors.grey[400],
                ),
                onPressed: _toggleFavorite,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
