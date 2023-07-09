import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';
import 'package:app/data.dart';

class DatabaseHelper{
  static DatabaseHelper? _databaseHelper;
  static Database? _database;

  String datatable = 'data_table';
  int colid = 1;
  String colname = 'name';
  String collastname = 'lastname';
  int colmobile = 1234567890;
  String colgender = 'gender';
  int colage = 20;
  String colemail = 'email';
  String colpass = 'pass';
  String colcopass = 'copass';


  DatabaseHelper._createInstance();
  factory DatabaseHelper(){
    if(_databaseHelper == null) {
      _databaseHelper = DatabaseHelper._createInstance();
    }
    return _databaseHelper!;
  }

  Future<Database> get database async{
    if(_database == null){
      _database = await intializeDatabase();
    }
    return _database!;
  }

  Future<Database> intializeDatabase() async{
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'data.db';
    ByteData data = await rootBundle.load("assets/data");
    List<int> bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    print("${bytes}");
    var datadatabase = await openDatabase(path, version: 1,onCreate: _createDb);
    return datadatabase;
  }

  void _createDb(Database db , int newVersion)async{
    await db.execute('CREATE TABLE $datatable($colid INTEGER PRIMARY KEY AUTOINCREMENT, $colname TEXT,$collastname TEXT,$colmobile INTEGER,$colgender TEXT,$colage TEXT,$colemail TEXT,$colpass TEXT,$colcopass TEXT)');
  }
    Future<List<Map<String,dynamic>>>getNoteMapList() async {
    Database db = await this.database;

    var result = await db.rawQuery('SELECT * FROM $datatable');
    return result;
  }
  Future<int> insertdata(data data) async{
    Database db = await this.database;
    var result = await db.rawInsert('INSERT INTO $datatable VALUES($colid,$colname,$collastname,$colmobile,$colgender,$colage,$colemail,$colpass,$colcopass)');
    return result;
  }
}