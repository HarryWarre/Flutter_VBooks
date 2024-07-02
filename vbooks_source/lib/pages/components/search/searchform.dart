import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:vbooks_source/pages/components/detail.dart';

import '../../../data/model/productmodel.dart';
import '../../../data/provider/productprovider.dart';
import 'productsearchresults.dart';

/*
  Trang này bao gồm widget tìm kiếm và kết quả trả về.
  Kết quả trả về có 2 options cho người dùng:
  1. Trả thẳng trực tiếp sản phẩm mà người dùng chọn trên thanh gợi ý khi nhập
  2. Sau khi người dùng nhập từ khóa và tìm kiếm thì trả về trang sản phẩm theo từ khóa đó.
 */
class SearchWidget extends StatefulWidget {
  const SearchWidget({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SearchWidgetState createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  final TextEditingController _controller = TextEditingController();
  final ReadData _productProvider = ReadData();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity, // Chiều rộng tối đa
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(248, 249, 254, 1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          const Icon(Icons.search, size: 24),
          const SizedBox(width: 15),
          Expanded(
            child: TypeAheadField<Product>(
              textFieldConfiguration: TextFieldConfiguration(
                controller: _controller,
                decoration: const InputDecoration(
                  hintText: 'Tìm kiếm',
                  hintStyle: TextStyle(color: Color.fromRGBO(143, 144, 152, 1)),
                  border: InputBorder.none,
                ),
                onSubmitted: _handleSearch,
              ),
              suggestionsCallback: _productProvider.searchProducts,
              itemBuilder: (context, Product suggestion) {
                return ListTile(
                  title: Text(suggestion.name!),
                );
              },
              onSuggestionSelected: (Product suggestion) {
                _controller.text = suggestion.name!;
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => Detail(book: suggestion),
                ));
              },
            ),
          ),
        ],
      ),
    );
  }

  void _handleSearch(String keyword) {
    if (keyword.isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ProductSearchResults(keyword: keyword),
        ),
      );
    }
  }
}

class ProductDetail extends StatelessWidget {
  final Product product;

  const ProductDetail({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.name!),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Tên sản phẩm: ${product.name!}'),
            const SizedBox(height: 8),
            Text('Giá: ${product.price!} Đ'),
            const SizedBox(height: 8),
            Image.asset('assets/images/product/${product.img}'),
            const SizedBox(height: 8),
            Text('Mô tả: ${product.des!}'),
          ],
        ),
      ),
    );
  }
}
