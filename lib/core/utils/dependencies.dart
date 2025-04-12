import 'package:get/get.dart';
import 'package:mict_final_project/core/utils/api_client.dart';
import 'package:mict_final_project/core/utils/app_constants.dart';
import 'package:mict_final_project/module/auth/login/controller/login_controller.dart';
import 'package:mict_final_project/module/auth/login/repo/login_repo.dart';
import 'package:mict_final_project/module/auth/registration/controller/registration_controller.dart';
import 'package:mict_final_project/module/auth/registration/repo/regi_repo.dart';
import 'package:mict_final_project/module/home/controller/home_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../module/home/repo/home_repo.dart';

Future<void> init() async {
  final sharedPreferences = await SharedPreferences.getInstance();

  //shared preference
  Get.lazyPut(() => sharedPreferences, fenix: true);

  // api client
  Get.lazyPut(
      () => ApiClient(
          appBaseUrl: AppConstants.baseUrl, sharedPreferences: Get.find()),
      fenix: true);

  ///Repo
  //Auth
  Get.lazyPut(
      () => LoginRepo(apiClient: Get.find(), sharedPreferences: Get.find()),
      fenix: true);
  Get.lazyPut(
      () => RegiRepo(apiClient: Get.find(), sharedPreferences: Get.find()),
      fenix: true);
  Get.lazyPut(
      () => HomeRepo(apiClient: Get.find(), sharedPreferences: Get.find()),
      fenix: true);

  ///Controller
  //Auth
  Get.lazyPut(() => LoginController(loginRepo: Get.find<LoginRepo>()),
      fenix: true);
  Get.lazyPut(() => RegistrationController(regiRepo: Get.find<RegiRepo>()),
      fenix: true);
  Get.lazyPut(() => HomeController(homeRepo: Get.find<HomeRepo>()),
      fenix: true);
}
