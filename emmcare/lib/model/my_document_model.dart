class MyDocumentModel {
  List<Mydocuments>? mydocuments;

  MyDocumentModel({this.mydocuments});

  MyDocumentModel.fromJson(Map<String, dynamic> json) {
    if (json['mydocuments'] != null) {
      mydocuments = <Mydocuments>[];
      json['mydocuments'].forEach((v) {
        mydocuments!.add(new Mydocuments.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.mydocuments != null) {
      data['mydocuments'] = this.mydocuments!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Mydocuments {
  String? documentName;
  String? documentTitle;
  String? expiryDate;
  String? documentUrl;
  int? id;
  String? documenttItle;

  Mydocuments(
      {this.documentName,
      this.documentTitle,
      this.expiryDate,
      this.documentUrl,
      this.id,
      this.documenttItle});

  Mydocuments.fromJson(Map<String, dynamic> json) {
    documentName = json['document_name'];
    documentTitle = json['document_title'];
    expiryDate = json['expiry_date'];
    documentUrl = json['document_url'];
    id = json['id'];
    documenttItle = json['documentt_itle'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['document_name'] = this.documentName;
    data['document_title'] = this.documentTitle;
    data['expiry_date'] = this.expiryDate;
    data['document_url'] = this.documentUrl;
    data['id'] = this.id;
    data['documentt_itle'] = this.documenttItle;
    return data;
  }
}
