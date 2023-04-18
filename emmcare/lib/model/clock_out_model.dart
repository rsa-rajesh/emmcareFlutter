class ClockOutModel {
  String? clockIn;
  String? clockOut;

  ClockOutModel({this.clockIn, this.clockOut});

  ClockOutModel.fromJson(Map<String, dynamic> json) {
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
