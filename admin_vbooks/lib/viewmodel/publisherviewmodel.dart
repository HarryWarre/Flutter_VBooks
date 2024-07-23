import 'package:admin_vbooks/connectApi/publisherservice.dart';
import 'package:admin_vbooks/data/model/publisher.dart';
import 'package:flutter/foundation.dart';
import '../data/model/category.dart';

class PublisherViewModel extends ChangeNotifier {
  bool isLoading = false;
  List<PublisherModel> publishers = [];

  final PublisherService publisherService;

  PublisherViewModel(this.publisherService);

  Future<void> fetchPublisher() async {
    isLoading = true;
    try {
      publishers = await publisherService.fetchPublisher();
      print('Fetched publisher: ${publishers.map((c) => c.name).toList()}'); // Log danh mục để kiểm tra
    } catch (error) {
      print('Error fetching publishers: $error');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

   Future<void> createPublisher(PublisherModel publisher) async {
    isLoading = true;
    notifyListeners();

    try {
      await publisherService.createPublisher(publisher);
      await fetchPublisher(); // Refresh categories after creation
    } catch (error) {
      print('Error creating publisher: $error');
      // You can also add more sophisticated error handling here
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updatePublisher(PublisherModel publisher) async {
    isLoading = true;
    notifyListeners();

    try {
      await publisherService.updatePublisher(publisher);
      await fetchPublisher(); // Refresh categories after update
    } catch (error) {
      print('Error updating publisher: $error');
      // You can also add more sophisticated error handling here
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
  
    Future<void> deletePublisher(String id) async {
    isLoading = true;
    notifyListeners();

    try {
      await publisherService.deletePublisher(id); // Sử dụng categoryService để xóa danh mục
      await fetchPublisher(); // Refresh categories after deletion
    } catch (error) {
      print('Error deleting publisher: $error');
      // Bạn có thể thêm xử lý lỗi tinh vi hơn ở đây nếu cần
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
