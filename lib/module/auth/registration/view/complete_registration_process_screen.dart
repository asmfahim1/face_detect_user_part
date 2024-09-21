import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mict_final_project/core/utils/dialogue_utils.dart';
import 'package:mict_final_project/core/utils/dimensions.dart';
import 'package:mict_final_project/core/utils/exports.dart';
import 'package:mict_final_project/core/widgets/exports.dart';
import 'package:mict_final_project/module/auth/registration/controller/registration_controller.dart';
import 'package:mict_final_project/module/home/view/widgets/image_picker_widget.dart';

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
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TextWidget(
              'complete_process'.tr,
              style: TextStyles.regular14,
            ),
            const SizedBoxHeight20(),
            Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: ImagePickerWidget(
                        imageFile: File(regi.selectedFrontImagePath.value),
                        faceName: 'front',
                        onTap: null,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: ImagePickerWidget(
                        imageFile: File(regi.selectedRightImagePath.value),
                        faceName: 'right',
                        onTap: null,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Expanded(
                      child: ImagePickerWidget(
                        imageFile: File(regi.selectedLeftImagePath.value),
                        faceName: 'left',
                        onTap: null,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: ImagePickerWidget(
                        imageFile: File(regi.selectedSignatureImagePath.value),
                        faceName: 'signature',
                        onTap: null,
                      ),
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
      width: Dimensions.screenWidth,
      buttonTitle: 'complete_btn'.tr,
      onPressed: () async {
        if (regi.selectedFrontImagePath.isNotEmpty &&
            regi.selectedRightImagePath.isNotEmpty &&
            regi.selectedLeftImagePath.isNotEmpty &&
            regi.selectedSignatureImagePath.isNotEmpty) {
          regi.completeRegistrationProcess();
        } else {
          DialogUtils.showErrorDialog(
              title: 'warning'.tr,
              description: 'complete_process_warning'.tr,
              btnName: 'retry'.tr);
        }
      },
    );
  }
}
