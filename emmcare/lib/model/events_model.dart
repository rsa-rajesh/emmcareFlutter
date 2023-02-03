class EventsModel {
  List<Events>? events;

  EventsModel({this.events});

  EventsModel.fromJson(Map<String, dynamic> json) {
    if (json['events'] != null) {
      events = <Events>[];
      json['events'].forEach((v) {
        events!.add(new Events.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.events != null) {
      data['events'] = this.events!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Events {
  String? clientName;
  String? heading;
  String? supporter;
  String? date;
  String? title;
  String? subtitle;
  String? shiftImage;
  String? time;
  String? clientImage;
  String? desc;
  int? id;

  Events(
      {this.clientName,
      this.heading,
      this.supporter,
      this.date,
      this.title,
      this.subtitle,
      this.shiftImage,
      this.time,
      this.clientImage,
      this.desc,
      this.id});

  Events.fromJson(Map<String, dynamic> json) {
    clientName = json['client_name'];
    heading = json['heading'];
    supporter = json['supporter'];
    date = json['date'];
    title = json['title'];
    subtitle = json['subtitle'];
    shiftImage = json['shift_image'];
    time = json['time'];
    clientImage = json['client_image'];
    desc = json['desc'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['client_name'] = this.clientName;
    data['heading'] = this.heading;
    data['supporter'] = this.supporter;
    data['date'] = this.date;
    data['title'] = this.title;
    data['subtitle'] = this.subtitle;
    data['shift_image'] = this.shiftImage;
    data['time'] = this.time;
    data['client_image'] = this.clientImage;
    data['desc'] = this.desc;
    data['id'] = this.id;
    return data;
  }
}
