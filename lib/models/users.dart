class Users{
  String id;
  final String name;
  final String gender;
  final String dateofbirth;
  final int height;


  Users(this.id, this.name, this.gender, this.dateofbirth, this.height);

  Map<String, dynamic> toJson()=>{
    'id':id,
    'name':name,
    'gender':gender,
    'dateofbirth':dateofbirth,
    'height':height
  };

  static Users fromJson(Map<String, dynamic> json)=>Users(
      json['id'],
      json['name'],
      json['gender'],
      json['dateofbirth'],
      json['height'],

  );
}