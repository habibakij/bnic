/// created by AK IJ
/// 13-11-2020

import 'dart:convert';

// To parse this JSON data, do
//
//final overseasJsonModel = overseasJsonModelFromJson(jsonString);


OverseasJsonModel overseasJsonModelFromJson(String str) => OverseasJsonModel.fromJson(json.decode(str));

String overseasJsonModelToJson(OverseasJsonModel data) => json.encode(data.toJson());

class OverseasJsonModel {
  OverseasJsonModel({this.status, this.message, this.list,});

  int status;
  String message;
  List<ListElement> list;

  factory OverseasJsonModel.fromJson(Map<String, dynamic> json) => OverseasJsonModel(
    status: json["status"],
    message: json["message"],
    list: List<ListElement>.from(json["list"].map((x) => ListElement.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "list": List<dynamic>.from(list.map((x) => x.toJson())),
  };
}

class ListElement {
  ListElement({this.id, this.name, this.code, this.seat,});

  int id;
  String name;
  String code;
  List<Seat> seat;

  factory ListElement.fromJson(Map<String, dynamic> json) => ListElement(
    id: json["id"],
    name: json["name"],
    code: json["code"],
    seat: List<Seat>.from(json["seat"].map((x) => Seat.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "code": code,
    "seat": List<dynamic>.from(seat.map((x) => x.toJson())),
  };
}

class Seat {
  Seat({this.id, this.name, this.maxCapacity,});

  String id;
  Name name;
  String maxCapacity;

  factory Seat.fromJson(Map<String, dynamic> json) => Seat(
    id: json["id"],
    name: nameValues.map[json["name"]],
    maxCapacity: json["max_capacity"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": nameValues.reverse[name],
    "max_capacity": maxCapacity,
  };
}

enum Name { DRIVER, PASSENGER, HELPER }

final nameValues = EnumValues({
  "Driver": Name.DRIVER,
  "Helper": Name.HELPER,
  "Passenger": Name.PASSENGER
});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
