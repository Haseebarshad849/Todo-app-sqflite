class Categories{
  int id;
  String name;
  String description;

  Categories({this.id, this.name, this.description});

  categoryMap(){
    var mapping = Map<String, dynamic>();
    mapping['id']= id;
    mapping['name']= name;
    mapping['description']= description;
    return mapping;
  }



}