class ClientGoalStrategyModel {
  int? id;
  int? goal;
  String? dueAt;
  String? reviewAt;
  String? reviewOutcome;
  String? completeAt;
  String? completeOutcome;
  String? description;
  int? rating;

  ClientGoalStrategyModel(
      {this.id,
      this.goal,
      this.dueAt,
      this.reviewAt,
      this.reviewOutcome,
      this.completeAt,
      this.completeOutcome,
      this.description,
      this.rating});

  ClientGoalStrategyModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    goal = json['goal'];
    dueAt = json['due_at'];
    reviewAt = json['review_at'];
    reviewOutcome = json['review_outcome'];
    completeAt = json['complete_at'];
    completeOutcome = json['complete_outcome'];
    description = json['description'];
    rating = json['rating'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['goal'] = this.goal;
    data['due_at'] = this.dueAt;
    data['review_at'] = this.reviewAt;
    data['review_outcome'] = this.reviewOutcome;
    data['complete_at'] = this.completeAt;
    data['complete_outcome'] = this.completeOutcome;
    data['description'] = this.description;
    data['rating'] = this.rating;
    return data;
  }
}
