// To parse this JSON data, do
//
//     final modelClass = modelClassFromJson(jsonString);

import 'dart:convert';

MyDocumentModel modelClassFromJson(String str) =>
    MyDocumentModel.fromJson(json.decode(str));

String modelClassToJson(MyDocumentModel data) => json.encode(data.toJson());

class MyDocumentModel {
  MyDocumentModel({
    required this.totalCount,
    this.nextPage,
    this.previousPage,
    required this.results,
  });

  int totalCount;
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
  Result({
    required this.user,
    required this.file,
    required this.contentType,
    required this.docCategory,
    required this.relatedUserType,
  });

  String user;
  String file;
  String contentType;
  String docCategory;
  String relatedUserType;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        user: json["user"],
        file: json["file"],
        contentType: json["content_type"],
        docCategory: json["doc_category"],
        relatedUserType: json["related_user_type"],
      );

  Map<String, dynamic> toJson() => {
        "user": user,
        "file": file,
        "content_type": contentType,
        "doc_category": docCategory,
        "related_user_type": relatedUserType,
      };
}
