import 'package:sqflite/sqflite.dart';
import 'package:todo_app_sqflite/repositories/databaseConnection.dart';
import 'dart:async';

class Repositories {
  DatabaseConnection _databaseConnection;

  Repositories() {
    _databaseConnection = DatabaseConnection();
  }

  static Database _database;

  Future<Database> get database async {
    if (_database != null) {
      print('+++++++++++++Database Found++++++++++++++++++');
      return _database;
      // print(_database.toString());
    }
    // _database = await initializeDatabase();
    // print('===============Database Does not exist==============');
    _database = await _databaseConnection.setDatabase();
    return _database;
    // print(_database.toString());
  }

// Create data table
  insertData(table, data) async {
    var connection = await database;
    return await connection.insert(table, data);
  }

  //Read data from database
  readData(table) async {
    var connection = await database;
    return await connection.query(table);
  }

  //Read data from database by ++++++ID++++++
  readDatabyId(table, itemId) async {
    var connection = await database;
    return await connection.query(table, where: 'id=?', whereArgs: [itemId]);
  }

  //update data from database by ++++ID++++++
  updateData(table, data) async {
    var connection = await database;
    var response= await connection.update(table, data, where: 'id=?', whereArgs: [data['id']]);
    return response;
  }


  // Delete data from database by =========ID=========
  deleteData(table, itemId) async{
    var connection = await database;
    return await connection.rawDelete('DELETE FROM $table WHERE id = $itemId');

  }

  // Read Data by Column category
readDataByColumn(table, columnName, columnValue)async{
    var connection = await database;
    return await connection.query(table, where: '$columnName=?',whereArgs: [columnValue]);
}
}
