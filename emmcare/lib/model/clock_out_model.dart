class ClockOutModel {
  String? alertMsg;

  ClockOutModel({this.alertMsg});

  ClockOutModel.fromJson(Map<String, dynamic> json) {
    alertMsg = json['alert_msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['alert_msg'] = this.alertMsg;
    return data;
  }
}
