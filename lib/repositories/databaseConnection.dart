import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseConnection {
  int id;
  String name;
  String description;

  setDatabase() async {
    var directory = await getApplicationDocumentsDirectory();
    var path = join(directory.path, "db_todolist_sqflite.db");
    var database =
    await openDatabase(path, version: 1, onCreate: _onCreatingDatabase);
    return database;
  }

  _onCreatingDatabase(Database database, int version) async {
    // CREATING CATEGORIES TABLE
    await database.execute(
        "CREATE TABLE categories (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, description TEXT)");

    //CREATING TODOS TABLE
    await database.execute(
        'CREATE TABLE Todos(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, description TEXT, category TEXT, todoDate TEXT, isFinished INTEGER)');
  }


}
