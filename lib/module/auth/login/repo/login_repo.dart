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

  saveUserToken(String token) async {
    apiClient.token = token;
    apiClient.updateHeader(token);

    //await PrefHelper.setString(AppConstantKey.TOKEN.key, token);
    await sharedPreferences.setString(AppConstantKey.TOKEN.key, token);
  }

  // saveUserToken(String token, User user) async {
  //   apiClient.token = token;
  //   apiClient.updateHeader(token);
  //
  //   //await PrefHelper.setString(AppConstantKey.TOKEN.key, token);
  //   await sharedPreferences.setString(AppConstantKey.TOKEN.key, token);
  //
  //   String userJson = json.encode(user.toJson());
  //   await sharedPreferences.setString(AppConstantKey.USER_INFO.key, userJson);
  // }

  // static Future<User?> getUser() async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String? userJson = prefs.getString(AppConstantKey.USER_INFO.key);
  //   if (userJson != null) {
  //     Map<String, dynamic> userMap = json.decode(userJson);
  //     return User.fromJson(userMap);
  //   }
  //   return null;
  // }


  bool userLoggedIn() {
    //PrefHelper.isLoggedIn();
    return sharedPreferences.containsKey(AppConstantKey.TOKEN.key);
  }

  Future<String> getUserToken() async {

    //PrefHelper.getString(AppConstantKey.TOKEN.key);

    return sharedPreferences.getString(AppConstantKey.TOKEN.key) ?? "None";
  }

  bool clearSharedData() {
   // PrefHelper.logout();
    sharedPreferences.remove(AppConstantKey.TOKEN.key);
    apiClient.token = '';
    apiClient.updateHeader('');
    return true;
  }
}
