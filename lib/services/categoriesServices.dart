import 'package:todo_app_sqflite/models/categories.dart';
import 'package:todo_app_sqflite/repositories/repositories.dart';

class CategoryServices{
  Repositories _repositories;

  CategoryServices(){
    _repositories= Repositories();
  }

  // Save Category to database table
  saveCategory(Categories categories) async{
   return await _repositories.insertData('categories', categories.categoryMap());
  }

  //Read category from database table
  readCategory() async{
    return await _repositories.readData("categories");
  }

  //Read category from database table by """ID"""
  readCategorbyId(categoryId) async{
    return await _repositories.readDatabyId('categories',categoryId);
  }

  //Update category from database table by """ID"""
  updateCategory(Categories categories) async{
    return await _repositories.updateData('categories', categories.categoryMap());
  }

  deleteCategory(categoryId) async{
    return await _repositories.deleteData('categories', categoryId);
  }

}