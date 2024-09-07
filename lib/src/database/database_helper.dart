import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  static Future<Database> database() async {
    return openDatabase(
      join(await getDatabasesPath(), 'customer_database.db'),
      onCreate: (db, version) {
        return db.execute(
          '''
          CREATE TABLE customers(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            mobile TEXT,
            email TEXT,
            geoAddress TEXT,
            latitude REAL,
            longitude REAL,
            image TEXT
          )
          ''',
        );
      },
      version: 1,
    );
  }

  static Future<void> addCustomer(String name, String mobile, String email,
      String address, double latitude, double longitude, String image,
      {int? id}) async {
    final db = await database();

    if (id != null) {
      await db.update(
        'customers',
        {
          'name': name,
          'mobile': mobile,
          'email': email,
          'geoAddress': address,
          'latitude': latitude,
          'longitude': longitude,
          'image': image,
        },
        where: 'id = ?',
        whereArgs: [id],
      );
    } else {
      await db.insert(
        'customers',
        {
          'name': name,
          'mobile': mobile,
          'email': email,
          'geoAddress': address,
          'latitude': latitude,
          'longitude': longitude,
          'image': image,
        },
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
  }

  /// Delete a customer by ID
  static Future<void> deleteCustomer(int id) async {
    final db = await database();
    await db.delete('customers', where: 'id = ?', whereArgs: [id]);
  }

  /// Fetch all customers
  static Future<List<Map<String, dynamic>>> getCustomers() async {
    final db = await database();
    return db.query('customers');
  }
}
