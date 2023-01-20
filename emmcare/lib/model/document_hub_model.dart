class DocumentHubModel {
  List<DocumentHub>? documentHub;

  DocumentHubModel({this.documentHub});

  DocumentHubModel.fromJson(Map<String, dynamic> json) {
    if (json['documentHub'] != null) {
      documentHub = <DocumentHub>[];
      json['documentHub'].forEach((v) {
        documentHub!.add(new DocumentHub.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.documentHub != null) {
      data['documentHub'] = this.documentHub!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DocumentHub {
  String? documentName;
  String? uploadDate;
  String? documentUrl;
  int? id;

  DocumentHub({this.documentName, this.uploadDate, this.documentUrl, this.id});

  DocumentHub.fromJson(Map<String, dynamic> json) {
    documentName = json['document_name'];
    uploadDate = json['upload_date'];
    documentUrl = json['document_url'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['document_name'] = this.documentName;
    data['upload_date'] = this.uploadDate;
    data['document_url'] = this.documentUrl;
    data['id'] = this.id;
    return data;
  }
}
