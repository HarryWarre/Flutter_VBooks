import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vbooks_source/data/model/bookModel.dart';
import 'package:vbooks_source/data/provider/bookprovider.dart';
import 'package:vbooks_source/pages/components/button.dart';
import 'package:vbooks_source/pages/components/detail.dart';


class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true,
      title: Text('Trang Yêu thích',),),
      body: FutureBuilder<List<Book>>(
        future: ReadData.loadData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            final books = snapshot.data!;
            return ListView.builder(
              padding: const EdgeInsets.fromLTRB(12, 8, 8, 8),
              scrollDirection: Axis.vertical,
              addAutomaticKeepAlives: true,
              itemCount: books.length,
              itemBuilder: (context, index) {
                final book = books[index];
                return _buildBookItem('assets/images${book.img}', book.name!, book.price!,() =>  _navigateToDetailScreen(book));
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

  Widget _buildBookItem(
      String imagePath, String title, int price, VoidCallback onPressed) {
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
                    const SizedBox(height: 30),
                    Button(
                      width: 120,
                      height: 30,
                      text: 'Mua ngay',
                      onPressed: onPressed,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 70, 0, 0),
                child: IconButton(
                  icon: const Icon(CupertinoIcons.delete),
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _navigateToDetailScreen(Book book) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Detail(book: book))
    );
  }

}
