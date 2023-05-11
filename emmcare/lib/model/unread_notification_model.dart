// ignore_for_file: public_member_api_docs, sort_constructors_first
// To parse this JSON data, do
//
//     final modelClass = modelClassFromJson(jsonString);

import 'dart:convert';

UnReadNotificationModel modelClassFromJson(String str) =>
    UnReadNotificationModel.fromJson(json.decode(str));

String modelClassToJson(UnReadNotificationModel data) =>
    json.encode(data.toJson());

class UnReadNotificationModel {
  UnReadNotificationModel({
    this.totalCount,
    this.nextPage,
    this.previousPage,
    this.results,
  });

  int? totalCount;
  String? nextPage;
  String? previousPage;
  List<Result>? results;

  factory UnReadNotificationModel.fromJson(Map<String, dynamic> json) =>
      UnReadNotificationModel(
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
  int id;
  String? staffName;
  String? createdAt;
  String? subject;
  String? message;
  RelatedObj? relatedObj;
  String? notificationType;
  bool? isSeen;

  int? receiver;

  Result({
    required this.id,
    this.staffName,
    this.createdAt,
    this.subject,
    this.message,
    this.relatedObj,
    this.notificationType,
    this.isSeen,
    this.receiver,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        staffName: json["staff_name"],
        notificationType: json["notification_type"],
        isSeen: json["is_seen"],
        message: json["msg"],
        createdAt: json["created_at"],
        subject: json["subject"],
        receiver: json["related_user_id"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "staff_name": staffName,
        "notification_type": notificationType,
        "is_seen": isSeen,
        "msg": message,
        "created_at": createdAt,
        "subject": subject,
        "related_user_id": receiver,
        "id": id,
      };
}

class RelatedObj {
  int? id;
  String? objType;

  RelatedObj({
    this.id,
    this.objType,
  });

  RelatedObj.fromJson(Map<String, dynamic> json) {
    id = json['lat'];
    objType = json['lng'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lat'] = this.id;
    data['lng'] = this.objType;
    return data;
  }
}
