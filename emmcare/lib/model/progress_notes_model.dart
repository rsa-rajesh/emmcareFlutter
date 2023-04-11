// To parse this JSON data, do
//
//     final progressNotesModel = progressNotesModelFromJson(jsonString);

import 'dart:convert';

ProgressNotesModel progressNotesModelFromJson(String str) =>
    ProgressNotesModel.fromJson(json.decode(str));

String progressNotesModelToJson(ProgressNotesModel data) =>
    json.encode(data.toJson());

class ProgressNotesModel {
  ProgressNotesModel({
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

  factory ProgressNotesModel.fromJson(Map<String, dynamic> json) =>
      ProgressNotesModel(
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
