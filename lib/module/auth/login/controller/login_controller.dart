import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mict_final_project/core/utils/app_routes.dart';
import 'package:mict_final_project/core/utils/dialogue_utils.dart';
import 'package:mict_final_project/core/utils/extensions.dart';
import 'package:mict_final_project/module/auth/login/model/login_response_model.dart';
import 'package:mict_final_project/module/auth/login/repo/login_repo.dart';

class LoginController extends GetxController {
  LoginRepo? loginRepo;
  LoginController({this.loginRepo});

  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  final RxBool _passwordVisible = true.obs;
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
    LoginResponseModel responseModel;
    try {
      DialogUtils.showLoading(title: "Please wait...");

      final Map<String, dynamic> map = <String, dynamic>{};
      map['email'] = email.text.trim();
      map['password'] = password.text.trim();

      Response response = await loginRepo!.login(map);

      if (kDebugMode) {
        print('Response and maps : ${response.statusCode} =====${response.body}=========$map');
      }

      closeLoading();

      if (response.statusCode == 200) {

        responseModel = LoginResponseModel.fromJson(response.body);

        if (responseModel.data == null) {
          DialogUtils.showErrorDialog(
            title: 'Warning',
            description: responseModel.message ?? 'No data found',
          );
        } else {
          await loginRepo!.saveUserToken(responseModel.token.toString());
          Get.offAllNamed(AppRoutes.registrationPage);
        }
      } else {
        // Handle non-200 status code
        responseModel = LoginResponseModel.fromJson(response.body);
        DialogUtils.showErrorDialog(
          title: 'Warning',
          description: responseModel.message ?? 'Unknown error occurred',
        );
      }
    } catch (error) {
      closeLoading(); // Ensure closeLoading() is called in case of an error

      DialogUtils.showErrorDialog(description: "$error");

      "There is an error occurred while login request is processing: $error".log();
    }
  }

  void closeLoading() {
    Get.back();
  }

  //is user logged in
  bool userLoggedIn() {
    return loginRepo!.userLoggedIn();
  }

  bool clearSharedData() {
    return loginRepo!.clearSharedData();
  }

  String get examType => _examType.value;
}

