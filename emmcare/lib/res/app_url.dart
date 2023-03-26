class AppUrl {
  // Postman API'S.
  //
  //
  // Base Url.
  static var pstmnbaseUrl =
      'https://bd00a589-d8e2-4ed3-88ad-f0656f2eb2d2.mock.pstmn.io/';
  // End Points.
  static var clientProfileGoalEndPoint = pstmnbaseUrl + "client_profile_goal";
  static var instructionEndPoint = pstmnbaseUrl + "instruction";
  static var tasksEndPoint = pstmnbaseUrl + "tasks";
  static var eventsEndPoint = pstmnbaseUrl + "events";

  // Real API'S
  //
  // Base Url.
  static var baseUrl = "https://pwnbot-agecare-backend.clouds.nepalicloud.com/";
  // End Points.
  static var loginEndPoint = baseUrl + "v1/api/auth/login/";
  static var clientListEndPoint = baseUrl + "v2/api/shift/shift-list";
  static var progressEndPoint = baseUrl + "v2/api/events/progress-note-list";

  static String getPersonalDocuments(page, realtedUserType, realtedUserId) {
    var pageSize = 30;
    return baseUrl +
        "v1/api/document/document-list/?page=${page.toString()}&page_size=$pageSize&related_user_id=${realtedUserId.toString()}&related_user_type=${realtedUserType.toString()}";
  }

  static String getNotification(page, is_seen) {
    var pageSize = 30;
    return baseUrl +
        "v1/api/auth/notification/?page=${page.toString()}&page_size=$pageSize&is_seen=${is_seen.toString()}";
  }

  static String markNotificationAllSeen() {
    return baseUrl + "v1/api/auth/notification-mark-all-seen/";
  }
}
