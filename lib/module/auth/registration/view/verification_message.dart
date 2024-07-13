import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mict_final_project/core/utils/dimensions.dart';
import 'package:mict_final_project/core/utils/exports.dart';
import 'package:mict_final_project/core/widgets/exports.dart';
import 'package:mict_final_project/module/auth/registration/controller/registration_controller.dart';


class VerificationMessage extends StatelessWidget {
  VerificationMessage({Key? key}) : super(key: key);

  final RegistrationController regi = Get.find<RegistrationController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: Dimensions.screenWidth,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextWidget(
              'verification_text'.tr,
              style: TextStyles.regular16,
            ),

            SizedBox(
              height: Dimensions.height20 * 4,
            ),

            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    faceIconLeft, // Adjust the asset path as needed
                    height: Dimensions.height100,
                    width: Dimensions.width100 * .8,
                  ),
                  SizedBox(width: Dimensions.width10 * 2.4,),
                  Image.asset(
                    faceIconFront, // Adjust the asset path as needed
                    height: Dimensions.height100,
                    width: Dimensions.width100 * .8,
                  ),
                  SizedBox(width: Dimensions.width10 * 2.4,),
                  Image.asset(
                    faceIconRight, // Adjust the asset path as needed
                    height: Dimensions.height100,
                    width: Dimensions.width100 * .8,
                  ),
                ],
              ),
            ),

            SizedBox(
              height: Dimensions.height20 * 4,
            ),

            CommonButton(
              buttonColor: blueColor,
              width: Dimensions.screenWidth * .5,
              buttonTitle: 'next_btn'.tr,
              onTap: () {
                regi.changePage();
              },
            )
          ],
        ),
      ),
    );
  }
}