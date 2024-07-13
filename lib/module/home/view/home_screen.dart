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
          IconButton(
            onPressed: () {
              if (Get.find<LoginController>().userLoggedIn()) {
                Get.find<LoginController>().clearSharedData();
                Get.offAllNamed(AppRoutes.loginScreen);
              }
            },
            icon: Icon(
              Icons.logout_outlined,
              color: redColor,
              size: Dimensions.iconSize25,
            ),
          ),
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
                SizedBox(
                  height: Dimensions.height10,
                ),
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
      height: Dimensions.height100 * 1.35,
      width: Dimensions.screenWidth,
      padding: EdgeInsets.all(Dimensions.padding10),
      margin: EdgeInsets.all(Dimensions.padding10),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        border: Border.all(),
        borderRadius: BorderRadius.circular(Dimensions.radius12),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: blueColor,
            radius: Dimensions.radius20 * 2,
            child: Icon(
              Icons.person,
              size: Dimensions.iconSize20 * 2,
              color: Colors.white,
            ),
          ),
          SizedBox(
            width: Dimensions.width10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextWidget(
                'Abu Sale Mohammad Fahim',
                style: TextStyles.title16.copyWith(fontSize: Dimensions.font14),
              ),
              TextWidget(
                'id: 2254991017',
                style: TextStyles.title16.copyWith(fontSize: Dimensions.font14),
              ),
              TextWidget(
                'exam : ___ exam',
                style: TextStyles.title16.copyWith(fontSize: Dimensions.font14),
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
        borderRadius: BorderRadius.circular(Dimensions.radius12),
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
