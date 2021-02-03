class Todo{
  int id;
  String name;
  String description;
  String category;
  String todoDate;
  int isFinished;

  Todo(
      {this.id,
      this.name,
      this.description,
      this.category,
      this.todoDate,
      this.isFinished});

  todoMap(){
    var m = Map<String, dynamic>();
    m['id']= id;
    m['title']= name;
    m['description']= description;
    m['category'] = category;
    m['todoDate']= todoDate;
    m['isFinished']= isFinished;
    return m;
  }
}