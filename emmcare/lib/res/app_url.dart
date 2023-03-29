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

  // EMMC Care API'S

  // Base Url.

  static var baseUrl = "https://pwnbot-agecare-backend.clouds.nepalicloud.com/";

  // End Points.

  static String postLogin() {
    return baseUrl + "v1/api/auth/login/";
  }

  static String getShiftList() {
    return baseUrl + "v2/api/shift/shift-list";
  }

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

  static String postMarkNotificationAllSeen() {
    return baseUrl + "v1/api/auth/notification-mark-all-seen/";
  }

  static String getProgressNoteList(obj_id) {
    return baseUrl +
        "v2/api/events/progress-note-list/?obj_id=${obj_id.toString()}";
  }

  static String getShiftTaskList(shift) {
    return baseUrl + "v1/api/shift/shift-task-list/?shift=${shift.toString()}";
  }

  static String postMarkNotificationSeen() {
    return baseUrl + "v1/api/auth/notification-mark-seen/";
  }

  static String postUnavailabilityCreate() {
    return baseUrl + "v1/api/auth/staff-unavailability-create/";
  }

  static String getEventsList(page) {
    var pageSize = 30;
    return baseUrl +
        "v1/api/events/event-list/?page=${page.toString()}&page_size=$pageSize";
  }
}
