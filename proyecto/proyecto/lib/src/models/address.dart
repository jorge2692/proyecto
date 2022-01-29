// To parse this JSON data, do
//
//     final edificio = edificioFromJson(jsonString);

import 'dart:convert';

Edificio edificioFromJson(String str) => Edificio.fromJson(json.decode(str));

String edificioToJson(Edificio data) => json.encode(data.toJson());

class Edificio {
  Edificio({
    this.id,
    this.name,
    this.description,
  });

  String? id;
  String? name;
  String? description;
  List<Edificio> toList = [];


  factory Edificio.fromJson(Map<String, dynamic> json) => Edificio(
    id: json["id"],
    name: json["name"],
    description: json["description"],
  );

  Edificio.fromJsonList(List<dynamic> jsonList){
    if(jsonList == null) return;
    jsonList.forEach((item) {
      Edificio edificio = Edificio.fromJson(item);
      toList.add(edificio);
    });
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
  };
}
