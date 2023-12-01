import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mict_final_project/constant/constant_key.dart';
import 'package:mict_final_project/core/utils/api_client.dart';
import 'package:mict_final_project/core/utils/app_routes.dart';
import 'package:mict_final_project/core/utils/dialogue_utils.dart';
import 'package:mict_final_project/core/utils/extensions.dart';
import 'package:mict_final_project/core/utils/pref_helper.dart';
import 'package:mict_final_project/module/auth/login/model/login_response_model.dart';

import '../../../../core/utils/app_constants.dart';

class LoginController extends GetxController {
  late final ApiClient apiClient;
  final TextEditingController userId = TextEditingController();
  final TextEditingController password = TextEditingController();
  LoginResponseModel? responseModel;
  final RxBool _passwordVisible = false.obs;
  final RxString _examType = 'Exam type'.obs;

  set passwordVisible(bool value) {
    _passwordVisible.value = value;
    update();
  }

  bool get passwordVisible => _passwordVisible.value;

  void setSelectedValue(String value) {
    examType = value;
  }

  set examType(String value) {
    _examType.value = value;
    update();
  }

  Future<void> loginMethod() async {
    try {
      DialogUtils.showLoading(title: "Please wait...");
      final map = <String, dynamic>{};
      map["email"] = userId.text.trim();
      map["password"] = password.text.trim();
      //map["examType"] = examType;

      Response response =
          await ApiClient().postData(AppConstants.loginUrl, map);
      if (response.statusCode == 200) {
        responseModel = LoginResponseModel.fromJson(response.body);
        if (responseModel!.data == null) {
          closeLoading();
          DialogUtils.showErrorDialog(
              title: 'Warning', description: '${responseModel!.message}');
        } else {
          _setToken(responseModel!);
          closeLoading();
          Get.offAllNamed(AppRoutes.registrationPage);
        }
      } else {
        closeLoading();
        DialogUtils.showErrorDialog();
      }
    } catch (e) {
      closeLoading();
      "There is an error occured while login request is processing: $e".log();
    }
  }

  void _setToken(LoginResponseModel responseModel) async {
    apiClient.token = responseModel.data?.token;
    apiClient.updateHeader(responseModel.data!.token.toString());
    await PrefHelper.setString(
      AppConstant.TOKEN.key,
      responseModel.data?.token ?? "",
    );
    await PrefHelper.setString(
      AppConstants.storedUserId,
      responseModel.data?.token ?? "",
    );
  }

  void closeLoading() {
    Get.back();
  }

  String get examType => _examType.value;
}
