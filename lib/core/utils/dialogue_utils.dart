import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mict_final_project/core/utils/dimensions.dart';
import 'package:mict_final_project/core/utils/exports.dart';
import 'package:mict_final_project/core/widgets/exports.dart';

class DialogUtils {
  static void showLoading({String title = "Loading..."}) {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: allPadding15,
          child: SizedBox(
            height: Dimensions.height40,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: Dimensions.width20,
                ),
                const Center(
                  child: CircularProgressIndicator.adaptive(),
                ),
                SizedBox(
                  width: Dimensions.width20,
                ),
                Text(
                  title,
                ),
              ],
            ),
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }

  static void closeLoading(){
    Get.back();
  }

  static void showErrorDialog({
    String title = "Oops Error",
    String description = "Something went wrong ",
    String btnName = "Close",
  }) {
    Get.dialog(
      Dialog(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0))),
        child: Padding(
          padding: allPadding15,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextWidget(
                title,
                style: TextStyles.title16,
              ),
              SizedBox(height: Dimensions.height10),
              TextWidget(
                description,
                style: TextStyles.regular14,
              ),
              ElevatedButton(
                onPressed: () {
                  if (Get.isDialogOpen!) Get.back();
                },
                child: Text(btnName),
              ),
            ],
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }

  static void showSnackBar(String messageTitle, String messageBody,
      {int seconds = 1, Color bgColor = greenColor}) {
    Get.snackbar(
      messageTitle,
      messageBody,
      icon: const Icon(Icons.person, color: Colors.white),
      borderWidth: 1.5,
      borderColor: Colors.black54,
      colorText: Colors.white,
      backgroundColor: bgColor,
      duration: Duration(seconds: seconds),
      snackPosition: SnackPosition.TOP,
    );
  }

}
