class ProgressModel {
  List<Progress>? progress;

  ProgressModel({this.progress});

  ProgressModel.fromJson(Map<String, dynamic> json) {
    if (json['progress'] != null) {
      progress = <Progress>[];
      json['progress'].forEach((v) {
        progress!.add(new Progress.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.progress != null) {
      data['progress'] = this.progress!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Progress {
  int? id;

  Progress({this.id});

  Progress.fromJson(Map<String, dynamic> json) {
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    return data;
  }
}
