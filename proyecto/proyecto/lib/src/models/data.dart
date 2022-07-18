// To parse this JSON data, do
//
//     final category = categoryFromJson(jsonString);

import 'dart:convert';

Category categoryFromJson(String str) => Category.fromJson(json.decode(str));

String categoryToJson(Category data) => json.encode(data.toJson());

class Category {
  Category({
    this.id,
    this.voltage,
    this.ampers,
    this.potency,
    this.createdAt,
  });

  String? id;
  String? voltage;
  String? ampers;
  String? potency;
  DateTime? createdAt;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json["id"],
    voltage: json["voltage"],
    ampers: json["ampers"],
    potency: json["potency"],
    createdAt: DateTime.parse(json["created_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "voltage": voltage,
    "ampers": ampers,
    "potency": potency,
    "created_at": createdAt!.toIso8601String(),
  };
}
