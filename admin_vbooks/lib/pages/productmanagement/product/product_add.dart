import 'package:admin_vbooks/config/const.dart';
import 'package:admin_vbooks/connectApi/apiservice.dart';
import 'package:admin_vbooks/connectApi/categoryservice.dart';
import 'package:admin_vbooks/data/model/publisher.dart';
import 'package:admin_vbooks/pages/productmanagement/product/product_listtest.dart';
import 'package:admin_vbooks/viewmodel/categoryviewmodel.dart';
import 'package:admin_vbooks/viewmodel/productviewmodel.dart';
import 'package:admin_vbooks/viewmodel/publisherviewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
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
  final TextEditingController _imagePath = TextEditingController();
  late ProductViewModel _productViewModel;
  late CategoryViewModel _categoryViewModel;
  late PublisherViewModel _publisherViewModel;
  
  List<PublisherModel> _publishers = [];
  List<CategoryModel> _categories = [];
  PublisherModel? _selectedPublisher;
  CategoryModel? _selectedCategory;
  String titleText = "";

  @override
  void initState() {
    super.initState();

    _productViewModel = ProductViewModel();
    _categoryViewModel = Provider.of<CategoryViewModel>(context, listen: false);
    _publisherViewModel = Provider.of<PublisherViewModel>(context, listen: false);

    if (widget.productmodel != null && widget.isUpdate) {
      _nameController.text = widget.productmodel!.name!;
      _priceController.text = widget.productmodel!.price.toString();
      _descController.text = widget.productmodel!.desc!;
      _imagePath.text = widget.productmodel!.img!;
    }
    titleText = widget.isUpdate ? "Cập nhật sản phẩm" : "Thêm sản phẩm";
    _loadCategories();
    _loadPublishers();
  }

  Future<void> _onSave() async {
    final name = _nameController.text;
    final price = int.tryParse(_priceController.text) ?? 0;
    final img = _imagePath.text;
    final description = _descController.text;
    final cateId = _selectedCategory?.id.toString() ?? '';
    final publisherId = _selectedPublisher?.id.toString() ?? '';

    await _productViewModel.addProduct(name, price, img, description, cateId.toString(), publisherId.toString());

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ProductList(), // Navigate back to ProductBuilder
      ),
    );
  }

  Future<void> _onUpdate() async {
    final id = widget.productmodel?.id;
    final name = _nameController.text;
    final price = int.tryParse(_priceController.text);
    final img = _imagePath.text;
    final desc = _descController.text;
    final catId = _selectedCategory?.id ?? '';
    final publisherId = _selectedPublisher?.id.toString() ?? '';

    await _productViewModel.updateProduct(id!, name, price!, img, desc, catId.toString(), publisherId.toString());
     Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ProductList(), // Navigate back to ProductList
      ),
    );
  }

  Future<void> _loadCategories() async {
    await _categoryViewModel.fetchCategories();
    _categories = _categoryViewModel.categories;
    print(_categories);
    setState(() {
        if(widget.isUpdate && widget.productmodel != null){
          _selectedCategory = _categories.firstWhere(
            (category) => category.id == widget.productmodel!.catId,
            orElse: () => _categories.first
          );
        } else {
          _selectedCategory = _categories.first;
          print(_selectedCategory);
        }
    });
  }

  Future<void> _loadPublishers() async {
    await _publisherViewModel.fetchPublisher();
    _publishers = _publisherViewModel.publishers;
    print(_categories);
    setState(() {
        if(widget.isUpdate && widget.productmodel != null){
          _selectedPublisher = _publishers.firstWhere(
            (publisher) => publisher.id == widget.productmodel!.publisherId,
            orElse: () => _publishers.first
          );
        } else {
          _selectedPublisher = _publishers.first;
          print(_selectedPublisher);
        }
    });
  }

  

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
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
                TextField(
                  controller: _imagePath,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Nhập đường dẫn sách',
                      focusColor: primary,
                      fillColor: primary,
                      prefixIconColor: primary,
                      suffixIconColor: primary),
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
                DropdownButtonFormField<PublisherModel>(
                  value: _selectedPublisher,
                  items: _publishers.map((PublisherModel publisher) {
                    return DropdownMenuItem<PublisherModel>(
                      value: publisher,
                      child: Text(publisher.name),
                    );
                  }).toList(),
                  onChanged: (PublisherModel? newValue) {
                    setState(() {
                      _selectedPublisher = newValue;
                    });
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Chọn nhà cung cấp',
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
      ),
    );
  }
}
