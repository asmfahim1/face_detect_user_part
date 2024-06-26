import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mict_final_project/core/utils/dimensions.dart';
import 'package:mict_final_project/core/utils/exports.dart';
import 'package:mict_final_project/module/auth/login/view/widgets/exam_list_dropdown_widget.dart';

import '../../../../../core/widgets/common_button.dart';
import '../../../../../core/widgets/common_text_field_widget.dart';
import '../../../../../core/widgets/sized_box_height_20.dart';
import '../../controller/login_controller.dart';

class LoginFormSectionWidget extends StatelessWidget {
  LoginFormSectionWidget({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  final FocusNode _passwordFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(builder: (controller) {
      return Form(
        key: _formKey,
        child: Container(
          height: Dimensions.screenHeight / 2,
          width: Dimensions.screenWidth,
          padding: const EdgeInsets.symmetric(horizontal: 15),
          decoration: BoxDecoration(
            color: whiteColor.withOpacity(0.7),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _textFields(context, controller),
              SizedBox(
                height: Dimensions.height15,
              ),
              _loginButton(controller),
            ],
          ),
        ),
      );
    });
  }

  Widget _textFields(BuildContext context, LoginController login) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ExamDropdown(),
        const SizedBoxHeight20(),
        CommonTextField(
          hintText: 'email_hint'.tr,
          validator: Validator().nullFieldValidate,
          controller: login.email,
          onFieldSubmitted: (v) {
            FocusScope.of(context).requestFocus(_passwordFocus);
          },
        ),
        const SizedBoxHeight20(),
        CommonTextField(
          validator: Validator().nullFieldValidate,
          hintText: 'password_hint'.tr,
          focusNode: _passwordFocus,
          controller: login.password,
          obSecure: login.passwordVisible,
          onFieldSubmitted: (v) {
            if (_formKey.currentState!.validate()) {
              login.loginMethod();
            }
          },
          suffixIcon: IconButton(
            color: blackColor,
            icon: login.passwordVisible
                ? const Icon(Icons.visibility_off)
                : const Icon(Icons.visibility),
            onPressed: () {
              login.passwordVisible = !login.passwordVisible;
            },
          ),
        ),
      ],
    );
  }

  Widget _loginButton(LoginController login) {
    return CommonButton(
      width: Dimensions.screenWidth / 1.6,
      buttonColor: blueColor,
      buttonTitle: 'login'.tr,
      onTap: () {
        //Get.toNamed(AppRoutes.registrationPage);
        if (_formKey.currentState!.validate()) {
          login.loginMethod();
        }
      },
    );
  }
}
