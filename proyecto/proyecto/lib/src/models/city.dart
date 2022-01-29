
import 'dart:convert';

City cityFromJson(String str) => City.fromJson(json.decode(str));

String cityToJson(City data) => json.encode(data.toJson());

class City {
  City({
    this.id,
    this.name,
    this.department,
  });

  String? id;
  String? name;
  String? department;
  List<City> toList = [];

  factory City.fromJson(Map<String, dynamic> json) => City(
    id: json["id"],
    name: json["name"],
    department: json["department"],
  );

  City.fromJsonList(List<dynamic> jsonList){
    if(jsonList == null) return;
    jsonList.forEach((item) {
      City city = City.fromJson(item);
      toList.add(city);
    });
  }


  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "department": department,
  };
}
