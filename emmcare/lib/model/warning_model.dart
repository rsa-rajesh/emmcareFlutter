// To parse this JSON data, do
//
//     final WarningModel = WarningModelFromJson(jsonString);

import 'dart:convert';

WarningModel WarningModelFromJson(String str) =>
    WarningModel.fromJson(json.decode(str));

String WarningModelToJson(WarningModel data) => json.encode(data.toJson());

class WarningModel {
  WarningModel({
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

  factory WarningModel.fromJson(Map<String, dynamic> json) => WarningModel(
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
