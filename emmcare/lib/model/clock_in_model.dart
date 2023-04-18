class ClockInModel {
  String? clockIn;
  String? clockOut;

  ClockInModel({this.clockIn, this.clockOut});

  ClockInModel.fromJson(Map<String, dynamic> json) {
    clockIn = json['clock_in'];
    clockOut = json['clock_out'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['clock_in'] = this.clockIn;
    data['clock_out'] = this.clockOut;
    return data;
  }
}
