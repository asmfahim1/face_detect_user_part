import 'package:get/get.dart';
import 'package:mict_final_project/module/auth/login/controller/login_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> init() async {
  final sharedPreferences = await SharedPreferences.getInstance();

  ///shared prefs
  Get.lazyPut(() => sharedPreferences, fenix: true);

  // ///api client
  // Get.lazyPut(() => ApiClient(appBaseUrl: AppConstants.baseUrl), fenix: true);

  ///Repo
  //Auth
  // Get.lazyPut(() => LoginRepo(apiClient: Get.find(), sharedPreferences: Get.find()), fenix: true);

  ///Controller
  //Auth
  Get.lazyPut(() => LoginController(), fenix: true);
}
