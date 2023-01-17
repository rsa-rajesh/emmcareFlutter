class ClientModel {
  String? _name;
  Address? _address;
  String? _time;
  String? _avatar;
  String? _status;
  int? _id;

  ClientModel(
      {String? name,
      Address? address,
      String? time,
      String? avatar,
      String? status,
      int? id}) {
    if (name != null) {
      this._name = name;
    }
    if (address != null) {
      this._address = address;
    }
    if (time != null) {
      this._time = time;
    }
    if (avatar != null) {
      this._avatar = avatar;
    }
    if (status != null) {
      this._status = status;
    }
    if (id != null) {
      this._id = id;
    }
  }

  String? get name => _name;
  set name(String? name) => _name = name;
  Address? get address => _address;
  set address(Address? address) => _address = address;
  String? get time => _time;
  set time(String? time) => _time = time;
  String? get avatar => _avatar;
  set avatar(String? avatar) => _avatar = avatar;
  String? get status => _status;
  set status(String? status) => _status = status;
  int? get id => _id;
  set id(int? id) => _id = id;

  ClientModel.fromJson(Map<dynamic, dynamic> json) {
    _name = json['name'];
    _address =
        json['address'] != null ? new Address.fromJson(json['address']) : null;
    _time = json['time'];
    _avatar = json['avatar'];
    _status = json['status'];
    _id = int.parse(json['id']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this._name;
    if (this._address != null) {
      data['address'] = this._address!.toJson();
    }
    data['time'] = this._time;
    data['avatar'] = this._avatar;
    data['status'] = this._status;
    data['id'] = this._id;
    return data;
  }
}

class Address {
  String? _street;
  String? _suite;
  String? _city;
  String? _zipcode;
  Geo? _geo;

  Address(
      {String? street,
      String? suite,
      String? city,
      String? zipcode,
      Geo? geo}) {
    if (street != null) {
      this._street = street;
    }
    if (suite != null) {
      this._suite = suite;
    }
    if (city != null) {
      this._city = city;
    }
    if (zipcode != null) {
      this._zipcode = zipcode;
    }
    if (geo != null) {
      this._geo = geo;
    }
  }

  String? get street => _street;
  set street(String? street) => _street = street;
  String? get suite => _suite;
  set suite(String? suite) => _suite = suite;
  String? get city => _city;
  set city(String? city) => _city = city;
  String? get zipcode => _zipcode;
  set zipcode(String? zipcode) => _zipcode = zipcode;
  Geo? get geo => _geo;
  set geo(Geo? geo) => _geo = geo;

  Address.fromJson(Map<String, dynamic> json) {
    _street = json['street'];
    _suite = json['suite'];
    _city = json['city'];
    _zipcode = json['zipcode'];
    _geo = json['geo'] != null ? new Geo.fromJson(json['geo']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['street'] = this._street;
    data['suite'] = this._suite;
    data['city'] = this._city;
    data['zipcode'] = this._zipcode;
    if (this._geo != null) {
      data['geo'] = this._geo!.toJson();
    }
    return data;
  }
}

class Geo {
  String? _lat;
  String? _lng;

  Geo({String? lat, String? lng}) {
    if (lat != null) {
      this._lat = lat;
    }
    if (lng != null) {
      this._lng = lng;
    }
  }

  String? get lat => _lat;
  set lat(String? lat) => _lat = lat;
  String? get lng => _lng;
  set lng(String? lng) => _lng = lng;

  Geo.fromJson(Map<String, dynamic> json) {
    _lat = json['lat'];
    _lng = json['lng'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lat'] = this._lat;
    data['lng'] = this._lng;
    return data;
  }
}
