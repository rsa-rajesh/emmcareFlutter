class ProgressModel {
  List<Progress>? progress;
  ProgressModel({this.progress});
  ProgressModel.fromJson(List<dynamic> parsedJson) {
    progress = parsedJson.map((i) => Progress.fromJson(i)).toList();
  }
}

class Progress {
  int? id;
  String? client;
  String? staff;
  String? category;
  String? summary;
  String? msg;
  String? attachment;
  bool? isPrivate;
  String? createdAt;

  Progress(
      {this.id,
      this.client,
      this.staff,
      this.category,
      this.summary,
      this.msg,
      this.attachment,
      this.isPrivate,
      this.createdAt});

  Progress.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    client = json['client'];
    staff = json['staff'];
    category = json['category'];
    summary = json['summary'];
    msg = json['msg'];
    attachment = json['attachment'];
    isPrivate = json['is_private'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['client'] = this.client;
    data['staff'] = this.staff;
    data['category'] = this.category;
    data['summary'] = this.summary;
    data['msg'] = this.msg;
    data['attachment'] = this.attachment;
    data['is_private'] = this.isPrivate;
    data['created_at'] = this.createdAt;
    return data;
  }
}
