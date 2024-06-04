import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mict_final_project/core/utils/app_routes.dart';
import 'package:mict_final_project/core/utils/dimensions.dart';
import 'package:mict_final_project/core/utils/exports.dart';
import 'package:mict_final_project/core/widgets/exports.dart';
import 'package:mict_final_project/module/auth/registration/controller/registration_controller.dart';
import 'package:mict_final_project/module/home/view/widgets/image_picker_widget.dart';

class UploadSignatureScreen extends StatefulWidget {
  const UploadSignatureScreen({Key? key}) : super(key: key);

  @override
  State<UploadSignatureScreen> createState() => _UploadSignatureScreenState();
}

class _UploadSignatureScreenState extends State<UploadSignatureScreen> {
  RegistrationController regi = Get.put(RegistrationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: SizedBox(
        width: Dimensions.screenWidth,
        child: Obx(() {
          return regi.frontFileName.value == '' ||
                  regi.leftFileName.value == '' ||
                  regi.rightFileName.value == '' ||
                  regi.signatureName.value == ''
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextWidget(
                      'Upload your signature here',
                      style: TextStyles.title16,
                    ),
                    _uploadedPhotoWidget(regi),
                    SizedBox(
                      height: Dimensions.height20,
                    ),
                    Obx(() {
                      return regi.frontFileName.value == '' ||
                              regi.leftFileName.value == '' ||
                              regi.rightFileName.value == '' ||
                              regi.signatureName.value == ''
                          ? Container()
                          : _completeProcess(regi);
                    }),
                  ],
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextWidget(
                      'Your registration is about to complete. Please press complete and all the best',
                      style: TextStyles.title16,
                    ),
                    SizedBox(
                      height: Dimensions.height20,
                    ),
                    _completeProcess(regi),
                  ],
                );
        }),
      ),
    );
  }

  Widget _uploadedPhotoWidget(RegistrationController regiController) {
    return Column(
      children: [
        Obx(
          () => Padding(
            padding: const EdgeInsets.symmetric(vertical: 24),
            child: ImagePickerWidget(
              imageFile: File(regi.selectedSignatureImagePath.value),
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
      buttonColor: blueColor,
      width: Dimensions.screenWidth / 2,
      buttonTitle: 'Upload photo',
      onTap: () async {
        //regi.changePage();
        print('the value of the page is :${regi.pageController}');
        await regi.pickSignatureImage(ImageSource.camera);
      },
    );
  }
}

Widget _completeProcess(RegistrationController regi) {
  return CommonButton(
    buttonColor: blueColor,
    width: Dimensions.screenWidth / 2,
    buttonTitle: 'Complete Process',
    onTap: () async {
      //regi.changePage();
      print('the value of the page is :${regi.pageController}');
      Get.offAllNamed(AppRoutes.homeScreen);
    },
  );
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
          height: 276,
          width: 327,
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
                          'Open camera',
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
