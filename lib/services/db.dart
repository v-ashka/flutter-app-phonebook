import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import '../services/person.dart';

String tableName = "Persons";
class DbProvider {
  static Database? _database;
  static final DbProvider db = DbProvider._();

  DbProvider._();

  Future<Database?> get database async {
    //if database exists return databse
    if (_database != null) return _database;

    //if db doesn't exists, create
    _database = await initDB();
  }

  //Create db and person table
  initDB() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentDirectory.path, 'persons_list.db');

    return await openDatabase(path, onOpen: (db) {},
      onCreate: (Database db, version) async {
        await db.execute(
            'CREATE TABLE $tableName(id INTEGER PRIMARY KEY AUTOINCREMENT, firstname TEXT, lastname TEXT, phoneNumber TEXT, imageUrl TEXT, city TEXT)');
        // await db.execute('CREATE TABLE $tableName('
        //     'id INTEGER PRIMARY KEY AUTOINCREMENT,'
        //     'firstname TEXT,'
        //     'lastname TEXT,'
        //     'phoneNumber TEXT,'
        //     'imageUrl TEXT,'
        //     'city TEXT,'
        //     ')');
      }, version: 1,
    );
  }

  //Insert into db
  createUsers(Person newPerson) async {
    await deleteAllUsers();
    await setAutoIncrement();
    final db = await database;
    final res = await db?.insert(tableName, newPerson.toJson());
    print("baza danych: $db");
    print(res);
    return res;
  }

  Future setAutoIncrement() async{
    final db = await database;
    final res = await db?.rawQuery("UPDATE SQLITE_SEQUENCE SET SEQ=0 WHERE NAME='$tableName'");
    return res;
  }

  //Delete all users
  Future<int?> deleteAllUsers() async {
    final db = await database;
    final res = await db?.rawDelete('DELETE FROM $tableName');
    return res;
  }

  Future getAllUsers() async {
    final db = await database;
    // List<Map<String, dynamic>>? maps =  [];
    var query = await db?.query(tableName);
    if(query != null){
      // List Map<String, dynamic> maps = {};
      List<dynamic> maps = query;
      print('not null ${query.length}');
      if(query.length > 0){
        print('data with id: $maps');
        return maps.map((elem) => Person.fromDatabase(elem)).toList();
        // for(int i=0; i<query.length; i++){
        //   maps.add(query[i]);
        // }
        return {"userList": maps};
      }
      // for(int i=0; i<query)
      // return maps.map((row) => Person.fromMap(row)).toList();
    }else {
      return query;
    }
  }


  Future<void> updateMobile(Person person, int id) async {
    // Get a reference to the database.
    final db = await database;

    // Update the given record
    await db?.update(
      '$tableName',
      person.toJson(),
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
    // List<dynamic> peoples = peopleData['results'];
    // return peoples.map((json) => Person.fromJson(json)).toList();
    // final res = await db?.query("SELECT * FROM Persons");

    // if(maps != null){
    //   maps = await db?.query('$tableName');
    //   print('maps: $maps');
    //   maps!.isNotEmpty ? maps.map((c) => Person.fromJson(c)).toList() : [];
    // }
    // // if(res != null){
    // //   // return peoples.map((json) => Person.fromJson(json)).toList();
    // //   Map peoples = {};
    // //   return res.map((data) => peoples);
    // // }
    // return maps;


//   Future<List<Map<String, Object?>>?> getAllUsers() async{
//     final db = await database;
//     List<Person> list =[];
//     final res = await db?.rawQuery("SELECT * FROM $tableName");
//     // .then((value) {
//     //   list =value.isNotEmpty ? value.map((c) => Person.fromJson(c)).toList() : [];
//     //   print('list item: $list');
//     // }
//     // );
//     // print(res);
//     return res;
//     }
