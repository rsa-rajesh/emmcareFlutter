// ignore_for_file: public_member_api_docs, sort_constructors_first
// To parse this JSON data, do
//
//     final modelClass = modelClassFromJson(jsonString);

import 'dart:convert';

EventsModel modelClassFromJson(String str) =>
    EventsModel.fromJson(json.decode(str));

String modelClassToJson(EventsModel data) => json.encode(data.toJson());

class EventsModel {
  EventsModel({
    this.totalCount,
    this.nextPage,
    this.previousPage,
    required this.results,
  });

  int? totalCount;
  String? nextPage;
  String? previousPage;
  List<Result> results;

  factory EventsModel.fromJson(Map<String, dynamic> json) => EventsModel(
        totalCount: json["TotalCount"],
        nextPage: json["NextPage"],
        previousPage: json["PreviousPage"],
        results:
            List<Result>.from(json["Results"].map((x) => Result.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "TotalCount": totalCount,
        "NextPage": nextPage,
        "PreviousPage": previousPage,
        "Results": List<dynamic>.from(results.map((x) => x.toJson())),
      };
}

class Result {
  int id;
  String? attachment;
  String? createdAt;
  String? staff;
  String? client;
  String? category;
  String? summary;
  String? message;
  bool? isPrivate;

  Result({
    required this.id,
    required this.attachment,
    required this.createdAt,
    required this.staff,
    required this.client,
    required this.category,
    required this.summary,
    required this.message,
    required this.isPrivate,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        attachment: json["attachment"],
        category: json["category"],
        summary: json["summary"],
        message: json["msg"],
        client: json["client"],
        createdAt: json["created_at"],
        staff: json["staff"],
        isPrivate: json["is_private"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "attachment": attachment,
        "category": category,
        "summary": summary,
        "msg": message,
        "client": client,
        "created_at": createdAt,
        "staff": staff,
        "is_private": isPrivate,
        "id": id,
      };
}
