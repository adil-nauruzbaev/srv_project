import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:srv_project/constants/list_products.dart';
import '../models/product.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();

  factory DatabaseHelper() {
    return _instance;
  }

  DatabaseHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final path = await getDatabasesPath();
    final dbPath = join(path, 'products.db');

    return await openDatabase(
      dbPath,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE products (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            description TEXT,
            imageUrl TEXT
          )
        ''');

        await db.execute('''
          CREATE TABLE favorites (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            description TEXT,
            imageUrl TEXT
          )
        ''');

        await populateTestProducts(db);
      },
    );
  }

  Future<void> deleteAllProducts(Database db) async {
    await db.delete('products');
  }

  Future<void> populateTestProducts(Database db) async {
    // Удаление всех товаров перед вставкой новых
    await deleteAllProducts(db);

    // Вставка новых товаров
    for (Product product in productsToInsert) {
      await db.insert(
        'products',
        {
          'name': product.name,
          'description': product.description,
          'imageUrl': product.imageUrl,
        },
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
  }

  Future<bool> isFavorite(String name) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'favorites',
      where: 'name = ?',
      whereArgs: [name],
    );

    return maps.isNotEmpty;
  }

  Future<void> addFavorite(Product product) async {
    final db = await database;
    await db.insert(
      'favorites',
      {
        'name': product.name,
        'description': product.description,
        'imageUrl': product.imageUrl,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> removeFavorite(String name) async {
    final db = await database;
    await db.delete(
      'favorites',
      where: 'name = ?',
      whereArgs: [name],
    );
  }

  Future<List<Product>> getProducts() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('products');

    return List.generate(maps.length, (i) {
      return Product(
        name: maps[i]['name'],
        description: maps[i]['description'],
        imageUrl: maps[i]['imageUrl'],
      );
    });
  }

  Future<List<Product>> getFavorites() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('favorites');

    return List.generate(maps.length, (i) {
      return Product(
        name: maps[i]['name'],
        description: maps[i]['description'],
        imageUrl: maps[i]['imageUrl'],
      );
    });
  }
}
