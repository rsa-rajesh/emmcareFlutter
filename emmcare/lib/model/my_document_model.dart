class MyDocumentModel {
  int? totalCount;
  int? totalPageCount;
  int? countItemsOnPage;
  int? currentPage;
  String? nextPage;
  String? previousPage;
  List<Results>? results;

  MyDocumentModel(
      {this.totalCount,
      this.totalPageCount,
      this.countItemsOnPage,
      this.currentPage,
      this.nextPage,
      this.previousPage,
      this.results});

  MyDocumentModel.fromJson(Map<String, dynamic> json) {
    totalCount = json['TotalCount'];
    totalPageCount = json['TotalPageCount'];
    countItemsOnPage = json['countItemsOnPage'];
    currentPage = json['CurrentPage'];
    nextPage = json['NextPage'];
    previousPage = json['PreviousPage'];
    if (json['Results'] != null) {
      results = <Results>[];
      json['Results'].forEach((v) {
        results!.add(new Results.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['TotalCount'] = this.totalCount;
    data['TotalPageCount'] = this.totalPageCount;
    data['countItemsOnPage'] = this.countItemsOnPage;
    data['CurrentPage'] = this.currentPage;
    data['NextPage'] = this.nextPage;
    data['PreviousPage'] = this.previousPage;
    if (this.results != null) {
      data['Results'] = this.results!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Results {
  int? id;
  String? file;
  String? uploadDate;
  String? updateDate;
  String? expiryDate;
  String? contentType;
  bool? staffVisibility;
  String? docCategory;
  String? relatedUserType;
  int? relatedUserId;
  String? user;

  Results(
      {this.id,
      this.file,
      this.uploadDate,
      this.updateDate,
      this.expiryDate,
      this.contentType,
      this.staffVisibility,
      this.docCategory,
      this.relatedUserType,
      this.relatedUserId,
      this.user});

  Results.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    file = json['file'];
    uploadDate = json['upload_date'];
    updateDate = json['update_date'];
    expiryDate = json['expiry_date'];
    contentType = json['content_type'];
    staffVisibility = json['staff_visibility'];
    docCategory = json['doc_category'];
    relatedUserType = json['related_user_type'];
    relatedUserId = json['related_user_id'];
    user = json['user'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['file'] = this.file;
    data['upload_date'] = this.uploadDate;
    data['update_date'] = this.updateDate;
    data['expiry_date'] = this.expiryDate;
    data['content_type'] = this.contentType;
    data['staff_visibility'] = this.staffVisibility;
    data['doc_category'] = this.docCategory;
    data['related_user_type'] = this.relatedUserType;
    data['related_user_id'] = this.relatedUserId;
    data['user'] = this.user;
    return data;
  }
}
