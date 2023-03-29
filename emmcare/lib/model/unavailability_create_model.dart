class UnavailabilityCreateModel {
  int? id;
  String? unavailableDate;
  bool? allDay;
  String? startTime;
  String? endTime;
  String? unavailableReason;
  String? addedBy;
  int? staff;

  UnavailabilityCreateModel(
      {this.id,
      this.unavailableDate,
      this.allDay,
      this.startTime,
      this.endTime,
      this.unavailableReason,
      this.addedBy,
      this.staff});

  UnavailabilityCreateModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    unavailableDate = json['unavailable_date'];
    allDay = json['all_day'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    unavailableReason = json['unavailable_reason'];
    addedBy = json['added_by'];
    staff = json['staff'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['unavailable_date'] = this.unavailableDate;
    data['all_day'] = this.allDay;
    data['start_time'] = this.startTime;
    data['end_time'] = this.endTime;
    data['unavailable_reason'] = this.unavailableReason;
    data['added_by'] = this.addedBy;
    data['staff'] = this.staff;
    return data;
  }
}
