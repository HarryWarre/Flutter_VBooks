import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vbooks_source/data/model/productmodel.dart';
import 'package:vbooks_source/pages/components/button.dart';
import 'package:vbooks_source/pages/components/detail.dart';
import 'package:vbooks_source/services/favoriteservice.dart';
import 'package:vbooks_source/services/apiservice.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  late FavoriteService favoriteService;
  late Future<List<Product>> favoriteProducts;
  String _accountId = '';
  late SharedPreferences prefs;

  @override
  void initState() {
    super.initState();
    favoriteService = FavoriteService(ApiService());
    favoriteProducts =
        Future.value([]); // Khởi tạo với Future trống hoặc giá trị mặc định
    initSharedPref();
  }

  void initSharedPref() async {
    prefs = await SharedPreferences.getInstance();
    String? storedToken = prefs.getString('token');
    if (storedToken != null && storedToken.isNotEmpty) {
      Map<String, dynamic> jwtDecodedToken = JwtDecoder.decode(storedToken);
      setState(() {
        _accountId = jwtDecodedToken['_id'];
        favoriteProducts = favoriteService.fetchFavorites(_accountId);
      });
    }
  }

  Future<void> _removeFavorite(String productId) async {
    try {
      await favoriteService.deleteFavorite(_accountId, productId);
      setState(() {
        favoriteProducts = favoriteService.fetchFavorites(_accountId);
      });
    } catch (e) {
      print('Error removing favorite: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Trang Yêu thích'),
      ),
      body: FutureBuilder<List<Product>>(
        future: favoriteProducts,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            final books = snapshot.data!;

            // Log danh sách sản phẩm
            print('Books: $books');

            return ListView.builder(
              padding: const EdgeInsets.fromLTRB(12, 8, 8, 8),
              scrollDirection: Axis.vertical,
              addAutomaticKeepAlives: true,
              itemCount: books.length,
              itemBuilder: (context, index) {
                final book = books[index];
                return _buildBookItem(
                  book.id ?? '',
                  book.img ?? '', // Đảm bảo đây là URL hợp lệ
                  book.name!,
                  book.price!,
                  () => _navigateToDetailScreen(book),
                );
              },
            );
          } else {
            return const Center(
              child: Text('No Data'),
            );
          }
        },
      ),
    );
  }

  Widget _buildBookItem(String id, String imagePath, String title, int price,
      VoidCallback onPressed) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        child: Container(
          height: 140,
          width: 335,
          padding: const EdgeInsets.fromLTRB(10, 8, 12, 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              FittedBox(
                fit: BoxFit.cover,
                child: Image.asset(
                  imagePath,
                  width: 120,
                  height: 120,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: 120,
                      height: 120,
                      color: Colors.grey, // Màu nền cho trường hợp lỗi
                      child: Center(
                        child: Icon(
                          Icons.image_not_supported,
                          color: Colors.white,
                          size: 50,
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          overflow: TextOverflow.ellipsis),
                    ),
                    Text(
                      '${NumberFormat('###,###,###').format(price)} Đ',
                      style: const TextStyle(color: Colors.teal),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 70, 0, 0),
                child: IconButton(
                    icon: const Icon(CupertinoIcons.delete),
                    onPressed: () {
                      _removeFavorite(id);
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _navigateToDetailScreen(Product book) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => Detail(book: book)));
  }
}
