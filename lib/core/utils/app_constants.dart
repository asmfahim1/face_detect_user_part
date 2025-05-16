class AppConstants {
  static String get baseUrl => 'http://192.168.0.102:8000/v1/';
  //static String get baseUrl => 'http://192.168.33.189:8000/v1/';
  //static String get baseUrl => 'http://localhost:8000/v1/';

  static String loginUrl = 'students/login';
  static String registerUrl = '';
  static String fileUpload = 'image/upload';
  static String postDescriptor = 'students/face/descriptor';
  static String postImagePath = 'students/face/image';
  static String getAllExams = 'exams/all';

  //Password
  static const String storedPassword = 'password';

  //Admin
  static const String storedUserId = 'user_id';
  static const String storedAdminNum = 'admin_num';

}
