import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:srv_project/helpers/database_helper.dart';
import 'package:srv_project/models/product.dart';

final productProvider = FutureProvider<List<Product>>((ref) async {
  final dbHelper = DatabaseHelper();
  return await dbHelper.getProducts();
});

final favoriteProvider =
    StateNotifierProvider<FavoriteNotifier, List<Product>>((ref) {
  return FavoriteNotifier();
});

class FavoriteNotifier extends StateNotifier<List<Product>> {
  FavoriteNotifier() : super([]) {
    _loadFavorites();
  }

  final DatabaseHelper _dbHelper = DatabaseHelper();

  Future<void> _loadFavorites() async {
    final favorites = await _dbHelper.getFavorites();
    state = favorites;
  }

  Future<void> addFavorite(Product product) async {
    await _dbHelper.addFavorite(product);
    state = [...state, product];
  }

  Future<void> removeFavorite(Product product) async {
    await _dbHelper.removeFavorite(product.name);
    state = state.where((p) => p.name != product.name).toList();
  }
}
