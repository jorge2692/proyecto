import 'dart:convert';

ErrorData errorFromJson(String str) => ErrorData.fromJson(json.decode(str));

class ErrorData {
  ErrorData({
    this.id,
    this.voltage,
    this.amp,
    this.idEsp,
    this.alert,
    this.machineName,
    this.potency,
    this.createdAt
  });
  String? id;
  String? voltage;
  String? amp;
  String? potency;
  String? idEsp;
  String? alert;
  String? machineName;
  DateTime? createdAt;

  factory ErrorData.fromJson(Map<String, dynamic> json) => ErrorData(
    id: json["id"] is int ? json["id"].toString() : json['id'],
    voltage: json["voltage"].toString(),
    amp: json["ampers"].toString(),
    potency: json["potency"].toString(),
    idEsp: json["id_esp"].toString(),
    alert: json["alert"].toString(),
    machineName: json['name'],
    createdAt: DateTime.parse(json['created_at']),
  );


  static bool isInteger(num value) => value is int || value == value.roundToDouble();

}
