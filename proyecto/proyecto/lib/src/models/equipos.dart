// To parse this JSON data, do
//
//     final equipos = equiposFromJson(jsonString);

import 'dart:convert';

Equipos equiposFromJson(String str) => Equipos.fromJson(json.decode(str));

String equiposToJson(Equipos data) => json.encode(data.toJson());

class Equipos {
  Equipos({
    this.id,
    this.name,
    this.description,
    this.serial,
    this.model,
    this.idlavanti,
    this.voltaje,
    this.corriente,
    this.potencia,
    this.image1,
    this.image2,
    this.idCategory,
    this.idAddress,
  });
  String? id;
  String? name;
  String? description;
  String? serial;
  String? model;
  double? idlavanti;
  double? voltaje;
  double? corriente;
  double? potencia;
  String? image1;
  String? image2;
  int? idCategory;
  int? idAddress;
  List<Equipos> toList = [];

  factory Equipos.fromJson(Map<String, dynamic> json) => Equipos(
    id: json["id"] is int ? json["id"].toString() : json['id'],
    name: json["name"],
    description: json["description"],
    serial: json["serial"],
    model: json["model"],
    idlavanti: json['id_lavanti'] is String ? double.parse(json["id_lavanti"]) : isInteger(json["id_lavanti"]) ? json["id_lavanti"] : json['id_lavanti'],
    voltaje: json['voltaje'] is String ? double.parse(json["voltaje"]) : isInteger(json["voltaje"]) ? json["voltaje"] : json['voltaje'],
    corriente: json['corriente'] is String ? double.parse(json["corriente"]) : isInteger(json["corriente"]) ? json["corriente"] : json['corriente'],
    potencia: json['potencia'] is String ? double.parse(json["potencia"]) : isInteger(json["potencia"]) ? json["potencia"] : json['potencia'],
    image1: json["image1"],
    image2: json["image2"],
    idCategory: json["id_category"] is String ? int.parse(json["id_category"]) : json["id_category"],
    idAddress:  json["id_address"]is String ? int.parse(json["id_address"]) : json["id_address"],
  );

  Equipos.fromJsonList(List<dynamic> jsonList){
    for (var item in jsonList) {
      Equipos equipos = Equipos.fromJson(item);
      toList.add(equipos);
    }
  }

  List<Equipos> fromJsonList2(List<dynamic>? list) {
    List<Equipos> result = [];
    list?.forEach((e){
      result.add(Equipos.fromJson(e));
    });
    return result;
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "serial": serial,
    "model": model,
    "id_lavanti": idlavanti,
    "voltaje": voltaje,
    "corriente": corriente,
    "potencia": potencia,
    "image1": image1,
    "image2": image2,
    "id_category": idCategory,
    "id_address": idAddress,

  };
  static bool isInteger(num value) => value is int || value == value.roundToDouble();



}
