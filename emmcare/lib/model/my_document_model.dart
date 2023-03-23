// ignore_for_file: public_member_api_docs, sort_constructors_first
// To parse this JSON data, do
//
//     final modelClass = modelClassFromJson(jsonString);

import 'dart:convert';

MyDocumentModel modelClassFromJson(String str) =>
    MyDocumentModel.fromJson(json.decode(str));

String modelClassToJson(MyDocumentModel data) => json.encode(data.toJson());

class MyDocumentModel {
  MyDocumentModel({
    this.totalCount,
    this.nextPage,
    this.previousPage,
    required this.results,
  });

  int? totalCount;
  String? nextPage;
  String? previousPage;
  List<Result> results;

  factory MyDocumentModel.fromJson(Map<String, dynamic> json) =>
      MyDocumentModel(
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
  String file;
  String uploadDate;
  String updateDate;
  String expiryDate;
  String contentType;
  String docCategory;
  String relatedUserType;
  int realtedUserId;
  String user;
  Result({
    required this.id,
    required this.file,
    required this.uploadDate,
    required this.updateDate,
    required this.expiryDate,
    required this.contentType,
    required this.docCategory,
    required this.relatedUserType,
    required this.realtedUserId,
    required this.user,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        user: json["user"],
        file: json["file"],
        contentType: json["content_type"],
        docCategory: json["doc_category"],
        relatedUserType: json["related_user_type"],
        expiryDate: json["expiry_date"],
        uploadDate: json["upload_date"],
        updateDate: json["update_date"],
        realtedUserId: json["related_user_id"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "user": user,
        "file": file,
        "content_type": contentType,
        "doc_category": docCategory,
        "related_user_type": relatedUserType,
        "expiry_date": expiryDate,
        "upload_date": uploadDate,
        "update_date": updateDate,
        "related_user_id": realtedUserId,
        "id": id,
      };
}
