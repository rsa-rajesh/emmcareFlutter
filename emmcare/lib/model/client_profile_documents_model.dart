class ClientProfileDocumentsModel {
  List<Results>? results;

  ClientProfileDocumentsModel({this.results});

  ClientProfileDocumentsModel.fromJson(List<dynamic> parsedJson) {
    // List<Clients> clients = <Clients>[];
    results = parsedJson.map((i) => Results.fromJson(i)).toList();
    // return new ClientProfileDocumentsModel(
    //   clients: clients
    // );
  }
}

class Results {
  int? userId;
  int? id;
  String? title;
  String? body;

  Results({this.userId, this.id, this.title, this.body});

  Results.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    id = json['id'];
    title = json['title'];
    body = json['body'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['id'] = this.id;
    data['title'] = this.title;
    data['body'] = this.body;
    return data;
  }
}
