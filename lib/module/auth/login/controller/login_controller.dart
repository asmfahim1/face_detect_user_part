import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../repo/login_repo.dart';

class LoginController extends GetxController {

  late final LoginRepo loginRepo;

  LoginController({required this.loginRepo});


  final TextEditingController userId = TextEditingController();
  final TextEditingController password = TextEditingController();
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

  set examType(String value){
    _examType.value = value;
    update();

  }

  Future<void> loginMethod() async {
    //login method implement here
  }

/*  Future<void> saveUserPass () async{
    if(passwordSaved()){
      if(isRememberPassChecked){
        authRepo.saveUserPass(loginPassController.text);

      } else {
        authRepo.clearSavedPassword();
      }
    } else {
      if(isRememberPassChecked){
        authRepo.saveUserPass(loginPassController.text);
      }
    }
  }

  Future<ResponseModel> login() async {
    isLoading = true;
    update();
    try {

      EasyLoading.show(status: 'Wait a moment');

      AuthLoginModel authLoginBody = AuthLoginModel(
          mobileNumber: loginMobileController.text.trim(),
          password: loginPassController.text.trim());

      Response response = await authRepo.login(authLoginBody);
      late ResponseModel responseModel;


      if (response.statusCode == 201) {
        var responseJson = response.body;

        String userType = responseJson['data']['type'];
        String token = responseJson['data']['token'];


        await saveUserPass();

        if (userType == 'agency') {
          String agencyNum = responseJson['data']['mobile_number'];
          String agencyName = responseJson['data']['agency_name'];
          int agencyRL = responseJson['data']['rl_number'];

          await authRepo.saveUserInfoAgency(
            userType: userType,
            agencyNum: agencyNum,
            agencyName: agencyName,
            agencyRL: agencyRL,
          );
          await authRepo.saveUserToken(token);

        } else if (userType == 'admin') {
          String token = responseJson['data']['token'];
          String adminNum = responseJson['data']['mobile_number'];
          String adminName = responseJson['data']['name'];
          List<dynamic> adminDept = responseJson['data']['department'];

          await authRepo.saveUserInfoAdmin(
            userType: userType,
            adminNum: adminNum,
            adminDept: adminDept.map((item) => item.toString()).toList(),
            adminName: adminName,
          );
          await authRepo.saveUserToken(token);
        }

        update();
        responseModel = ResponseModel(true, userType);
      } else if (response.statusCode == 400 || response.statusCode == 404) {
        var responseJson = response.body;

        String errorMsg = responseJson['message'];

        responseModel = ResponseModel(false, errorMsg);
        showCustomToast(errorMsg);
      } else if (response.statusCode == 422) {
        var responseJson = response.body;

        String errorMsg = responseJson['errors'][0]['message'];

        responseModel = ResponseModel(false, errorMsg);
        showCustomToast(errorMsg);
      } else if (response.statusCode == 401 || response.statusCode == 403) {
        var responseJson = response.body;

        String errorMsg = responseJson['message'];

        responseModel = ResponseModel(false, errorMsg);
        showCustomToast(errorMsg);
      } else if (response.statusCode! > 403  && response.statusCode! < 500) {
        var responseJson = response.body;

        String errorMsg = responseJson['message'];

        responseModel = ResponseModel(false, errorMsg);
        showCustomToast(errorMsg);
      }  else {
        responseModel = ResponseModel(false, 'Unknown Error');
        showCustomToast('Unknown error occurred');
      }

      isLoading = false;
      update();

      EasyLoading.dismiss();

      return responseModel;
    } catch (e) {
      isLoading = false;
      update();
      EasyLoading.dismiss();
      showCustomToast('Error Occurred, Try Again');

      throw Exception(e.toString());
    }
  }

  Future<ResponseModel> resendPass() async {
    isLoading = true;
    update();
    try {


      Response response = await authRepo.resendPass({
        "mobile_number": resendMobileController.text,
      });

      late ResponseModel responseModel;

      if (response.statusCode == 200) {
        var responseJson = response.body;
        String msg = responseJson['message'];

        showCustomToast(msg);
        responseModel = ResponseModel(true, msg);
      } else if (response.statusCode == 400 || response.statusCode == 404) {
        var responseJson = response.body;

        String errorMsg = responseJson['message'];

        responseModel = ResponseModel(false, errorMsg);
        showCustomToast(errorMsg);
      } else if (response.statusCode == 422) {
        var responseJson = response.body;

        String errorMsg = responseJson['errors'][0]['message'];

        responseModel = ResponseModel(false, errorMsg);
        showCustomToast(errorMsg);
      } else {
        responseModel = ResponseModel(false, 'Unknown Error');
        showCustomToast('Unknown error occurred');
      }

      isLoading = false;
      update();

      return responseModel;
    } catch (e) {
      isLoading = false;
      update();

      showCustomToast('Error Occurred, Try Again');

      throw Exception(e.toString());
    }
  }

  Future<ResponseModel> agencyReg() async {
    try {
      EasyLoading.show(status: 'Wait a moment');

      AgencyRegistrationModel agencyRegBody = AgencyRegistrationModel(
        agencyName: regAgencyNameController.text.trim(),
        rlNumber: regRLNumController.text.trim(),
        email: regEmailAddressController.text.trim(),
        mobileNumber: regContactNum1Controller.text.trim(),
        mobileNumberRep: regContactNum2Controller.text.trim(),
      );

      Response response = await authRepo.agencyReg(agencyRegBody);

      late ResponseModel responseModel;

      if (response.statusCode == 200) {
        var responseJson = response.body;

        String successMessage = responseJson['message'];

        responseModel = ResponseModel(true, successMessage);
        showCustomToast(successMessage);
      } else if (response.statusCode == 406) {
        var responseJson = response.body;

        String errorMsg = responseJson['message'];

        responseModel = ResponseModel(false, errorMsg);
        showCustomToast(errorMsg);
      } else if (response.statusCode == 422) {
        var responseJson = response.body;

        String errorMsg = responseJson['errors'][0]['message'];

        responseModel = ResponseModel(false, errorMsg);
        showCustomToast(errorMsg);
      } else {
        responseModel = ResponseModel(false, 'Unknown Error');
        showCustomToast('Unknown error occurred');
      }

      update();

      EasyLoading.dismiss();

      return responseModel;
    } catch (e) {
      EasyLoading.dismiss();
      showCustomToast('Error Occurred, Try Again');

      throw Exception(e.toString());
    }
  }


  Future<ResponseModel> logout() async{
    EasyLoading.show(status: 'Logging out...');

    try {
      //
      // late String num;
      // late String pass;
      // String userType = authRepo.getUserType();
      //
      // if(userType == 'admin'){
      //    num = authRepo.getAdminMobile();
      //    pass = authRepo.getAdminPass();
      // } else {
      //   num = authRepo.getAgencyMobile();
      //   pass = authRepo.getAgencyPass();
      // }
      //
      //
      // AuthLoginLogoutModel authLogoutBody = AuthLoginLogoutModel(mobileNumber: num, password: pass);

      Response response =  await authRepo.logout();



      late ResponseModel responseModel;
      var responseJson = response.body;

      if(response.statusCode == 201){
        responseModel = ResponseModel(true, responseJson['message']);
      } else {
        showCustomToast(responseJson['Oops! Error while logout']);
        responseModel = ResponseModel(true, 'Unknown error occurred');
      }
      EasyLoading.dismiss();

      return responseModel;

    } catch(e){
      EasyLoading.dismiss();
      showCustomToast('Error Occurred, Try Again');
      throw Exception(e.toString());
    }
  }*/

  bool userLoggedIn() {
    return loginRepo.userLoggedIn();
  }

  bool passwordSaved() {
    return loginRepo.passwordSaved();
  }

 String get examType => _examType.value;

}
