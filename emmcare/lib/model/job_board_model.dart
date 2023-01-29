class JobBoardModel {
  List<Jobs>? jobs;

  JobBoardModel({this.jobs});

  JobBoardModel.fromJson(Map<String, dynamic> json) {
    if (json['jobs'] != null) {
      jobs = <Jobs>[];
      json['jobs'].forEach((v) {
        jobs!.add(new Jobs.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.jobs != null) {
      data['jobs'] = this.jobs!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Jobs {
  String? job;
  String? day;
  String? number;
  int? id;

  Jobs({this.job, this.day, this.number, this.id});

  Jobs.fromJson(Map<String, dynamic> json) {
    job = json['job'];
    day = json['day'];
    number = json['number'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['job'] = this.job;
    data['day'] = this.day;
    data['number'] = this.number;
    data['id'] = this.id;
    return data;
  }
}
