import 'dart:convert';
import 'package:admin_vbooks/connectApi/apiservice.dart';
import 'package:admin_vbooks/data/model/publisher.dart';



class PublisherService {
  final ApiService apiService;

  PublisherService(this.apiService);

  Future<List<PublisherModel>> fetchPublisher() async {
    final response = await apiService.get('publisher/'); // Cập nhật endpoint nếu cần
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => PublisherModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load categories');
    }
  }
  Future<void> createPublisher(PublisherModel publisher) async {

    var data = {
      'name': publisher.name,
      'email': publisher.email,
      "address": publisher.address,
    };

    final response = await apiService.post(
      'publisher/',
      data
    );
    if (response.statusCode != 201) {
      throw Exception('Lỗi khi tạo tác giả');
    }
  }

  Future<void> updatePublisher(PublisherModel publisher) async {
    var data = {
      'name': publisher.name,
      'email': publisher.email,
      "address": publisher.address,
    };
    final response = await apiService.put(
      'publisher/${publisher.id}',
      data
    );
    if (response.statusCode != 200) {
      throw Exception('Lỗi khi cập nhật tác giả');
    }
  }

   Future<void> deletePublisher(String id) async {
    final response = await apiService.delete('publisher/$id');
    if (response.statusCode != 200) {
      throw Exception('Lỗi khi xóa tác giả');
    }
  }
}
