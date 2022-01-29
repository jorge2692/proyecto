// To parse this JSON data, do
//
//     final equipos = equiposFromJson(jsonString);

import 'dart:convert';

Esp8266 esp8266FromJson(String str) => Esp8266.fromJson(json.decode(str));

String esp8266ToJson(Esp8266 data) => json.encode(data.toJson());

class Esp8266 {
  Esp8266({
    this.idEsp,
    this.ssid,
    this.password,
    this.idCategory,
    this.idAddress,
  });
  String? idEsp;
  String? ssid;
  String? password;

  int? idCategory;
  int? idAddress;
  List<Esp8266> toList = [];

  factory Esp8266.fromJson(Map<String, dynamic> json) => Esp8266(
    idEsp: json["id"] is int ? json["id"].toString() : json['id'],
    ssid: json["name"],
    password: json["description"],
    idCategory: json["id_category"] is String ? int.parse(json["id_category"]) : json["id_category"],
    idAddress: json["id_edificio"]is String ? int.parse(json["id_address"]) : json["id_address"],

  );

  Esp8266.fromJsonList(List<dynamic> jsonList){
    if(jsonList == null) return;
    jsonList.forEach((item) {
      Esp8266 equipos = Esp8266.fromJson(item);
      toList.add(equipos);
    });
  }


  Map<String, dynamic> toJson() => {
    "idEsp": idEsp,
    "ssid": ssid,
    "password": password,
    "id_category": idCategory,
    "id_address": idAddress,

  };
  static bool isInteger(num value) => value is int || value == value.roundToDouble();



}
