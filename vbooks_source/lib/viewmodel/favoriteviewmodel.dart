// import 'package:flutter/material.dart';
// import 'package:vbooks_source/data/model/favoritemodel.dart';
// import 'package:vbooks_source/services/favoriteservice.dart';

// import '../data/model/categorymodel.dart';
// import '../services/apiservice.dart';
// import '../services/categoryservice.dart';

// class FavoriteViewModel extends ChangeNotifier {
//   List<FavoriteModel> favorites = [];
//   bool _isLoading = false;
//   final FavoriteService favoriteService;

//   FavoriteViewModel() : favoriteService = FavoriteService(ApiService());

//   bool get isLoading => _isLoading;

//   Future<void> fetchFavorites(String id) async {
//     _isLoading = true;
//     notifyListeners();

//     try {
//       favorites = await favoriteService.fetchVaroriteById(id);
//     } catch (e) {
//       print('Error fetching favorites: $e');
//     } finally {
//       _isLoading = false;
//       notifyListeners();
//     }
//   }

//   Future<void> addFavorite({required String accountId, required String productId}) async {
//     try{
//       await favoriteService.addFavorite(accountId, productId);
//     }catch(e){
//       throw Exception(e);
//     }finally{
//       _isLoading = true;
//       notifyListeners();
//     }
//   }
// }
