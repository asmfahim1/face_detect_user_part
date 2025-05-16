import 'package:get/get_connect/http/src/response/response.dart';
import 'package:mict_final_project/core/utils/const_key.dart';
import 'package:mict_final_project/core/utils/exports.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginRepo {
  late final ApiClient apiClient;
  late final SharedPreferences sharedPreferences;

  LoginRepo({required this.apiClient, required this.sharedPreferences});

  Future<Response> getAllExams() async {
    return await apiClient.getData(AppConstants.getAllExams);
  }

  Future<Response> login(Map<String, dynamic> loginBody) async {
    return await apiClient.postData(AppConstants.loginUrl, loginBody);
  }

  saveUserToken(String token, bool registrationDone) async {
    apiClient.token = token;
    apiClient.updateHeader(token);

    await sharedPreferences.setString(AppConstantKey.TOKEN.key, token);
    await sharedPreferences.setBool(
        AppConstantKey.REGISTRATION.key, registrationDone);
  }

  bool userLoggedIn() {
    // Check if the key exists and the value is true
    return sharedPreferences.getBool(AppConstantKey.REGISTRATION.key) ?? false;
  }

  bool userLoggedOut() {
    // Check if the key exists and the value is true
    return sharedPreferences.containsKey(AppConstantKey.REGISTRATION.key);
  }

  Future<String> getUserToken() async {
    //PrefHelper.getString(AppConstantKey.TOKEN.key);

    return sharedPreferences.getString(AppConstantKey.TOKEN.key) ?? "None";
  }

  bool clearSharedData() {
    // PrefHelper.logout();
    sharedPreferences.remove(AppConstantKey.TOKEN.key);
    sharedPreferences.remove(AppConstantKey.REGISTRATION.key);
    apiClient.token = '';
    apiClient.updateHeader('');
    return true;
  }
}
