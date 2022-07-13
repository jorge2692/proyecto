// To parse this JSON data, do
//
//     final address = addressFromJson(jsonString);

import 'dart:convert';

Address addressFromJson(String str) => Address.fromJson(json.decode(str));

String addressToJson(Address data) => json.encode(data.toJson());

class Address {
  Address({
    this.id,
    this.idCity,
    this.name,
    this.address,
    this.neighborhood,
    this.lat,
    this.lng,
  });

  String? id;
  int? idCity;
  String? name;
  String? address;
  String? neighborhood;
  double? lat;
  double? lng;
  List<Address> toList = [];


  factory Address.fromJson(Map<String, dynamic> json) => Address(
    id: json["id"] is int ? json['id'].toString() : json['id'],
    idCity: json["id_city"]is int ? json['id_city'] : int.parse(json['id_city']),
    name: json["name"],
    address: json["address"],
    neighborhood: json["neighborhood"],
    lat: json["lat"] is String ? double.parse(json["lat"]): json["lat"],
    lng: json["lng"] is String ? double.parse(json["lng"]): json["lng"],

  );

  Address.fromJsonList(List<dynamic> jsonList){
    if(jsonList == null) return;
    jsonList.forEach((item) {
      Address address = Address.fromJson(item);
      toList.add(address);
    });
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "id_city": idCity,
    "name": name,
    "address": address,
    "neighborhood": neighborhood,
    "lat": lat,
    "lng": lng,
    //"city": city,
  };
}
