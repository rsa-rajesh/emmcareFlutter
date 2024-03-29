class AppUrl {
  // Base Url.
  static var baseUrl = "https://api.emmcare.pwnbot.io/";
  // static var baseUrl = "http://192.168.100.122:8000/";

  // End Points.
  static String postLogin() {
    return baseUrl + "v1/api/auth/app-login/";
  }

  static String getShiftList() {
    return baseUrl + "v2/api/shift/shift-list";
  }

  static String getPersonalDocuments(page, realtedUserType, realtedUserId) {
    var pageSize = 999999999999999999;
    return baseUrl +
        "v1/api/document/document-list/?page=$page&page_size=$pageSize&related_user_id=${realtedUserId.toString()}&related_user_type=${realtedUserType.toString()}";
  }

  static String getClientDocuments(page, realtedUserType, realtedUserId) {
    var pageSize = 999999999999999999;
    return baseUrl +
        "v1/api/document/app-client-document-list/?page=$page&page_size=$pageSize&related_user_id=${realtedUserId.toString()}&related_user_type=${realtedUserType.toString()}";
  }

  static String getNotification(page, is_seen) {
    var pageSize = 999999999999999999;
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

  static String unavailabilityList(id) {
    return baseUrl + "v1/api/auth/staff-unavailability-list/?staff_id=$id";
  }

  static String getEventsList(page, obj_id) {
    var pageSize = 999999999999999999;
    return baseUrl +
        "v2/api/events/shift-event-list/?page=${page.toString()}&page_size=$pageSize&obj_id=${obj_id.toString()}";
  }

  static String getClientProfileGoalList(page) {
    var pageSize = 999999999999999999;
    return baseUrl +
        "v1/api/auth/client-goal-list/?page=${page.toString()}&page_size=$pageSize";
  }

  static String getDocumentHubList(page, realtedUserType, realtedUserId) {
    var pageSize = 999999999999999999;
    return baseUrl +
        "v1/api/document/document-hub-list/?page=${page.toString()}&page_size=$pageSize&related_user_id=${realtedUserId.toString()}&related_user_type=${realtedUserType.toString()}";
  }

  static String postProgressNotes() {
    return baseUrl + "v2/api/events/progress-note-create/";
  }

  static String postFeedback() {
    return baseUrl + "v2/api/events/progress-note-create/";
  }

  static String postWarning() {
    return baseUrl + "v2/api/events/progress-note-create/";
  }

  static String postIncident() {
    return baseUrl + "v2/api/events/progress-note-create/";
  }

  static String postEnquiry() {
    return baseUrl + "v2/api/events/progress-note-create/";
  }

  static String postSubEvent() {
    return baseUrl + "v2/api/events/progress-note-create/";
  }

  static String postInjury() {
    return baseUrl + "v2/api/events/progress-note-create/";
  }

  static String putClockIn(shiftId) {
    return baseUrl + "v1/api/shift/shift-clockin/$shiftId/";
  }

  static String putClockOut(shiftId) {
    return baseUrl + "v1/api/shift/shift-clockout/$shiftId/";
  }

  static String patchClientGoalStrategyUpdate(int internalId) {
    return baseUrl +
        "v1/api/auth/client-goal-strategy-update/${internalId.toString()}/";
  }

  static String postPasswordResetOtp() {
    return baseUrl + "v1/api/auth/password-reset-otp/";
  }

  static String postPasswordResetOtpVerify() {
    return baseUrl + "v1/api/auth/password-reset-otp-verify/";
  }

  static String postPasswordResetOtpComplete() {
    return baseUrl + "v1/api/auth/password-reset-otp-complete/";
  }
}
