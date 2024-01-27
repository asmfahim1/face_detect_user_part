import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mict_final_project/core/utils/app_routes.dart';
import 'package:mict_final_project/core/utils/exports.dart';
import 'package:mict_final_project/core/widgets/exports.dart';
import 'package:mict_final_project/module/auth/login/controller/login_controller.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 3)).then((value) {
      return Get.find<LoginController>().userLoggedIn()
          ? Get.offAllNamed(AppRoutes.homeScreen)
          : Get.offAllNamed(AppRoutes.loginScreen);
    });
    super.initState();
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
            Container(
              height: MediaQuery.of(context).size.height / 14,
              width: MediaQuery.of(context).size.width / 1.5,
              child: Image.asset(appIconImage),
            ),
            TextWidget(
              'USER DEMO APP',
              style: TextStyles.title32.copyWith(color: primaryColor),
            )
          ],
        ),
      ),
    );
  }
}
