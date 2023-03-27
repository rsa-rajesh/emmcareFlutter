class TasksModel {
  List<Tasks>? tasks;
  TasksModel({this.tasks});

  TasksModel.fromJson(List<dynamic> parsedJson) {
    tasks = parsedJson.map((i) => Tasks.fromJson(i)).toList();
  }
}

class Tasks {
  int? id;
  int? shift;
  String? task;
  bool? mandatory;

  Tasks({this.id, this.shift, this.task, this.mandatory});

  Tasks.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    shift = json['shift'];
    task = json['task'];
    mandatory = json['mandatory'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['shift'] = this.shift;
    data['task'] = this.task;
    data['mandatory'] = this.mandatory;
    return data;
  }
}
