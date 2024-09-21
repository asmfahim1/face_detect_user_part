import 'dart:convert';

import 'package:mict_final_project/core/utils/api_client.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  HomeRepo({required this.apiClient, required this.sharedPreferences});

  Future<Map<String, dynamic>?> getUserInfo() async {
    String? loginBodyString = sharedPreferences.getString('loginBody');
    if (loginBodyString != null) {
      Map<String, dynamic> loginBody = jsonDecode(loginBodyString);
      return loginBody;
    }
    return null;
  }
}
