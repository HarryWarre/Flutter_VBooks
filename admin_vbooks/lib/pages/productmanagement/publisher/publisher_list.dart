import 'package:admin_vbooks/pages/productmanagement/product/product_add.dart';
import 'package:admin_vbooks/pages/productmanagement/publisher/publisher_add.dart';
import 'package:admin_vbooks/viewmodel/categoryviewmodel.dart';
import 'package:admin_vbooks/viewmodel/publisherviewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../components/confirmdeletedialog.dart';
import '../../../components/uploadfile.dart';
import '../../../config/const.dart';
import 'package:admin_vbooks/pages/productmanagement/productmanagement.dart';

class PublisherList extends StatefulWidget {
  const PublisherList({super.key});

  @override
  State<PublisherList> createState() => _PublisherListState();
}

class _PublisherListState extends State<PublisherList> {
  final List<String> _selectedPublisher = [];

  @override
  void initState() {
    super.initState();
    _loadPublishers();
  }

  void _loadPublishers() async {
    final publisherViewModel = context.read<PublisherViewModel>();
    await publisherViewModel.fetchPublisher(); // Tải dữ liệu ngay khi trang được tạo
  }

  void _deleteSelectedPublishers() async {
    final bool? confirm = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return ConfirmDeleteDialog(
          title: 'Chú ý',
          content: 'Bạn đang xóa dữ liệu. Cân nhắc trước khi xóa!',
          onConfirm: () {},
        );
      },
    );

    if (confirm == true) {
      final publisherViewModel = context.read<PublisherViewModel>();
      for (var id in _selectedPublisher) {
        await publisherViewModel.deletePublisher(id.toString()); // Chuyển đổi id thành String
      }
      setState(() {
        _selectedPublisher.clear();
      });
      context.read<PublisherViewModel>().fetchPublisher(); // Cập nhật danh sách danh mục
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Nhà xuất bản"),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const ProductManagement(), // Navigate back to ProductManagement
              ),
            );
          },
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context)
                        .push(
                          MaterialPageRoute(
                            builder: (_) => const PublisherAdd(isUpdate: false,), // để tạm,
                            fullscreenDialog: true,
                          ),
                        )
                        .then((_) => context
                            .read<CategoryViewModel>()
                            .fetchCategories());
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Row(
                    children: [
                      Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                      SizedBox(width: 5),
                      Text(
                        'Thêm Nhà xuất bản',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 5),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const UploadPage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: peace,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Row(
                    children: [
                      Text(
                        'Tải lên',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 5),
                ElevatedButton(
                  onPressed: _deleteSelectedPublishers,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: danger,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Row(
                    children: [
                      Icon(
                        Icons.delete,
                        color: Colors.white,
                      ),
                      SizedBox(width: 5),
                      Text(
                        'Xóa',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Consumer<PublisherViewModel>(
              builder: (context, publisherViewModel, child) {
                if (publisherViewModel.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (publisherViewModel.publishers.isEmpty) {
                  return const Center(
                      child: Text('Không thấy nhà xuất bản'));
                } else {
                  return ListView.builder(
                    itemCount: publisherViewModel.publishers.length,
                    itemBuilder: (context, index) {
                      final publisher = publisherViewModel.publishers[index];
                      return ListTile(
                        title: Text(publisher.name),
                        leading: Checkbox(
                          value: publisher.id != null &&
                              _selectedPublisher.contains(publisher.id),
                          onChanged: (bool? selected) {
                            setState(() {
                              if (publisher.id != null) {                             
                                if (selected == true) {
                                  // Thêm vào danh sách nếu chưa có
                                  if (!_selectedPublisher
                                      .contains(publisher.id)) {
                                    _selectedPublisher.add(publisher.id!);
                                  }
                                } else {
                                  // Xóa khỏi danh sách nếu có
                                  if (_selectedPublisher
                                      .contains(publisher.id!)) {
                                    _selectedPublisher.remove(publisher.id);
                                  }
                                }                       
                              }
                            });
                          },
                        ),
                        onTap: () {
                          Navigator.of(context)
                          .push(
                            MaterialPageRoute(
                              builder: (_) => PublisherAdd(
                                isUpdate: true,
                                publisherModel: publisher,
                              ),
                              fullscreenDialog: true,
                            ),
                          )
                          .then(
                              (_) => _loadPublishers()); 
                              },
                            );
                    },
                  );
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
