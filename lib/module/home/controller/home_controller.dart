import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mict_final_project/core/utils/exports.dart';
import 'package:mict_final_project/core/widgets/exports.dart';
import 'package:mict_final_project/module/home/repo/home_repo.dart';

class HomeController extends GetxController {
  final HomeRepo? homeRepo;
  HomeController({this.homeRepo});

  RxMap userInfo = {}.obs;

  void getUserData() async {
    userInfo.value = (await homeRepo!.getUserInfo()) as RxMap;
  }

  //for exit the app
  Future<bool?> showWarningContext(BuildContext context) async => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: TextWidget(
            'Exit',
            style: TextStyles.title20,
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                TextWidget('Do you want to exit the app?'),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Get.back();
              },
              child: TextWidget(
                'Cancel',
                style: TextStyles.regular16.copyWith(color: redColor),
              ),
            ),
            TextButton(
              onPressed: () {
                if (Platform.isAndroid) {
                  SystemNavigator.pop();
                } else if (Platform.isIOS) {
                  exit(0);
                }
              },
              child: TextWidget(
                'Yes',
                style: TextStyles.regular16.copyWith(color: primaryColor),
              ),
            ),
          ],
        ),
      );
}
