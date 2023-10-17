import 'package:get/get_connect/http/src/response/response.dart';
import 'package:mict_final_project/core/utils/exports.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginRepo{
  late final ApiClient apiClient;
  late final SharedPreferences sharedPreferences;

  LoginRepo({required this.apiClient, required this.sharedPreferences});

/*  Future<Response> login(AuthLoginModel authLoginBody) async {
    return await apiClient.postData(AppConstants.loginUrl, authLoginBody.toJson());
  }

  Future<Response> resendPass(Map<String, dynamic> body) async {
    return await apiClient.patchData(AppConstants.resentPassUrl, body);
  }

  Future<Response> logout() async {
    return await apiClient.patchData(
        AppConstants.logoutUrl, {});
  }

  Future<Response> agencyReg(AgencyRegistrationModel agencyRegBody) async {
    return await apiClient.postData(
        AppConstants.agencyRegUrl, agencyRegBody.toJson());
  }*/

  bool userLoggedIn() {
    return sharedPreferences.containsKey(AppConstants.storedToken);
  }

  bool passwordSaved() {
    return sharedPreferences.containsKey(AppConstants.storedPassword);
  }

  String getUserToken()  {
    return sharedPreferences.getString(AppConstants.storedToken) ?? "None";
  }

  saveUserToken(String token) async {
    apiClient.token = token;
    apiClient.updateHeader(token);

    return await sharedPreferences.setString(AppConstants.storedToken, token);
  }

  bool clearSavedPassword() {
    sharedPreferences.remove(AppConstants.storedPassword);
    return true;
  }
}