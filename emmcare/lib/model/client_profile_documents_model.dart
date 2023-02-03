class ClientProfileDocumentsModel {
  List<ClientProfileDocuments>? clientProfileDocuments;

  ClientProfileDocumentsModel({this.clientProfileDocuments});

  ClientProfileDocumentsModel.fromJson(Map<String, dynamic> json) {
    if (json['client_profile_documents'] != null) {
      clientProfileDocuments = <ClientProfileDocuments>[];
      json['client_profile_documents'].forEach((v) {
        clientProfileDocuments!.add(new ClientProfileDocuments.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.clientProfileDocuments != null) {
      data['client_profile_documents'] =
          this.clientProfileDocuments!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ClientProfileDocuments {
  String? documentName;
  String? documentUrl;
  int? id;

  ClientProfileDocuments({this.documentName, this.documentUrl, this.id});

  ClientProfileDocuments.fromJson(Map<String, dynamic> json) {
    documentName = json['document_name'];
    documentUrl = json['document_url'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['document_name'] = this.documentName;
    data['document_url'] = this.documentUrl;
    data['id'] = this.id;
    return data;
  }
}
