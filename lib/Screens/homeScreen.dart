import 'package:flutter/material.dart';
import 'package:todo_app_sqflite/Screens/todoScreen.dart';
import 'package:todo_app_sqflite/helpers/drawer.dart';
import 'package:todo_app_sqflite/models/todo.dart';
import 'package:todo_app_sqflite/services/todoServices.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var _todoServices = TodoServices();

  List<Todo> _todoList = List<Todo>();

  _getAllcategories() async {
    _todoList = List<Todo>();
    var todo = await _todoServices.readTodo();
    todo.forEach((todo) {
      setState(() {
        var todoModel = Todo();
        todoModel.name= todo['title'];
        todoModel.category= todo['category'];
        todoModel.description= todo['description'];
        todoModel.isFinished= todo['isFinished'];
        todoModel.id= todo['id'];
        todoModel.todoDate= todo['todoDate'];
        _todoList.add(todoModel);
      });
    });
  }

  @override
  void initState(){
    super.initState();
    _getAllcategories();
  }

  // _listAllTodos()async {
  //   _todoList = List<Todo>();
  //   var todo = await _todoServices.readTodo();
  //   todo.forEach((todo){
  //     var todoModel = Todo();
  //     todoModel.name= todo['title'];
  //     todoModel.category= todo['category'];
  //     todoModel.description= todo['description'];
  //     todoModel.isFinished= todo['isFinished'];
  //     todoModel.id= todo['id'];
  //     todoModel.todoDate= todo['todoDate'];
  //     _todoList.add(todoModel);
  //   });
  //
  // }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo List SQFLITE'),
      ),
      drawer: DrawerNavigation(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        tooltip: "Add Category",
        onPressed:()=> Navigator.of(context).push(
    MaterialPageRoute(
    builder: (context) => TodoScreen()),
    ),
      ),
      body: ListView.builder(
          itemCount: _todoList.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.only(
                top: 5.0,
                left: 8.0,
                right: 8.0,
              ),
              child: Card(
                elevation: 10.0,
                child: ListTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(_todoList[index].name),
                  Text(_todoList[index].todoDate),
                    ],
                  ),
                  subtitle: Text(_todoList[index].category),
                ),
              ),
            );
          }),
    );
  }
}
