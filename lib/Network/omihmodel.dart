/// created by AK IJ
/// 13-11-2020

import 'dart:convert';

TypeModel typeModelFromJson(String str) => TypeModel.fromJson(json.decode(str));

String typeModelToJson(TypeModel data) => json.encode(data.toJson());

class TypeModel {
  TypeModel({this.status, this.message, this.list,});

  int status;
  String message;
  List<ListElement> list;

  factory TypeModel.fromJson(Map<String, dynamic> json) => TypeModel(
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
  ListElement({this.id, this.name, this.policy,});

  int id;
  String name;
  String policy;

  factory ListElement.fromJson(Map<String, dynamic> json) => ListElement(
    id: json["id"],
    name: json["name"],
    policy: json["policy"] == null ? null : json["policy"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "policy": policy == null ? null : policy,
  };
}
