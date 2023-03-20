// class MyDocumentModel {
//   int? totalCount;
//   int? totalPageCount;
//   int? countItemsOnPage;
//   int? currentPage;
//   String? nextPage;
//   String? previousPage;
//   List<Results>? mydocuments;

//   MyDocumentModel(
//       {this.totalCount,
//       this.totalPageCount,
//       this.countItemsOnPage,
//       this.currentPage,
//       this.nextPage,
//       this.previousPage,
//       this.mydocuments});

//   MyDocumentModel.fromJson(Map<String, dynamic> json) {
//     totalCount = json['TotalCount'];
//     totalPageCount = json['TotalPageCount'];
//     countItemsOnPage = json['countItemsOnPage'];
//     currentPage = json['CurrentPage'];
//     nextPage = json['NextPage'];
//     previousPage = json['PreviousPage'];
//     if (json['Results'] != null) {
//       mydocuments = <Results>[];
//       json['Results'].forEach((v) {
//         mydocuments!.add(new Results.fromJson(v));
//       });
//     }
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['TotalCount'] = this.totalCount;
//     data['TotalPageCount'] = this.totalPageCount;
//     data['countItemsOnPage'] = this.countItemsOnPage;
//     data['CurrentPage'] = this.currentPage;
//     data['NextPage'] = this.nextPage;
//     data['PreviousPage'] = this.previousPage;
//     if (this.mydocuments != null) {
//       data['Results'] = this.mydocuments!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }

// class Results {
//   int? id;
//   String? file;
//   String? uploadDate;
//   String? updateDate;
//   String? expiryDate;
//   String? contentType;
//   String? docCategory;
//   String? relatedUserType;
//   int? relatedUserId;
//   String? user;

//   Results(
//       {this.id,
//       this.file,
//       this.uploadDate,
//       this.updateDate,
//       this.expiryDate,
//       this.contentType,
//       this.docCategory,
//       this.relatedUserType,
//       this.relatedUserId,
//       this.user});

//   Results.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     file = json['file'];
//     uploadDate = json['upload_date'];
//     updateDate = json['update_date'];
//     expiryDate = json['expiry_date'];
//     contentType = json['content_type'];
//     docCategory = json['doc_category'];
//     relatedUserType = json['related_user_type'];
//     relatedUserId = json['related_user_id'];
//     user = json['user'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['file'] = this.file;
//     data['upload_date'] = this.uploadDate;
//     data['update_date'] = this.updateDate;
//     data['expiry_date'] = this.expiryDate;
//     data['content_type'] = this.contentType;
//     data['doc_category'] = this.docCategory;
//     data['related_user_type'] = this.relatedUserType;
//     data['related_user_id'] = this.relatedUserId;
//     data['user'] = this.user;
//     return data;
//   }
// }

class MyDocumentModel {
  List<Results>? mydocuments;

  MyDocumentModel({this.mydocuments});

  MyDocumentModel.fromJson(List<dynamic> parsedJson) {
    // List<Clients> mydocuments = <Clients>[];
    mydocuments = parsedJson.map((i) => Results.fromJson(i)).toList();
    // return new MyDocumentModel(
    //   mydocuments: mydocuments
    // );
  }
}

class Results {
  int? userId;
  int? id;
  String? title;
  String? body;

  Results({this.userId, this.id, this.title, this.body});

  Results.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    id = json['id'];
    title = json['title'];
    body = json['body'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['id'] = this.id;
    data['title'] = this.title;
    data['body'] = this.body;
    return data;
  }
}
