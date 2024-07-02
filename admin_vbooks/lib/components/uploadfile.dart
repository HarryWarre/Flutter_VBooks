import 'package:admin_vbooks/config/const.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class UploadPage extends StatelessWidget {
  const UploadPage({super.key});

  void _pickFile(BuildContext context) async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['csv'],
    );
    if (result != null) {
      final file = result.files.first;
      // Thực hiện các hành động với file được chọn
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('File đã chọn: ${file.name}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tải lên"),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Center(
        child: GestureDetector(
          onTap: () => _pickFile(context),
          child: Container(
            width: 250.0,
            height: 150.0,
            decoration: BoxDecoration(
              color: Colors.green[50],
              border: Border.all(
                color: primary,
                style: BorderStyle.solid,
                width: 2.0,
              ),
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.upload_file,
                  size: 50.0,
                  color: primary,
                ),
                SizedBox(height: 8.0),
                Text(
                  "Tải lên file .csv",
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: primary,
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