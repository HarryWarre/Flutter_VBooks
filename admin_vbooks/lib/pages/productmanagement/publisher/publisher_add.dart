import 'package:admin_vbooks/data/model/publisher.dart';
import 'package:admin_vbooks/viewmodel/categoryviewmodel.dart';
import 'package:admin_vbooks/viewmodel/publisherviewmodel.dart';
import 'package:flutter/material.dart';
import '/../data/model/category.dart';
import 'package:provider/provider.dart';


class PublisherAdd extends StatefulWidget {
  final bool isUpdate;
  final PublisherModel? publisherModel;
  const PublisherAdd({super.key, this.isUpdate = false, this.publisherModel});

  @override
  State<PublisherAdd> createState() => _PublisherAddState();
}

class _PublisherAddState extends State<PublisherAdd> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  String titleText = "";

  @override
  void initState() {
    super.initState();
    if (widget.publisherModel != null && widget.isUpdate) {
      _nameController.text = widget.publisherModel!.name;
      _emailController.text = widget.publisherModel!.email;
      _addressController.text = widget.publisherModel!.address;
    }
    titleText = widget.isUpdate ? "Cập nhật nhà xuất bản" : "Thêm nhà xuất bản";
  }

  Future<void> _onSave() async {
    final name = _nameController.text;
    final email = _emailController.text;
    final address = _addressController.text;

    try { 
      final publisherViewModel = context.read<PublisherViewModel>();
      await publisherViewModel.createPublisher(
        PublisherModel(name: name, email: email, address: address)
      );
      
      Navigator.pop(context);
    } catch (error) {
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to create publisher: $error'))
      );
    }
  }

  Future<void> _onUpdate() async {
    final id = widget.publisherModel!.id;
    final name = _nameController.text;
    final email = _emailController.text;
    final address = _addressController.text;

    try {
      final publisherViewModel = context.read<PublisherViewModel>();
      await publisherViewModel.updatePublisher(
        PublisherModel(id: id, name: name, email: email, address: address)
      );    
      Navigator.pop(context);
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update category: $error'))
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(titleText),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Thêm tên danh mục',
                  ),
                ),
                const SizedBox(height: 16.0),
                TextField(
                  controller: _emailController,
                  maxLines: 7,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Thêm email',
                  ),
                ),
                const SizedBox(height: 16.0),
                TextField(
                  controller: _addressController,
                  maxLines: 7,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Thêm địa chỉ',
                  ),
                ),
                const SizedBox(height: 16.0),
                SizedBox(
                  height: 45.0,
                  child: ElevatedButton(
                    onPressed: () {
                      widget.isUpdate ? _onUpdate() : _onSave();
                    },
                    child: const Text(
                      'Lưu',
                      style: TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}