import 'package:flutter/material.dart';
import '/../data/model/category.dart';
import '/../data/helper/db_helper.dart';
import 'category_add.dart';

class CategoryBuilder extends StatefulWidget {
  const CategoryBuilder({
    super.key,
  });

  @override
  State<CategoryBuilder> createState() => _CategoryBuilderState();
}

class _CategoryBuilderState extends State<CategoryBuilder> {
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  Future<List<CategoryModel>> _getCategorys() async {
    // thêm vào 1 dòng dữ liệu nếu getdata không có hoặc chưa có database
    return await _databaseHelper.categories();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<CategoryModel>>(
      future: _getCategorys(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final itemCat = snapshot.data![index];
              return _buildCategory(itemCat, context);
            },
          ),
        );
      },
    );
  }

  Widget _buildCategory(CategoryModel breed, BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            Container(
              height: 40.0,
              width: 40.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey[300],
              ),
              alignment: Alignment.center,
              child: Text(
                breed.id.toString(),
                style: const TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(width: 20.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    breed.name,
                    style: const TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  Text(breed.desc),
                ],
              ),
            ),
            IconButton(
                onPressed: () {
                  setState(() {
                    DatabaseHelper().deleteCategory(breed.id!);
                  });
                },
                icon: const Icon(
                  Icons.delete,
                  color: Colors.red,
                )),
            IconButton(
                onPressed: () {
                  setState(() {
                    Navigator.of(context)
                        .push(
                          MaterialPageRoute(
                            builder: (_) => CategoryAdd(
                              isUpdate: true,
                              categoryModel: breed,
                            ),
                            fullscreenDialog: true,
                          ),
                        )
                        .then((_) => setState(() {}));
                  });
                },
                icon: Icon(
                  Icons.edit,
                  color: Colors.yellow.shade800,
                ))
          ],
        ),
      ),
    );
  }
}
