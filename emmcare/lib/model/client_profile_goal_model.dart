class ClientProfileGoalModel {
  int? count;
  String? next;
  String? previous;
  List<Results>? results;

  ClientProfileGoalModel({this.count, this.next, this.previous, this.results});

  ClientProfileGoalModel.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    next = json['next'];
    previous = json['previous'];
    if (json['results'] != null) {
      results = <Results>[];
      json['results'].forEach((v) {
        results!.add(new Results.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    data['next'] = this.next;
    data['previous'] = this.previous;
    if (this.results != null) {
      data['results'] = this.results!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Results {
  int? id;
  int? client;
  String? name;
  String? commencedAt;
  String? achievedAt;
  String? closedAt;
  String? description;
  bool? isAchieved;
  bool? isClosed;

  Results(
      {this.id,
      this.client,
      this.name,
      this.commencedAt,
      this.achievedAt,
      this.closedAt,
      this.description,
      this.isAchieved,
      this.isClosed});

  Results.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    client = json['client'];
    name = json['name'];
    commencedAt = json['commenced_at'];
    achievedAt = json['achieved_at'];
    closedAt = json['closed_at'];
    description = json['description'];
    isAchieved = json['is_achieved'];
    isClosed = json['is_closed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['client'] = this.client;
    data['name'] = this.name;
    data['commenced_at'] = this.commencedAt;
    data['achieved_at'] = this.achievedAt;
    data['closed_at'] = this.closedAt;
    data['description'] = this.description;
    data['is_achieved'] = this.isAchieved;
    data['is_closed'] = this.isClosed;
    return data;
  }
}
