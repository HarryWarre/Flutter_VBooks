import 'package:admin_vbooks/config/const.dart';
import 'package:admin_vbooks/pages/productmanagement/product/product_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '/../data/helper/db_helper.dart';
import '/../data/model/product.dart';
import '/../data/model/category.dart';

class ProductAdd extends StatefulWidget {
  final bool isUpdate;
  final Product_Model? productmodel;
  const ProductAdd({super.key, this.isUpdate = false, this.productmodel});

  @override
  State<ProductAdd> createState() => _ProductAddState();
}

class _ProductAddState extends State<ProductAdd> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  final DatabaseHelper _databaseService = DatabaseHelper();

  List<CategoryModel> _categories = [];
  CategoryModel? _selectedCategory;
  String titleText = "";
  File? _imageFile;

  Future<void> _onSave() async {
    final name = _nameController.text;
    final price = int.tryParse(_priceController.text) ?? 0;
    final img = _imageFile != null ? _imageFile!.path : '';
    final description = _descController.text;
    final cateId = _selectedCategory?.id ?? 1;

    await _databaseService.insertProduct(Product_Model(
      name: name,
      price: price,
      img: img,
      desc: description,
      catId: cateId,
    ));

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ProductList(), // Navigate back to ProductBuilder
      ),
    );
  }

  Future<void> _onUpdate() async {
    final name = _nameController.text;
    final price = int.tryParse(_priceController.text) ?? 0;
    final img =
        _imageFile != null ? _imageFile!.path : widget.productmodel!.img;
    final description = _descController.text;
    final cateId = _selectedCategory?.id ?? 1;

    await _databaseService.updateProduct(Product_Model(
      id: widget.productmodel!.id,
      name: name,
      price: price,
      img: img,
      desc: description,
      catId: cateId,
    ));

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ProductList(), // Navigate back to ProductBuilder
      ),
    );
  }

  Future<void> _loadCategories() async {
    final categories = await _databaseService.categories();
    setState(() {
      _categories = categories;
      if (widget.isUpdate && widget.productmodel != null) {
        _selectedCategory = _categories.firstWhere(
            (category) => category.id == widget.productmodel!.catId,
            orElse: () => _categories.first);
      } else {
        _selectedCategory = _categories.first;
      }
    });
  }

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.productmodel != null && widget.isUpdate) {
      _nameController.text = widget.productmodel!.name!;
      _priceController.text = widget.productmodel!.price.toString();
      _descController.text = widget.productmodel!.desc!;
      _imageFile = widget.productmodel!.img != null
          ? File(widget.productmodel!.img!)
          : null;
    }
    titleText = widget.isUpdate ? "Cập nhật sản phẩm" : "Thêm sản phẩm";
    _loadCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
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
                    hintText: 'Nhập tên sách',
                    focusColor: primary,
                    fillColor: primary,
                    prefixIconColor: primary,
                    suffixIconColor: primary),
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: _priceController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Nhập giá',
                ),
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
              ),
              const SizedBox(height: 16.0),
              Row(
                children: [
                  ElevatedButton(
                    onPressed: _pickImage,
                    child: const Text(
                      'Chọn ảnh',
                      style: TextStyle(color: primary),
                    ),
                  ),
                  const SizedBox(width: 16.0),
                  _imageFile != null
                      ? Image.file(
                          _imageFile!,
                          width: 100,
                          height: 100,
                        )
                      : const Text('Không có ảnh được chọn'),
                ],
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: _descController,
                maxLines: 7,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Thêm mô tả',
                ),
              ),
              const SizedBox(height: 16.0),
              DropdownButtonFormField<CategoryModel>(
                value: _selectedCategory,
                items: _categories.map((CategoryModel category) {
                  return DropdownMenuItem<CategoryModel>(
                    value: category,
                    child: Text(category.name),
                  );
                }).toList(),
                onChanged: (CategoryModel? newValue) {
                  setState(() {
                    _selectedCategory = newValue;
                  });
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Chọn danh mục',
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
                    style: TextStyle(fontSize: 16.0, color: primary),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
