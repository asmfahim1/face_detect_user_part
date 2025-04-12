import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mict_final_project/core/utils/dimensions.dart';
import 'package:mict_final_project/core/utils/exports.dart';
import 'package:mict_final_project/core/widgets/exports.dart';
import 'package:mict_final_project/module/auth/registration/controller/registration_controller.dart';
import 'package:mict_final_project/module/home/view/widgets/image_picker_widget.dart';

class FrontFaceScreen extends StatelessWidget {
  FrontFaceScreen({super.key});

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
              'front_upload'.tr,
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
            padding: EdgeInsets.symmetric(vertical: Dimensions.padding10 * 2.4),
            child: ImagePickerWidget(
              imageFile: File(regi.selectedFrontImagePath.value),
              faceName: 'front',
              onTap: () {
                showImagePickerOptions(context, regiController);
              },

              onRemove: (){
                regi.selectedFrontImagePath.value = '';
              },

            ),
          ),
        ),
        _uploadPhotoButton(regiController, context),
      ],
    );
  }

  Widget _uploadPhotoButton(RegistrationController regiController, BuildContext context) {
    return CommonButton(
      width: Dimensions.widthScreenHalf,
      buttonTitle: 'photo_upload'.tr,
      onPressed: () {
        regi.pickFrontImage(ImageSource.camera);
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
          height: Dimensions.height100 * 2.76,
          width: Dimensions.width100 * 3.70,
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
                    regi.pickFrontImage(ImageSource.camera);
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
                        height: 52,
                        width: 185,
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
