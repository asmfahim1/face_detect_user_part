import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mict_final_project/core/utils/app_routes.dart';
import 'package:mict_final_project/core/utils/dimensions.dart';
import 'package:mict_final_project/core/utils/exports.dart';

import '../../../../../core/widgets/common_button.dart';
import '../../../../../core/widgets/common_text_field_widget.dart';
import '../../../../../core/widgets/sized_box_height_20.dart';
import '../../../../../core/widgets/text_widget.dart';
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
        Container(
          height: Dimensions.screenHeight / 14,
          width: Dimensions.screenWidth,
          padding: const EdgeInsets.only(left: 10, right: 10),
          alignment: Alignment.centerLeft,
          margin: const EdgeInsets.only(top: 10),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey,
              width: 1.0,
            ),
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: DropdownButton(
            underline: const SizedBox(),
            // to remove the default underline of DropdownButton
            iconSize: 30.0,
            style: const TextStyle(
              fontSize: 18.0,
              color: Colors.black,
            ),
            items: <String>['Bank exam', 'BCS exam', 'Biman exam', 'PSC exam']
                .map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (newValue) {
              login.setSelectedValue(newValue!);
            },
            hint: TextWidget(
              login.examType,
              style: TextStyles.title16,
            ),
            isExpanded: true,
            // to make the dropdown button span the full width of the container
            icon: const Icon(
              Icons.arrow_drop_down,
              color: Colors.grey,
            ),
          ),
        ),
        const SizedBoxHeight20(),
        CommonTextField(
          hintText: 'User id',
          validator: Validator().nullFieldValidate,
          controller: login.email,
          onFieldSubmitted: (v) {
            FocusScope.of(context).requestFocus(_passwordFocus);
          },
        ),
        const SizedBoxHeight20(),
        CommonTextField(
          validator: Validator().nullFieldValidate,
          hintText: 'Password',
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
      buttonTitle: 'Login',
      onTap: () {
        //Get.toNamed(AppRoutes.registrationPage);
        if (_formKey.currentState!.validate()) {
          login.loginMethod();
        }
      },
    );
  }
}
