import 'package:todo_app_sqflite/models/todo.dart';
import 'package:todo_app_sqflite/repositories/repositories.dart';

class TodoServices{

  Repositories _repositories;

  TodoServices(){
    _repositories = Repositories();
  }

  // SAVE DATA OF TODO
  saveTodo(Todo todo)async{
    print('==============TODOOOOO');
   return await _repositories.insertData('Todos', todo.todoMap());
  }

  // READ DATA OF TODO
readTodo() async{
    return await _repositories.readData('Todos');
}

  // READ DATA BY COLUMN NAME
  readTodoByColumn(category)async{
    return await _repositories.readDataByColumn('Todos', 'category', category);
  }

}