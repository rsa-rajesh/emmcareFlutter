class ClientProfileDetailModel {
  List<ClientProfileDetail>? clientProfileDetail;

  ClientProfileDetailModel({this.clientProfileDetail});

  ClientProfileDetailModel.fromJson(Map<String, dynamic> json) {
    if (json['client_profile_detail'] != null) {
      clientProfileDetail = <ClientProfileDetail>[];
      json['client_profile_detail'].forEach((v) {
        clientProfileDetail!.add(new ClientProfileDetail.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.clientProfileDetail != null) {
      data['client_profile_detail'] =
          this.clientProfileDetail!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ClientProfileDetail {
  String? generalInformation;
  String? detail;
  int? id;

  ClientProfileDetail({this.generalInformation, this.detail, this.id});

  ClientProfileDetail.fromJson(Map<String, dynamic> json) {
    generalInformation = json['general_information'];
    detail = json['detail'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['general_information'] = this.generalInformation;
    data['detail'] = this.detail;
    data['id'] = this.id;
    return data;
  }
}
