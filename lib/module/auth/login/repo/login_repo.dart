import 'package:get/get_connect/http/src/response/response.dart';
import 'package:mict_final_project/core/utils/const_key.dart';
import 'package:mict_final_project/core/utils/exports.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginRepo {
  late final ApiClient apiClient;
  late final SharedPreferences sharedPreferences;

  LoginRepo({required this.apiClient, required this.sharedPreferences});

  Future<Response> login(Map<String, dynamic> loginBody) async {
    print('------------------$loginBody');
    return await apiClient.postData(AppConstants.loginUrl, loginBody);
  }

  saveUserToken(String token) async {
    apiClient.token = token;
    apiClient.updateHeader(token);
    await sharedPreferences.setString(AppConstantKey.TOKEN.key, token);
  }

  bool userLoggedIn() {
    return sharedPreferences.containsKey(AppConstantKey.TOKEN.key);
  }

  Future<String> getUserToken() async {
    return sharedPreferences.getString(AppConstantKey.TOKEN.key) ?? "None";
  }

  bool clearSharedData() {
    sharedPreferences.remove(AppConstantKey.TOKEN.key);
    apiClient.token = '';
    apiClient.updateHeader('');
    return true;
  }
}
