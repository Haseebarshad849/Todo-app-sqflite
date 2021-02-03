import 'package:flutter/material.dart';
import 'package:todo_app_sqflite/Screens/homeScreen.dart';
import 'package:todo_app_sqflite/Screens/categories.dart';
import 'package:todo_app_sqflite/Screens/todoByCategory.dart';
import 'package:todo_app_sqflite/services/categoriesServices.dart';

class DrawerNavigation extends StatefulWidget {
  @override
  _DrawerNavigationState createState() => _DrawerNavigationState();
}

class _DrawerNavigationState extends State<DrawerNavigation> {
  List<Widget> _categorylist = List<Widget>();
  var _categoriesServices = CategoryServices();

  @override
  void initState() {
    super.initState();
    getAllcategories();
  }

  getAllcategories() async {
    var categories = await _categoriesServices.readCategory();
    categories.forEach((categories) {
      setState(() {
        _categorylist.add(InkWell(
          onTap: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => TodoByCategory(
                    category: categories['name'],
                  ))),
          child: ListTile(
            title: Text(categories['name']),
          ),
        ));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage(
                    'https://i1.sndcdn.com/avatars-000282250058-lz8l70-t500x500.jpg'),
              ),
              accountName: Text('Haseeb Malik'),
              accountEmail: Text('haseeb@gmail.com'),
              decoration: BoxDecoration(color: Colors.red[900]),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text(
                'Home',
                style: TextStyle(fontSize: 18.0),
              ),
              onTap: () => Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => HomeScreen(),
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.view_list),
              title: Text(
                'Categories',
                style: TextStyle(fontSize: 18.0),
              ),
              onTap: () => Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => CategoriesScreen(),
                ),
              ),
            ),
            Divider(
              thickness: 2.0,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 70.0),
              child: Column(
                children: _categorylist,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
