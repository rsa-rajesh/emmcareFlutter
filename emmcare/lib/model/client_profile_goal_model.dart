class ClientProfileGoalModel {
  List<ClientProfileGoal>? clientProfileGoal;

  ClientProfileGoalModel({this.clientProfileGoal});

  ClientProfileGoalModel.fromJson(Map<String, dynamic> json) {
    if (json['client_profile_goal'] != null) {
      clientProfileGoal = <ClientProfileGoal>[];
      json['client_profile_goal'].forEach((v) {
        clientProfileGoal!.add(new ClientProfileGoal.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.clientProfileGoal != null) {
      data['client_profile_goal'] =
          this.clientProfileGoal!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ClientProfileGoal {
  String? goals;
  String? detail;
  int? id;

  ClientProfileGoal({this.goals, this.detail, this.id});

  ClientProfileGoal.fromJson(Map<String, dynamic> json) {
    goals = json['Goals'];
    detail = json['detail'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Goals'] = this.goals;
    data['detail'] = this.detail;
    data['id'] = this.id;
    return data;
  }
}
