class DocumentModel {
  String? documentName;
  String? documentTitle;
  String? expiryDate;
  String? documentUrl;
  String? id;

  DocumentModel(
      {this.documentName,
      this.documentTitle,
      this.expiryDate,
      this.documentUrl,
      this.id});

  DocumentModel.fromJson(Map<dynamic, dynamic> json) {
    documentName = json['document_name'];
    documentTitle = json['document_title'];
    expiryDate = json['expiry_date'];
    documentUrl = json['document_url'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['document_name'] = this.documentName;
    data['document_title'] = this.documentTitle;
    data['expiry_date'] = this.expiryDate;
    data['document_url'] = this.documentUrl;
    data['id'] = this.id;
    return data;
  }
}
