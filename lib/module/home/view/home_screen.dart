import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mict_final_project/core/utils/app_routes.dart';
import 'package:mict_final_project/core/utils/dimensions.dart';
import 'package:mict_final_project/core/utils/exports.dart';
import 'package:mict_final_project/core/widgets/exports.dart';
import 'package:mict_final_project/core/widgets/sized_box_height_10.dart';
import 'package:mict_final_project/module/auth/login/controller/login_controller.dart';
import 'package:mict_final_project/module/home/controller/home_controller.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final HomeController home = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppbar(
        autoImply: false,
        title: '',
        actions: [
          IconButton(
            onPressed: () {
              if (Get.find<LoginController>().userLogOutMethod()) {
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
      body: PopScope(
        canPop: false,
        onPopInvokedWithResult: (shouldPop, dynamic) async {
          await home.showWarningContext(context) ?? false;
        },
        child: Column(
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
      ),
    );
  }

  Widget _profileWidget() {
    return Container(
      width: Dimensions.screenWidth,
      padding: EdgeInsets.symmetric(vertical: Dimensions.padding15),
      decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(Dimensions.radius20 * 1.5),
          bottomRight: Radius.circular(Dimensions.radius20 * 1.5),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            backgroundColor: blueColor,
            radius: Dimensions.radius20 * 2,
            backgroundImage: const NetworkImage(
              'https://img.freepik.com/free-photo/young-bearded-man-with-striped-shirt_273609-5677.jpg?size=626&ext=jpg&ga=GA1.1.559178150.1721198416&semt=sph',
            ),
          ),
          const SizedBoxHeight10(),
          TextWidget(
            'Amaz Uddin Shaon',
            style: TextStyles.title16.copyWith(fontSize: Dimensions.font10* 1.8, color: whiteColor),
            overflow: TextOverflow.ellipsis,
          ),
          TextWidget(
            'ID: 2254991056',
            style: TextStyles.regular14.copyWith(color: whiteColor),
            overflow: TextOverflow.ellipsis,
          ),
          TextWidget(
            'amaz@gmail.com',
            style: TextStyles.regular14.copyWith(color: whiteColor),
            overflow: TextOverflow.ellipsis,
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
