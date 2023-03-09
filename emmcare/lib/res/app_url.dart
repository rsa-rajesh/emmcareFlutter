class AppUrl {
  // Postman API'S.
  //
  //
  // Base Urls.
  static var pstmnbaseUrl =
      'https://1638f389-0fb5-41f5-a15c-55169442a3c2.mock.pstmn.io/';

  // End Points.
  static var myDocumentListEndPoint = pstmnbaseUrl + "my_documents";
  static var documentHubListEndPoint = pstmnbaseUrl + "document_hub";
  static var JobListEndPoint = pstmnbaseUrl + "jobs";
  static var clientProfileDocumentsListEndPoint =
      pstmnbaseUrl + "client_profile_documents";
  static var clientProfileDetailEndPoint =
      pstmnbaseUrl + "client_profile_detail";
  static var clientProfileGoalEndPoint = pstmnbaseUrl + "client_profile_goal";
  static var eventsEndPoint = pstmnbaseUrl + "events";
  static var instructionEndPoint = pstmnbaseUrl + "instruction";
  static var tasksEndPoint = pstmnbaseUrl + "tasks";

  // Real API'S
  //
  //
  // Base Urls.
  static var baseUrl = "https://pwnbot-agecare-backend.clouds.nepalicloud.com/";

  // End Points.
  static var loginEndPoint = baseUrl + "v1/api/auth/login/";
  static var clientListEndPoint = baseUrl + "v2/api/shift/shift-list";
  static var progressEndPoint = baseUrl + "v2/api/events/progress-note-list";
}
