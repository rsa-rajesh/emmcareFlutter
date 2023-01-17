class DocumentHubModel {
  String? documentName;
  String? uploadDate;
  String? documentUrl;
  int? id;

  DocumentHubModel(
      {this.documentName, this.uploadDate, this.documentUrl, this.id});

  DocumentHubModel.fromJson(Map<dynamic, dynamic> json) {
    documentName = json['document_name'];
    uploadDate = json['upload_date'];
    documentUrl = json['document_url'];
    id = int.parse(json['id']);
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
