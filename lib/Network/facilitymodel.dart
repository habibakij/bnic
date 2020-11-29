/// created by AK IJ
/// 29-11-2020

// To parse this JSON data, do
//
//     final facilityModel = facilityModelFromJson(jsonString);

import 'dart:convert';

FacilityModel facilityModelFromJson(String str) => FacilityModel.fromJson(json.decode(str));

String facilityModelToJson(FacilityModel data) => json.encode(data.toJson());

class FacilityModel {
  FacilityModel({this.status, this.message, this.list,});

  int status;
  String message;
  List<ListElement1> list;

  factory FacilityModel.fromJson(Map<String, dynamic> json) => FacilityModel(
    status: json["status"],
    message: json["message"],
    list: List<ListElement1>.from(json["list"].map((x) => ListElement1.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "list": List<dynamic>.from(list.map((x) => x.toJson())),
  };
}

class ListElement1 {
  ListElement1({this.id, this.name, this.cost,});

  String id;
  String name;
  String cost;

  factory ListElement1.fromJson(Map<String, dynamic> json) => ListElement1(
    id: json["id"],
    name: json["name"],
    cost: json["cost"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "cost": cost,
  };
}
