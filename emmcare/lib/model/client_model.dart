class ClientModel {
  List<Clients>? clients;

  ClientModel({this.clients});

  ClientModel.fromJson(Map<String, dynamic> json) {
    if (json['clients'] != null) {
      clients = <Clients>[];
      json['clients'].forEach((v) {
        clients!.add(new Clients.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.clients != null) {
      data['clients'] = this.clients!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Clients {
  String? name;
  String? purpose;
  Address? address;
  String? time;
  String? avatar;
  String? status;
  int? id;

  Clients(
      {this.name,
      this.purpose,
      this.address,
      this.time,
      this.avatar,
      this.status,
      this.id});

  Clients.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    purpose = json['purpose'];
    address =
        json['address'] != null ? new Address.fromJson(json['address']) : null;
    time = json['time'];
    avatar = json['avatar'];
    status = json['status'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['purpose'] = this.purpose;
    if (this.address != null) {
      data['address'] = this.address!.toJson();
    }
    data['time'] = this.time;
    data['avatar'] = this.avatar;
    data['status'] = this.status;
    data['id'] = this.id;
    return data;
  }
}

class Address {
  String? street;
  String? suite;
  String? city;
  String? zipcode;

  Address({this.street, this.suite, this.city, this.zipcode});

  Address.fromJson(Map<String, dynamic> json) {
    street = json['street'];
    suite = json['suite'];
    city = json['city'];
    zipcode = json['zipcode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['street'] = this.street;
    data['suite'] = this.suite;
    data['city'] = this.city;
    data['zipcode'] = this.zipcode;
    return data;
  }
}
