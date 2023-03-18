class AppUrl {
  // Postman API'S.
  //
  //
  // Base Urls.
  static var pstmnbaseUrl =
      'https://bd00a589-d8e2-4ed3-88ad-f0656f2eb2d2.mock.pstmn.io/';
  // End Points.
  static var myDocumentListEndPoint = pstmnbaseUrl + "my_documents";
  static var documentHubListEndPoint = pstmnbaseUrl + "document_hub";
  static var JobListEndPoint = pstmnbaseUrl + "jobs";
  static var clientProfileDetailEndPoint =
      pstmnbaseUrl + "client_profile_detail";
  static var clientProfileGoalEndPoint = pstmnbaseUrl + "client_profile_goal";
  static var instructionEndPoint = pstmnbaseUrl + "instruction";
  static var tasksEndPoint = pstmnbaseUrl + "tasks";

  // Real API'S
  //
  // Base Urls.
  static var baseUrl = "https://pwnbot-agecare-backend.clouds.nepalicloud.com/";
  // End Points.
  static var loginEndPoint = baseUrl + "v1/api/auth/login/";
  static var clientListEndPoint = baseUrl + "v2/api/shift/shift-list";
  static var progressEndPoint = baseUrl + "v2/api/events/progress-note-list";
//   static var clientProfileDocumentsListEndPoint =
//       baseUrl + "v1/api/document/document-list/?page=";
  static var eventsEndPoint = baseUrl + "v1/api/shift/shift-detail/";

  static String getPersionalDocuments(pageno) {
    const FETCH_LIMIT = 10;
    // return baseUrl + "v1/api/document/document-list/?page=" + pageno.toString();
    return "https://jsonplaceholder.typicode.com/posts?_limit=$FETCH_LIMIT&_page=${pageno.toString()}";
  }
}
