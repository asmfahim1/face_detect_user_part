class AppConstants {
  ///base url
  //static String get baseUrl => 'http://localhost:8000/';
  static String get baseUrl => 'http://restapi.adequateshop.com/api/';

  static String loginUrl = '/authaccount/login';
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
