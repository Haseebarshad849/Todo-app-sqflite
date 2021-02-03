import 'package:flutter/material.dart';
import 'package:todo_app_sqflite/models/todo.dart';
import 'package:todo_app_sqflite/services/todoServices.dart';

class TodoByCategory extends StatefulWidget {
  final String category;

  TodoByCategory({this.category});

  @override
  _TodoByCategoryState createState() => _TodoByCategoryState();
}

class _TodoByCategoryState extends State<TodoByCategory> {
  @override
  void initState() {
    super.initState();
    getTodosByCategory();
  }

  List<Todo> _todoList = List<Todo>();
  var _todoService = TodoServices();

  getTodosByCategory() async {
    var todos = await _todoService.readTodoByColumn(this.widget.category);
    todos.forEach((todo) {
      setState(() {
        var model = Todo();
        model.name = todo['title'];
        model.category = todo['category'];
        model.todoDate = todo['todoDate'];
        _todoList.add(model);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(this.widget.category),
      ),
      body: ListView.builder(itemCount: _todoList.length,
          itemBuilder: (context,index){
        return Padding(
          padding: EdgeInsets.only(left:12.0,right: 12.0,top: 7.0),
          child: Card(
            elevation: 6.0,
            child:  ListTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(_todoList[index].name??'No name'),
                  Text(_todoList[index].todoDate??'No Date'),
                ],
              ),
              subtitle: Text(_todoList[index].description?? 'No description'),
            ),
          ),
        );
          }),
    );
  }
}
