class AppConstants {
  ///base url
  static String get baseUrl => 'http://localhost:8000/';

  static String loginUrl = '';
  static String registerUrl = '';
  static String fileUpload = 'file-upload';

  ///Shared Preferences
  static const String storedToken = 'token';
  static const String storedExamType = 'exam_type';

  //Password
  static const String storedPassword = 'password';

  //Admin
  static const String storedUserId = 'user_id';
  static const String storedAdminNum = 'admin_num';
}
