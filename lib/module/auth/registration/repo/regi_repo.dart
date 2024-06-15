import 'package:get/get_connect/http/src/response/response.dart';
import 'dart:io';
import 'package:mict_final_project/core/utils/exports.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegiRepo {
  late final ApiClient apiClient;
  late final SharedPreferences sharedPreferences;

  RegiRepo({required this.apiClient, required this.sharedPreferences});

  ///file upload process
  Future<Map<String, dynamic>> uploadFileWithDio(File file, String fileName) async {

    //print('----------------${AppConstants.fileUpload}\n  ${file}\n ${fileName}============');

      return await apiClient.uploadFileWithDio(AppConstants.fileUpload, file, fileName);


  }



  ///post face vectors
  Future<Response> uploadFaceVectors(Map<String, dynamic> data) async {
    return await apiClient.postData(AppConstants.postDescriptor, data);
  }



  ///post face vectors
  Future<Response> uploadImagePathsToCompleteRegistration(Map<String, dynamic> data) async {
    return await apiClient.postData(AppConstants.postImagePath, data);
  }
}