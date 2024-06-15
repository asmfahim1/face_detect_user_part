import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mict_final_project/core/utils/colors.dart';
import 'package:mict_final_project/core/utils/dimensions.dart';
import 'package:mict_final_project/core/utils/styles.dart';
import 'package:mict_final_project/core/widgets/common_button.dart';
import 'package:mict_final_project/core/widgets/text_widget.dart';
import 'package:mict_final_project/module/auth/registration/controller/registration_controller.dart';
import 'package:mict_final_project/module/auth/registration/view/widgets/common_image_show_widget.dart';


class CompleteRegistrationScreen extends StatelessWidget {
  CompleteRegistrationScreen({super.key});

  final RegistrationController regi = Get.find<RegistrationController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: SizedBox(
        width: Dimensions.screenWidth,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextWidget(
              'Your registration is about to complete. Please press complete and all the best',
              style: TextStyles.title16,
            ),

            Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: CommonImageShowWidget(imagePath: regi.selectedFrontImagePath.value),
                    ),
                    const SizedBox(width: 10,),
                    Expanded(
                      child: CommonImageShowWidget(imagePath: regi.selectedRightImagePath.value),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Expanded(
                      child: CommonImageShowWidget(imagePath: regi.selectedLeftImagePath.value),
                    ),
                    const SizedBox(width: 10,),
                    Expanded(
                      child: CommonImageShowWidget(imagePath: regi.selectedSignatureImagePath.value),
                    ),
                  ],
                ),
              ],
            ),

            SizedBox(
              height: Dimensions.height20,
            ),
            _completeProcess(regi),
          ],
        ),
      ),
    );
  }

  Widget _completeProcess(RegistrationController regi) {
    return CommonButton(
      buttonColor: blueColor,
      width: Dimensions.screenWidth / 2,
      buttonTitle: 'Complete Process',
      onTap: () async {
        regi.completeRegistrationProcess();
      },
    );
  }

}
