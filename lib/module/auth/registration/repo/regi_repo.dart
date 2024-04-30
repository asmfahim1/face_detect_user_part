import 'package:get/get_connect/http/src/response/response.dart';
import 'dart:io';
import 'package:mict_final_project/core/utils/exports.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegiRepo {
  late final ApiClient apiClient;
  late final SharedPreferences sharedPreferences;

  RegiRepo({required this.apiClient, required this.sharedPreferences});

  ///file upload process
  Future<Map<String, dynamic>> uploadFileWithDio(
      File file, String fileName) async {
    return await apiClient.uploadFileWithDio(
        AppConstants.fileUpload, file, fileName);
  }


  ///download pdf file
  /*Future<Map<String, dynamic>> downloadFileWithDio(
      String uri, Function(double) onProgress) async {
    return await apiClient.downloadPDF(uri, onProgress);
  }*/
}