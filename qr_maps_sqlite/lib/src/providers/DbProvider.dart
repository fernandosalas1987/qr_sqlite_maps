import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:qr_maps_sqlite/src/models/Scan.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
export 'package:qr_maps_sqlite/src/models/Scan.dart';

class DBProvider {
  static Database _database;
  static final DBProvider db = DBProvider._();

  DBProvider._();

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'ScansDB.db');
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute('CREATE TABLE Scans('
          ' id INTEGER PRIMARY KEY,'
          ' tipo TEXT,'
          ' valor TEXT'
          ')');
    });
  }

  createScanraw(ScanModel scan) async {
    final db = await database;
    final res = await db.rawInsert("INSERT INTO Scans (id,tipo,valor) "
        "VALUES (${scan.id},'${scan.tipo}','${scan.valor}')");
    return res;
  }

  createScan(ScanModel scan) async {
    final db = await database;
    final res = await db.insert('Scans', scan.toJson());
    return res;
  }

  Future<ScanModel> getScan(int id) async {
    final db = await database;
    final res = await db.query('Scans', where: 'id=?', whereArgs: [id]);
    return res.isNotEmpty ? ScanModel.fromJson(res.first) : null;
  }

  Future<List<ScanModel>> getAll() async {
    final db = await database;
    final res = await db.query('Scans');
    List<ScanModel> list =
        res.isNotEmpty ? res.map((sc) => ScanModel.fromJson(sc)).toList() : [];
    return list;
  }

  Future<List<ScanModel>> getType(String tipo) async {
    final db = await database;
    final res = await db.rawQuery("SELECT * FROM Scans WHERE tipo='$tipo'");
    List<ScanModel> list =
        res.isNotEmpty ? res.map((sc) => ScanModel.fromJson(sc)).toList() : [];
    return list;
  }

  Future<int> updateScan(ScanModel scan) async {
    final db = await database;
    final res = await db
        .update('Scans', scan.toJson(), where: 'id=?', whereArgs: [scan.id]);
    return res;
  }

  Future<int> deleteScan(int id) async {
    final db = await database;
    final res = await db.delete('Scans', where: 'id=?', whereArgs: [id]);
    return res;
  }

  Future<int> deleteScanALl() async {
    final db = await database;
    final res = await db.delete('DELETE FROM Scans');
    return res;
  }
}
