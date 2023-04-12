// To parse this JSON data, do
//
//     final SubEventModel = SubEventModelFromJson(jsonString);

import 'dart:convert';

SubEventModel SubEventModelFromJson(String str) =>
    SubEventModel.fromJson(json.decode(str));

String SubEventModelToJson(SubEventModel data) => json.encode(data.toJson());

class SubEventModel {
  SubEventModel({
    this.id,
    this.client,
    this.category,
    this.msg,
    this.attachment,
    this.isPrivate,
    this.objId,
  });

  int? id;
  int? client;
  String? category;
  String? msg;
  String? attachment;
  bool? isPrivate;
  int? objId;

  factory SubEventModel.fromJson(Map<String, dynamic> json) => SubEventModel(
        id: json["id"],
        client: json["client"],
        category: json["category"],
        msg: json["msg"],
        attachment: json["attachment"],
        isPrivate: json["is_private"],
        objId: json["obj_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "client": client,
        "category": category,
        "msg": msg,
        "attachment": attachment,
        "is_private": isPrivate,
        "obj_id": objId,
      };
}
