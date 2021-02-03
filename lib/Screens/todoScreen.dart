import 'package:flutter/material.dart';
import 'package:todo_app_sqflite/Screens/homeScreen.dart';
// import 'package:todo_app_sqflite/models/categories.dart';
import 'package:todo_app_sqflite/models/todo.dart';
import 'package:todo_app_sqflite/services/categoriesServices.dart';
import 'package:intl/intl.dart';
import 'package:todo_app_sqflite/services/todoServices.dart';

class TodoScreen extends StatefulWidget {
  @override
  _TodoScreenState createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  var _titleTodoController = TextEditingController();
  var _descriptionTodoController = TextEditingController();
  var _datetimeController = TextEditingController();
  var _scaffoldKey = GlobalKey<ScaffoldState>();
  // Categories _category = Categories();

  var _selectedValue;
  var _categories = List<DropdownMenuItem>();
  var _todoServices = TodoServices();
  // List<Todo> _todoList = List<Todo>();

  @override
  void initState() {
    super.initState();
    _loadCategories();
  }

  _loadCategories() async {
    var _categoryServices = CategoryServices();
    var categories = await _categoryServices.readCategory();
    categories.forEach((category) {
      setState(() {
        _categories.add(DropdownMenuItem(
          child: Text(category["name"]),
          value: category['name'],
        ));
      });
    });
  }

  DateTime _dateTime = DateTime.now();

  _showSuccessSnackbar(message){
    var _snackbar = SnackBar(content: message,duration: Duration(seconds: 5),);
    _scaffoldKey.currentState.showSnackBar(_snackbar);
  }

  _selectedTodoDate(BuildContext context) async {
    var _pickedDate = await showDatePicker(
        context: context,
        initialDate: _dateTime,
        firstDate: DateTime(2000),
        lastDate: DateTime(2022));

    if (_pickedDate != null) {
      setState(() {
        _dateTime = _pickedDate;
        _datetimeController.text = DateFormat('yyyy-MM-dd').format(_pickedDate);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Create to do'),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 8.0, left: 16.0, right: 16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // TITLE textformfield
              TextFormField(
                decoration: InputDecoration(
                  labelText: "Title",
                  hintText: 'Write title here',
                ),
                controller: _titleTodoController,
              ),

              // Description TextFormField
              TextFormField(
                decoration: InputDecoration(
                  labelText: "Description",
                  hintText: 'Write description here',
                ),
                controller: _descriptionTodoController,
              ),

              // DATE TextFormField
              TextFormField(
                decoration: InputDecoration(
                    labelText: "Date",
                    hintText: 'YYYY-MM-DD',
                    prefixIcon: InkWell(
                      onTap: () {
                        _selectedTodoDate(context);
                      },
                      child: Icon(Icons.calendar_today),
                    )),
                controller: _datetimeController,
              ),

              // DropDown Button
              DropdownButtonFormField(
                value: _selectedValue,
                items: _categories,
                hint: Text("Select Category"),
                onChanged: (value) {
                  setState(() {
                    _selectedValue = value;
                  });
                },
              ),
              SizedBox(
                height: 20.0,
              ),
              // Raised button
              RaisedButton(
                onPressed: () async {
                  var todoObject = Todo();
                  todoObject.name = _titleTodoController.text;
                  todoObject.description = _descriptionTodoController.text;
                  todoObject.isFinished = 0;
                  todoObject.todoDate = _datetimeController.text;
                  todoObject.category = _selectedValue;
                  var result = await _todoServices.saveTodo(todoObject);
                  if (result > 0) {
                    print(result);
                    _showSuccessSnackbar(Text('Added Successfully'));
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => HomeScreen()));

                  }
                },
                child: Text(
                  'Save',
                  style: TextStyle(color: Colors.white, fontSize: 16.0),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
