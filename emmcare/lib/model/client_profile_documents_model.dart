// ignore_for_file: public_member_api_docs, sort_constructors_first
// To parse this JSON data, do
//
//     final modelClass = modelClassFromJson(jsonString);

import 'dart:convert';

ClientProfileDocumentsModel modelClassFromJson(String str) =>
    ClientProfileDocumentsModel.fromJson(json.decode(str));

String modelClassToJson(ClientProfileDocumentsModel data) =>
    json.encode(data.toJson());

class ClientProfileDocumentsModel {
  ClientProfileDocumentsModel({
    this.totalCount,
    this.nextPage,
    this.previousPage,
    this.results,
  });

  int? totalCount;
  String? nextPage;
  String? previousPage;
  List<Result>? results;

  factory ClientProfileDocumentsModel.fromJson(Map<String, dynamic> json) =>
      ClientProfileDocumentsModel(
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
        "Results": List<dynamic>.from(results!.map((x) => x.toJson())),
      };
}

class Result {
  int? id;
  String? file;
  String? uploadDate;
  String? updateDate;
  String? expiryDate;
  String? contentType;
  String? docCategory;
  String? relatedUserType;
  int? realtedUserId;
  String? user;
  Result({
    this.id,
    this.file,
    this.uploadDate,
    this.updateDate,
    this.expiryDate,
    this.contentType,
    this.docCategory,
    this.relatedUserType,
    this.realtedUserId,
    this.user,
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
