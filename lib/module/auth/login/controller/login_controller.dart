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
      print('test 1');
      DialogUtils.showLoading(title: "Please wait...");

      final Map<String, dynamic> map = <String, dynamic>{};
      map['email'] = email.text.trim();
      map['password'] = password.text.trim();

      print('test 2');
      print('=============$map');
      Response response = await loginRepo!.login(map);

      print(
          'Response and maps : ${response.statusCode} =====${response.body}=========$map');

      print('test 3');

      if (response.statusCode == 200) {
        print('test 4');

        responseModel = LoginResponseModel.fromJson(response.body);
        if (responseModel!.data == null) {
          closeLoading();
          DialogUtils.showErrorDialog(
              title: 'Warning', description: '${responseModel!.message}');
        } else {
          await loginRepo!.saveUserToken(responseModel!.data!.token.toString());
          closeLoading();
          Get.offAllNamed(AppRoutes.registrationPage);
        }
      } else {
        print('test 5');

        closeLoading();
        DialogUtils.showErrorDialog();
      }
    } catch (e) {
      print('test 6');

      closeLoading();
      "There is an error occurred while login request is processing: $e".log();
    }
  }

  void closeLoading() {
    Get.back();
  }

  //ise user logged in
  bool userLoggedIn() {
    return loginRepo!.userLoggedIn();
  }

  bool clearSharedData() {
    return loginRepo!.clearSharedData();
  }

  String get examType => _examType.value;
}

/*  Future<void> loginMethod() async {
    try {
      print('test 1');
      DialogUtils.showLoading(title: "Please wait...");

      final Map<String, dynamic> map = <String, dynamic>{};
      map['email'] = email.text.trim();
      map['password'] = password.text.trim();

      print('test 2');
      print('=============$map');
      Response response = await loginRepo.login(map);

      print(
          'Response and maps : ${response.statusCode} =====${response.body}=========$map');

      print('test 3');

      if (response.statusCode == 200) {
        print('test 4');

        responseModel = LoginResponseModel.fromJson(response.body);
        if (responseModel!.data == null) {
          closeLoading();
          DialogUtils.showErrorDialog(
              title: 'Warning', description: '${responseModel!.message}');
        } else {
          await loginRepo!.saveUserToken(responseModel!.data!.token.toString());
          closeLoading();
          Get.offAllNamed(AppRoutes.registrationPage);
        }
      } else {
        print('test 5');

        closeLoading();
        DialogUtils.showErrorDialog();
      }
    } catch (e) {
      print('test 6');

      closeLoading();
      "There is an error occurred while login request is processing: $e".log();
    }
  }*/
