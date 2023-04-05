// To parse this JSON data, do
//
//     final clientProfileGoalModel = clientProfileGoalModelFromJson(jsonString);

// import 'dart:convert';

// ClientProfileGoalModel clientProfileGoalModelFromJson(String str) =>
//     ClientProfileGoalModel.fromJson(json.decode(str));

// String clientProfileGoalModelToJson(ClientProfileGoalModel data) =>
//     json.encode(data.toJson());

class ClientProfileGoalModel {
  ClientProfileGoalModel({
    this.totalCount,
    this.totalPageCount,
    this.countItemsOnPage,
    this.currentPage,
    this.nextPage,
    this.previousPage,
    this.results,
  });

  int? totalCount;
  int? totalPageCount;
  int? countItemsOnPage;
  int? currentPage;
  String? nextPage;
  String? previousPage;
  List<Result>? results;

  factory ClientProfileGoalModel.fromJson(Map<String, dynamic> json) =>
      ClientProfileGoalModel(
        totalCount: json["TotalCount"],
        totalPageCount: json["TotalPageCount"],
        countItemsOnPage: json["countItemsOnPage"],
        currentPage: json["CurrentPage"],
        nextPage: json["NextPage"],
        previousPage: json["PreviousPage"],
        results:
            List<Result>.from(json["Results"].map((x) => Result.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "TotalCount": totalCount,
        "TotalPageCount": totalPageCount,
        "countItemsOnPage": countItemsOnPage,
        "CurrentPage": currentPage,
        "NextPage": nextPage,
        "PreviousPage": previousPage,
        "Results": List<dynamic>.from(results!.map((x) => x.toJson())),
      };
}

class Result {
  Result({
    this.id,
    this.client,
    this.name,
    this.commencedAt,
    this.achievedAt,
    this.closedAt,
    this.description,
    this.isAchieved,
    this.isClosed,
    this.goalStrategies,
  });

  int? id;
  int? client;
  String? name;
  String? commencedAt;
  String? achievedAt;
  String? closedAt;
  String? description;
  bool? isAchieved;
  bool? isClosed;
  List<GoalStrategy>? goalStrategies;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        client: json["client"],
        name: json["name"],
        commencedAt: json["commenced_at"],
        achievedAt: json["achieved_at"],
        closedAt: json["closed_at"],
        description: json["description"],
        isAchieved: json["is_achieved"],
        isClosed: json["is_closed"],
        goalStrategies: List<GoalStrategy>.from(
            json["goal_strategies"].map((x) => GoalStrategy.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "client": client,
        "name": name,
        "commenced_at": commencedAt,
        "achieved_at": achievedAt,
        "closed_at": closedAt,
        "description": description,
        "is_achieved": isAchieved,
        "is_closed": isClosed,
        "goal_strategies":
            List<dynamic>.from(goalStrategies!.map((x) => x.toJson())),
      };
}

class GoalStrategy {
  GoalStrategy({
    this.id,
    this.goal,
    this.dueAt,
    this.reviewAt,
    this.reviewOutcome,
    this.completeAt,
    this.completeOutcome,
    this.description,
    this.rating,
  });

  int? id;
  int? goal;
  String? dueAt;
  String? reviewAt;
  String? reviewOutcome;
  String? completeAt;
  String? completeOutcome;
  String? description;
  int? rating;

  factory GoalStrategy.fromJson(Map<String, dynamic> json) => GoalStrategy(
        id: json["id"],
        goal: json["goal"],
        dueAt: json["due_at"],
        reviewAt: json["review_at"],
        reviewOutcome: json["review_outcome"],
        completeAt: json["complete_at"],
        completeOutcome: json["complete_outcome"],
        description: json["description"],
        rating: json["rating"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "goal": goal,
        "due_at": dueAt,
        "review_at": reviewAt,
        "review_outcome": reviewOutcome,
        "complete_at": completeAt,
        "complete_outcome": completeOutcome,
        "description": description,
        "rating": rating,
      };
}
