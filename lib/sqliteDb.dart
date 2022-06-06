import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SqliteDb {
  static Database? _db;
  Future<Database?> get db async {
    if (_db == null) {
      _db = await intialDb();
      return _db;
    }
    return _db;
  }

  intialDb() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, "ayham.db");

    Database myDb = await openDatabase(path,
        onCreate: _onCreate, onUpgrade: _onUpgrade, version: 1);
    return myDb;
  }

  _onUpgrade(Database db, int oldVersion, int newVersion) async {
    print('onUpgrade****************************');
  }

  _onCreate(Database db, int version) async {
    Batch batch = db.batch();

    batch.execute('''
CREATE TABLE "notes"(
"id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT ,
"title" TEXT ,
"color" TEXT,
"note" TEXT 
)
''');
    //دائما يفضل استخدامها لانشاء جدول او اكثر batch
//  batch.execute('''
// CREATE TABLE "students"(
// "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT ,
// "title" TEXT ,
// "color" TEXT,
// "note" TEXT
// )
// ''');
    await batch.commit();
    print('Create Database and Table *************');
  }

//select
  readData(String sql) async {
    Database? myDb = await db;
    List<Map> response = await myDb!.rawQuery(sql);
    return response;
  }
//insert

  insertData(String sql) async {
    Database? myDb = await db;
    int response = await myDb!.rawInsert(sql);
    return response;
  }

//update
  updateData(String sql) async {
    Database? myDb = await db;
    int response = await myDb!.rawUpdate(sql);
    return response;
  }

  //delete
  deleteData(String sql) async {
    Database? myDb = await db;
    int response = await myDb!.rawDelete(sql);
    return response;
  }

  myDeleteDatabase() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, "ayham.db");
    await deleteDatabase(path);
  }

//read
  read(String table) async {
    Database? myDb = await db;
    List<Map> response = await myDb!.query(table);
    return response;
  }
//insert

  insert(String table, Map<String, Object?> values) async {
    Database? myDb = await db;
    int response = await myDb!.insert(table, values);
    return response;
  }

//update
  update(String table, Map<String, Object?> values, String myWhere) async {
    Database? myDb = await db;
    int response = await myDb!.update(table, values, where: myWhere);
    return response;
  }

  //delete
  delete(String table, String myWhere) async {
    Database? myDb = await db;
    int response = await myDb!.delete(table, where: myWhere);
    return response;
  }
}










/*
*
* import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final Future<Database> database = openDatabase(
    join(await getDatabasesPath(), 'doggie_database.db'),
    onCreate: (db, version) {
      return db.execute(
          'CREATE TABLE dogs(id INTEGER PRIMARY KEY, name TEXT, age T=INTEGER)');
    },
    version: 1,
  );

//Insert data
  Future<void> insertData(Dog dog) async {
    final Database db = await database;
    await db.insert(
      'dogs',
      dog.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

//Read data
  Future<List<Dog>> dogs() async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query('dogs');
    return List.generate(maps.length, (index) {
      return Dog(
          id: maps[index]['id'],
          name: maps[index]['name'],
          age: maps[index]['age']);
    });
  }

//Update data
  Future<void> updateData(Dog dog) async {
    final Database db = await database;
    await db.update(
      'dogs',
      dog.toMap(),
      where: 'id=?',
      whereArgs: [dog.id],
    );
  }



//Delete data
  Future<void> DeleteData(int id) async {
    final Database db = await database;
    await db.delete(
      'dogs',
      where: 'id=?',
      whereArgs: [id],
    );
  }

}

class Dog {
  final int id;
  final String name;
  final int age;

  Dog({required this.id, required this.name, required this.age});

  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name, 'age': age};
  }

  @override
  String toString() {
    return 'Dog { id: $id, name :$name, age :$age}';
  }
}
class Functions extends StatefulWidget {
  const Functions({Key? key}) : super(key: key);

  @override
  State<Functions> createState() => _FunctionsState();

}

class _FunctionsState extends State<Functions> {

  @override
  Widget build(BuildContext context) {

    return Container();

  }

}
*/