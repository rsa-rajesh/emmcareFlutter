class ClientModel {
  String? name;
  Address? address;
  String? time;
  String? avatar;
  String? status;
  String? id;

  ClientModel(
      {this.name, this.address, this.time, this.avatar, this.status, this.id});

  ClientModel.fromJson(Map<dynamic, dynamic> json) {
    name = json['name'];
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
  Geo? geo;

  Address({this.street, this.suite, this.city, this.zipcode, this.geo});

  Address.fromJson(Map<String, dynamic> json) {
    street = json['street'];
    suite = json['suite'];
    city = json['city'];
    zipcode = json['zipcode'];
    geo = json['geo'] != null ? new Geo.fromJson(json['geo']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['street'] = this.street;
    data['suite'] = this.suite;
    data['city'] = this.city;
    data['zipcode'] = this.zipcode;
    if (this.geo != null) {
      data['geo'] = this.geo!.toJson();
    }
    return data;
  }
}

class Geo {
  String? lat;
  String? lng;

  Geo({this.lat, this.lng});

  Geo.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    lng = json['lng'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    return data;
  }
}
