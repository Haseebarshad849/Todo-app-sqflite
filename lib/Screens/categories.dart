import 'package:flutter/material.dart';
import 'package:todo_app_sqflite/Screens/homeScreen.dart';
import 'package:todo_app_sqflite/models/categories.dart';
import 'package:todo_app_sqflite/services/categoriesServices.dart';


class CategoriesScreen extends StatefulWidget {
  @override
  _CategoriesScreenState createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  var _categoryController = TextEditingController();
  var _descriptionController = TextEditingController();
  var _editCategoryController = TextEditingController();
  var _editDescriptionController = TextEditingController();
  var _categories = Categories();
  var _categoriesServices = CategoryServices();
  List<Categories> _categorylist = List<Categories>();
  var _globalkey = GlobalKey<ScaffoldState>();

  var category;

  @override
  void initState() {
    super.initState();
    getAllcategories();
  }

  editCategory(BuildContext context, categoryId) async {
    category = await CategoryServices().readCategorbyId(categoryId);
    setState(() {
      _editCategoryController.text = category[0]['name'] ?? 'No Name';
      _editDescriptionController.text =
          category[0]['description'] ?? 'No description';
    });
    _editDialogueBox(context);
  }

  getAllcategories() async {
    _categorylist = List<Categories>();
    var categories = await _categoriesServices.readCategory();
    categories.forEach((categories) {
      setState(() {
        var categoryModel = Categories();
        categoryModel.name = categories['name'];
        categoryModel.description = categories['description'];
        categoryModel.id = categories['id'];
        _categorylist.add(categoryModel);
      });
    });
  }

  _showDialogueBox(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (param) {
          return AlertDialog(
            actions: [
              FlatButton(
                onPressed: () => cancelButton(context),
                child: Text('Cancel'),
                color: Colors.red,
              ),
              FlatButton(
                onPressed: () async {
                  _categories.name = _categoryController.text;
                  _categories.description = _descriptionController.text;
                  var result =
                      await _categoriesServices.saveCategory(_categories);
                  print(result);
                  Navigator.pop(context);
                  _categoryController.clear();
                  _descriptionController.clear();
                  getAllcategories();
                },
                child: Text('Submit'),
                color: Colors.blue[600],
              ),
            ],
            title: Text('Categories Form'),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  TextField(
                    controller: _categoryController,
                    decoration: InputDecoration(
                      hintText: 'Write a Category',
                      labelText: 'Category',
                    ),
                  ),
                  TextField(
                    controller: _descriptionController,
                    decoration: InputDecoration(
                      hintText: 'Write a Description',
                      labelText: 'Description',
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  _showSuccessSnackbar(message){
    var _snackbar = SnackBar(content: message,duration: Duration(seconds: 5),);
    _globalkey.currentState.showSnackBar(_snackbar);
  }

  _editDialogueBox(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (param) {
          return AlertDialog(
            actions: [
              FlatButton(
                onPressed: () => cancelButton(context),
                child: Text('Cancel'),
                color: Colors.red,
              ),
              FlatButton(
                onPressed: () async {
                  Categories categories=Categories(
                    id: category[0]['id'],
                    name:  _editCategoryController.text,
                    description: _editDescriptionController.text
                  );
                  var result = await _categoriesServices.updateCategory(categories);
                  if (result > 0) {
                    print(result);
                    Navigator.pop(context);
                    getAllcategories();
                  }
                },
                child: Text('Update'),
                color: Colors.blue[600],
              ),
            ],
            title: Text('Edit Categories Form'),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  TextField(
                    controller: _editCategoryController,
                    decoration: InputDecoration(
                      hintText: 'Write a Category',
                      labelText: 'Edit Category',
                    ),
                  ),
                  TextField(
                    controller: _editDescriptionController,
                    decoration: InputDecoration(
                      hintText: 'Write a Description',
                      labelText: 'Edit Description',
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  _deleteDialogueBox(BuildContext context, categoriesId) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (param) {
          return AlertDialog(
            actions: [
              FlatButton(
                onPressed: () => cancelButton(context),
                child: Text('Cancel',style: TextStyle(color: Colors.white),),
                color: Colors.cyan[700],
              ),
              FlatButton(
                onPressed: () async {

                  var result = await _categoriesServices.deleteCategory(categoriesId);
                  if (result > 0) {
                    print(result);
                    Navigator.pop(context);
                    getAllcategories();
                    _showSuccessSnackbar(Text('Deleted Successfully'));
                  }
                },
                child: Text('Delete'),
                color: Colors.red[700],
              ),
            ],
            title: Text('Are you sure you want to delete this todo'),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalkey,
      appBar: AppBar(
        leading: RaisedButton(
          color: Theme.of(context).primaryColor,
          elevation: 0.0,
          child: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () => Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => HomeScreen(),
            ),
          ),
        ),
        title: Text('Categories'),
      ),
      body: ListView.builder(
          itemCount: _categorylist.length,
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
                      Text(_categorylist[index].name),
                      IconButton(
                          icon: Icon(
                            Icons.delete,
                            color: Colors.red[700],
                          ),
                          onPressed: () {
                            _deleteDialogueBox(context, _categorylist[index].id);
                          })
                    ],
                  ),
                  leading: IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        editCategory(context, _categorylist[index].id);
                      }),
                  //subtitle: Text(_categorylist[index].description),
                ),
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _showDialogueBox(context),
      ),
    );
  }

  cancelButton(BuildContext context) {
    _categoryController.clear();
    _descriptionController.clear();
    Navigator.pop(context);
    getAllcategories();
  }

}