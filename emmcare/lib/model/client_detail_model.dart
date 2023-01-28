class ClientDetailModel {
  List<ClientDetail>? clientDetail;

  ClientDetailModel({this.clientDetail});

  ClientDetailModel.fromJson(Map<String, dynamic> json) {
    if (json['ClientDetail'] != null) {
      clientDetail = <ClientDetail>[];
      json['ClientDetail'].forEach((v) {
        clientDetail!.add(new ClientDetail.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() { 
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.clientDetail != null) {
      data['ClientDetail'] = this.clientDetail!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ClientDetail {
  String? name;
  Address? address;
  String? avatar;
  int? id;
  String? status;

  ClientDetail({this.name, this.address, this.avatar, this.id, this.status});

  ClientDetail.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    address =
        json['address'] != null ? new Address.fromJson(json['address']) : null;
    avatar = json['avatar'];
    id = json['id'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    if (this.address != null) {
      data['address'] = this.address!.toJson();
    }
    data['avatar'] = this.avatar;
    data['id'] = this.id;
    data['status'] = this.status;
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
