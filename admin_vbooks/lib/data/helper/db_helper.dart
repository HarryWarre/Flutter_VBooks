import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '/data/model/category.dart';
import '/data/model/product.dart';

class DatabaseHelper {
  // Singleton pattern
  static final DatabaseHelper _databaseService = DatabaseHelper._internal();
  factory DatabaseHelper() => _databaseService;
  DatabaseHelper._internal();

  static Database? _database;
  Future<Database> get database async {
    if (_database != null) return _database!;
    // Initialize the DB first time it is accessed
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'db_product.db');
    print(
        "Đường dẫn database: $databasePath"); // in đường dẫn chứa file database
    return await openDatabase(
      path,
      onCreate: _onCreate,
      version: 1,
      // onConfigure: (db) async => await db.execute('PRAGMA foreign_keys = ON'),
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE category(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        desc TEXT
      )
    ''');
    await db.execute('''
      CREATE TABLE product(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        price INTEGER,
        img TEXT,
        desc TEXT,
        catid INTEGER
      )
    ''');
  }

  // CRUD dành cho Category
  Future<void> insertCategory(CategoryModel categoryModel) async {
    final db = await _databaseService.database;
    await db.insert(
      'category',
      categoryModel.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<CategoryModel>> categories() async {
    final db = await _databaseService.database;
    final List<Map<String, dynamic>> maps = await db.query('category');
    return List.generate(
        maps.length, (index) => CategoryModel.fromMap(maps[index]));
  }

  Future<CategoryModel> category(int id) async {
    final db = await _databaseService.database;
    final List<Map<String, dynamic>> maps =
        await db.query('category', where: 'id = ?', whereArgs: [id]);
    return CategoryModel.fromMap(maps[0]);
  }

  Future<void> updateCategory(CategoryModel cate) async {
    final db = await _databaseService.database;
    await db.update(
      'category',
      cate.toMap(),
      where: 'id = ?',
      whereArgs: [cate.id],
    );
  }

  Future<void> deleteCategory(String id) async {
    final db = await _databaseService.database;
    await db.delete(
      'category',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // CRUD dành cho Product
  Future<void> insertProduct(Product_Model product) async {
    final db = await _databaseService.database;
    await db.insert(
      'product',
      product.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Product_Model>> products() async {
    final db = await _databaseService.database;
    final List<Map<String, dynamic>> maps = await db.query('product');
    return List.generate(
      maps.length,
      (index) => Product_Model(
        id: maps[index]['id'],
        name: maps[index]['name'],
        price: maps[index]['price'],
        img: maps[index]['img'],
        desc: maps[index]['desc'],
        catId: maps[index]['catid'],
      ),
    );
  }

  Future<Product_Model> product(int id) async {
    final db = await _databaseService.database;
    final List<Map<String, dynamic>> maps =
        await db.query('product', where: 'id = ?', whereArgs: [id]);
    return Product_Model.fromMap(maps[0]);
  }

  Future<void> updateProduct(Product_Model product) async {
    final db = await _databaseService.database;
    await db.update(
      'product',
      product.toJson(),
      where: 'id = ?',
      whereArgs: [product.id],
    );
  }

  Future<void> deleteProduct(int id) async {
    final db = await _databaseService.database;
    await db.delete(
      'product',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
