import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mict_final_project/core/utils/app_routes.dart';
import 'package:mict_final_project/core/utils/dimensions.dart';
import 'package:mict_final_project/core/utils/exports.dart';
import 'package:mict_final_project/core/widgets/exports.dart';
import 'package:mict_final_project/module/auth/login/controller/login_controller.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 2)).then((_) {
      final bool isUserLoggedIn = Get.find<LoginController>().userLoggedIn();

      if (kDebugMode) {
        print("========$isUserLoggedIn");
      }

      if (isUserLoggedIn) {
        Get.offAllNamed(AppRoutes.homeScreen);
      } else {
        Get.offAllNamed(AppRoutes.loginScreen); // Changed to registrationScreen
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: Dimensions.height10 * 5.7,
              width: Dimensions.width100 * 2.4,
              child: Image.asset(appIconImage),
            ),
            TextWidget(
              'splash_text'.tr,
              style: TextStyles.title22.copyWith(color: primaryColor),
            )
          ],
        ),
      ),
    );
  }
}
