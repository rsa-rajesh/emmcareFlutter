class ClientModel {
  List<Clients>? clients;

  ClientModel({this.clients});

  ClientModel.fromJson(List<dynamic> parsedJson) {
    // List<Clients> clients = <Clients>[];
    clients = parsedJson.map((i) => Clients.fromJson(i)).toList();
    // return new ClientModel(
    //   clients: clients
    // );
  }
}

class Clients {
  int? id;
  String? createdAt;
  String? client;
  int? clientId;
  String? staff;
  // List<String>? allowance;
  double? mileage;
  double? additionalCost;
  int? staffId;
  String? shiftType;
  String? shiftTypeColor;
  String? shiftStatus;
  bool? isRepeatative;
  // List<String>? shiftNotes;
  // String? recurranceDetail;
  int? priceBook;
  String? priceBookName;
  String? shiftFullAddress;
  String? shiftStartDate;
  String? shiftEndDate;
  String? shiftStartTime;
  bool? hasMultipleUser;
  Location? location;
  String? staffImg;
  String? clientImg;
  String? shiftEndTime;
  String? finalEndDate;
  int? staffTotalHrs;
  String? clockIn;
  String? clockOut;
  String? instruction;

  Clients(
      {this.id,
      this.createdAt,
      this.client,
      this.clientId,
      this.staff,
      // this.allowance,
      this.mileage,
      this.additionalCost,
      this.staffId,
      this.shiftType,
      this.shiftTypeColor,
      this.shiftStatus,
      this.isRepeatative,
      // this.shiftNotes,
      // this.recurranceDetail,
      this.priceBook,
      this.priceBookName,
      this.shiftFullAddress,
      this.shiftStartDate,
      this.shiftEndDate,
      this.shiftStartTime,
      this.hasMultipleUser,
      this.location,
      this.staffImg,
      this.clientImg,
      this.shiftEndTime,
      this.finalEndDate,
      this.staffTotalHrs,
      this.clockIn,
      this.clockOut,
      this.instruction});

  Clients.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    client = json['client'];
    clientId = json['client_id'];
    staff = json['staff'];
    // allowance = json['allowance'].cast<String>();
    mileage = json['mileage'];
    additionalCost = json['additional_cost'];
    staffId = json['staff_id'];
    shiftType = json['shift_type'];
    shiftTypeColor = json['shift_type_color'];
    shiftStatus = json['shift_status'];
    isRepeatative = json['is_repeatative'];
    // shiftNotes = json['shift_notes'].cast<String>();
    // recurranceDetail = json['recurrance_detail'];
    priceBook = json['price_book'];
    priceBookName = json['price_book_name'];
    shiftFullAddress = json['shift_full_address'];
    shiftStartDate = json['shift_start_date'];
    shiftEndDate = json['shift_end_date'];
    shiftStartTime = json['shift_start_time'];
    hasMultipleUser = json['has_multiple_user'];
    staffImg = json['staff_img'];
    clientImg = json['client_img'];
    shiftEndTime = json['shift_end_time'];
    finalEndDate = json['final_end_date'];
    staffTotalHrs = json['staff_total_hrs'];
    location = json['location'] != null
        ? new Location.fromJson(json['location'])
        : null;
    clockIn = json['clock_in'];
    clockOut = json['clock_out'];
    instruction = json['instruction'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['created_at'] = this.createdAt;
    data['client'] = this.client;
    data['client_id'] = this.clientId;
    data['staff'] = this.staff;
    // data['allowance'] = this.allowance;
    data['mileage'] = this.mileage;
    data['additional_cost'] = this.additionalCost;
    data['staff_id'] = this.staffId;
    data['shift_type'] = this.shiftType;
    data['shift_type_color'] = this.shiftTypeColor;
    data['shift_status'] = this.shiftStatus;
    data['is_repeatative'] = this.isRepeatative;
    // data['shift_notes'] = this.shiftNotes;
    // data['recurrance_detail'] = this.recurranceDetail;
    data['price_book'] = this.priceBook;
    data['price_book_name'] = this.priceBookName;
    data['shift_full_address'] = this.shiftFullAddress;
    data['shift_start_date'] = this.shiftStartDate;
    data['shift_end_date'] = this.shiftEndDate;
    data['shift_start_time'] = this.shiftStartTime;
    data['has_multiple_user'] = this.hasMultipleUser;
    data['staff_img'] = this.staffImg;
    data['client_img'] = this.clientImg;
    data['shift_end_time'] = this.shiftEndTime;
    data['final_end_date'] = this.finalEndDate;
    data['staff_total_hrs'] = this.staffTotalHrs;
    data['clock_in'] = this.clockIn;
    data['clock_out'] = this.clockOut;
    data['instruction'] = this.instruction;
    if (this.location != null) {
      data['location'] = this.location!.toJson();
    }

    return data;
  }
}

class Location {
  double? lat;
  double? lng;

  Location({this.lat, this.lng});

  Location.fromJson(Map<String, dynamic> json) {
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
