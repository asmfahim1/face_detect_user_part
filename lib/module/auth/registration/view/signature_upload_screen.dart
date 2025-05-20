import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mict_final_project/core/utils/dimensions.dart';
import 'package:mict_final_project/core/utils/exports.dart';
import 'package:mict_final_project/core/widgets/exports.dart';
import 'package:mict_final_project/module/auth/registration/controller/registration_controller.dart';
import 'package:mict_final_project/module/home/view/widgets/image_picker_widget.dart';

class UploadSignatureScreen extends StatelessWidget {
  UploadSignatureScreen({super.key});

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
              'sign_upload'.tr,
              style: TextStyles.title20,
            ),
            _uploadedPhotoWidget(regi, context),
          ],
        ),
      ),
    );
  }

  Widget _uploadedPhotoWidget(
      RegistrationController regiController, BuildContext context) {
    return Column(
      children: [
        Obx(
          () => Padding(
            padding: const EdgeInsets.symmetric(vertical: 24),
            child: ImagePickerWidget(
              imageFile: File(regi.selectedSignatureImagePath.value),
              faceName: 'signature',
              onTap: () {
                showImagePickerOptions(context, regiController);
              },
            ),
          ),
        ),
        _uploadPhotoButton(regiController),
      ],
    );
  }

  Widget _uploadPhotoButton(RegistrationController regiController) {
    return CommonButton(
      width: Dimensions.screenWidth * 0.8,
      buttonTitle: 'photo_upload'.tr,
      onPressed: () {
        regi.pickSignatureImage(ImageSource.camera);
      },
    );
  }
}

Future<void> showImagePickerOptions(
  BuildContext context,
  RegistrationController regi,
) async {
  await showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        content: SizedBox(
          height: Dimensions.height275,
          width: Dimensions.width100 * 3.25,
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: const Icon(Icons.close),
                ),
              ),
              Center(
                child: InkWell(
                  onTap: () {
                    regi.pickSignatureImage(ImageSource.camera);
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.camera_alt_outlined,
                        color: Colors.grey,
                        size: 100,
                      ),
                      const SizedBoxHeight20(),
                      Container(
                        height: Dimensions.height50,
                        width: Dimensions.width100 * 1.85,
                        decoration: BoxDecoration(
                          color: whiteColor,
                          border: Border.all(
                            color: primaryColor,
                          ),
                        ),
                        alignment: Alignment.center,
                        child: TextWidget(
                          'open_camera'.tr,
                          style: TextStyles.title16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
