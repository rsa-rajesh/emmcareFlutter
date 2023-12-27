class UnavailableList {
  int? id;
  String? staff;
  String? staffId;
  String? unavailableDate;
  bool? allDay;
  String? startTime;
  String? endTime;
  String? unavailableReason;
  String? addedBy;

  UnavailableList(
      {this.id,
      this.staff,
      this.staffId,
      this.unavailableDate,
      this.allDay,
      this.startTime,
      this.endTime,
      this.unavailableReason,
      this.addedBy});

  UnavailableList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    staff = json['staff'];
    staffId = json['staff_id'];
    unavailableDate = json['unavailable_date'];
    allDay = json['all_day'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    unavailableReason = json['unavailable_reason'];
    addedBy = json['added_by'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['staff'] = this.staff;
    data['staff_id'] = this.staffId;
    data['unavailable_date'] = this.unavailableDate;
    data['all_day'] = this.allDay;
    data['start_time'] = this.startTime;
    data['end_time'] = this.endTime;
    data['unavailable_reason'] = this.unavailableReason;
    data['added_by'] = this.addedBy;
    return data;
  }
}
