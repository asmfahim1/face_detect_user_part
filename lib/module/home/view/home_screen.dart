import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mict_final_project/core/utils/app_routes.dart';
import 'package:mict_final_project/core/utils/dimensions.dart';
import 'package:mict_final_project/core/utils/exports.dart';
import 'package:mict_final_project/core/widgets/exports.dart';
import 'package:mict_final_project/module/auth/login/controller/login_controller.dart';
import 'package:mict_final_project/module/home/controller/home_controller.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  final HomeController home = Get.find<HomeController>();

  final imageList = [
    openCameraIconPath,
    openCameraIconPath,
    openCameraIconPath,
    openCameraIconPath,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: whiteColor,
        centerTitle: true,
        elevation: 0,
        title: TextWidget(
          'dashboard'.tr,
          style: TextStyles.regular18.copyWith(
            color: darkGrayColor,
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              if (Get.find<LoginController>().userLoggedIn()) {
                Get.find<LoginController>().clearSharedData();
                Get.offAllNamed(AppRoutes.loginScreen);
              }
            },
            child: const Padding(
              padding: EdgeInsets.only(right: 10),
              child: Icon(
                Icons.logout_outlined,
                color: redColor,
                size: 25,
              ),
            ),
          )
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _profileWidget(),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _registrationSuccessPhotoWidget(),
                SizedBox(height: Dimensions.height10,),
                TextWidget(
                  'completed_registration'.tr,
                  textAlign: TextAlign.center,
                  style: TextStyles.title16.copyWith(),
                ),
              ],
            ),
          )

        ],
      ),
    );
  }

  Widget _profileWidget() {
    return Container(
      height: Dimensions.screenHeight / 6,
      width: Dimensions.screenWidth,
      padding: const EdgeInsets.all(14),
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        border: Border.all(),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          const CircleAvatar(
            backgroundColor: blueColor,
            radius: 40,
            child: Icon(
              Icons.person,
              size: 40,
              color: Colors.white,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextWidget(
                'Abu Sale Mohammad Fahim',
                style: TextStyles.title16.copyWith(fontSize: 14),
              ),
              TextWidget(
                'id: 2254991017',
                style: TextStyles.title16.copyWith(fontSize: 14),
              ),
              TextWidget(
                'exam : ___ exam',
                style: TextStyles.title16.copyWith(fontSize: 14),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _registrationSuccessPhotoWidget() {
    return Container(
      height: Dimensions.height100 * 1.5,
      width: Dimensions.width100 * 1.5,
      alignment: Alignment.center,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Image.asset(
        registrationSuccessfulImage,
        height: Dimensions.height100 * 2,
        width: Dimensions.width100 * 2,
        fit: BoxFit.cover,
      ),
    );
  }
}
