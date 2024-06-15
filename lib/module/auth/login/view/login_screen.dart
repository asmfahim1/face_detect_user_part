import 'package:flutter/material.dart';
import 'package:mict_final_project/core/utils/dimensions.dart';
import 'package:mict_final_project/core/widgets/exports.dart';
import 'package:mict_final_project/module/auth/login/controller/login_controller.dart';
import 'package:mict_final_project/module/auth/login/view/widgets/login_form_section_widget.dart';
import '../../../../core/utils/exports.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final LoginController loginController = Get.find<LoginController>();

  @override
  Widget build(BuildContext context) {
    //loginController.getExamList();
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: Dimensions.screenHeight,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(loginBackImagePath),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: Dimensions.height100,
                ),
                TextWidget(
                  'Welcome to Face Detection App',
                  style: TextStyles.title20.copyWith(color: whiteColor),
                ),
                const SizedBoxHeight20(),
                LoginFormSectionWidget()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
