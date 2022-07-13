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
    this.idLavanti,
    this.gpio0,
    // this.idAddress,
    // this.idCity,

  });
  String? idEsp;
  String? ssid;
  String? password;
  bool? gpio0;

  int? idLavanti;
  // int? idAddress;
  // int? idCity;
  List<Esp8266> toList = [];

  factory Esp8266.fromJson(Map<String, dynamic> json) => Esp8266(
    idEsp: json["id"] is int ? json["id"].toString() : json['id'],
    ssid: json["name"] ?? 'nombre',
    password: json["description"] ?? 'descripcion',
    gpio0: json["gpio0"],
    idLavanti: json["id_machine"] is String ? int.parse(json["id_machine"]) : json["id_machine"],
    // idCategory: json["id_category"] is String ? int.parse(json["id_category"]) : json["id_category"],
    // idAddress: json["id_address"]is String ? int.parse(json["id_address"]) : json["id_address"],
    // idCity: json["id_city"],


  );

  Esp8266.fromJsonList(List<dynamic> jsonList){
    if(jsonList == null) return;
    jsonList.forEach((item) {
      Esp8266 esp8266 = Esp8266.fromJson(item);
      toList.add(esp8266);
    });
  }


  Map<String, dynamic> toJson() => {
    "id": idEsp,
    "ssid": ssid,
    "password": password,
    "id_machine":idLavanti,
    "gpio0": false,
    "gpio1":false,
    // "id_category": idCategory,
    // "id_address": idAddress,

  };
  static bool isInteger(num value) => value is int || value == value.roundToDouble();



}
