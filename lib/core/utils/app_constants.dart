class AppConstants {

  static String get baseUrl => 'http://192.168.0.104:8000/v1/';
  //static String get baseUrl => 'http://localhost:8000/v1/';
  //static String get baseUrl => 'http://restapi.adequateshop.com/api/';

  static String loginUrl = 'students/login';
  static String registerUrl = '';
  static String fileUpload = 'image/upload';
  static String postDescriptor = 'students/face/descriptor';
  static String postImagePath = 'students/face/image';

  //Password
  static const String storedPassword = 'password';

  //Admin
  static const String storedUserId = 'user_id';
  static const String storedAdminNum = 'admin_num';
}
