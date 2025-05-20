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
  LoginFormSectionWidget({super.key});

  final _formKey = GlobalKey<FormState>();

  final FocusNode _passwordFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(builder: (controller) {
      return Form(
        key: _formKey,
        child: Container(
          width: Dimensions.screenWidth,
          padding: EdgeInsets.symmetric(horizontal: Dimensions.padding15, vertical: Dimensions.padding20 * 1.5),
          decoration: BoxDecoration(
            color: whiteColor.withOpacity(0.7),
            borderRadius: BorderRadius.circular(Dimensions.radius20),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const ExamDropdown(),
              const SizedBoxHeight20(),
              CommonTextField(
                hintText: 'email_hint'.tr,
                validator: Validator().nullFieldValidate,
                controller: controller.email,
                onFieldSubmitted: (v) {
                  FocusScope.of(context).requestFocus(_passwordFocus);
                },
              ),
              const SizedBoxHeight20(),
              CommonTextField(
                validator: Validator().nullFieldValidate,
                hintText: 'password_hint'.tr,
                focusNode: _passwordFocus,
                controller: controller.password,
                obSecure: controller.passwordVisible,
                onFieldSubmitted: (v) {
                  if (_formKey.currentState!.validate()) {
                    controller.loginMethod();
                  }
                },
                suffixIcon: IconButton(
                  color: blackColor,
                  icon: controller.passwordVisible
                      ? const Icon(Icons.visibility_off)
                      : const Icon(Icons.visibility),
                  onPressed: () {
                    controller.passwordVisible = !controller.passwordVisible;
                  },
                ),
              ),
              SizedBox(
                height: Dimensions.height15,
              ),
              CommonButton(
                width: Dimensions.screenWidth,
                buttonColor: blueColor,
                buttonTitle: 'login'.tr,
                fontWeight: FontWeight.bold,
                onPressed: () {
                  //Get.toNamed(AppRoutes.registrationPage);
                  if (_formKey.currentState!.validate()) {
                    controller.loginMethod();
                  }
                },
              ),
            ],
          ),
        ),
      );
    });
  }
}
