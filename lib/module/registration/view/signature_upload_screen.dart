import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mict_final_project/core/widgets/exports.dart';
import 'package:mict_final_project/module/home/view/widgets/image_picker_widget.dart';
import 'package:mict_final_project/module/registration/controller/registration_controller.dart';
import 'package:get/get.dart';
import '../../../core/utils/exports.dart';
import '../../../core/widgets/text_widget.dart';

class UploadSignatureScreen extends StatefulWidget {
  const UploadSignatureScreen({Key? key}) : super(key: key);

  @override
  State<UploadSignatureScreen> createState() => _UploadSignatureScreenState();
}

class _UploadSignatureScreenState extends State<UploadSignatureScreen> {
  RegistrationController regi = Get.put(RegistrationController());

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: whiteColor,
      body: SizedBox(
        width: size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextWidget('Upload your signature here', style: TextStyles.title16,),
            _uploadedPhotoWidget(regi)
          ],
        ),
      ),
    );
  }

  Widget _uploadedPhotoWidget(RegistrationController regiController) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 24),
          child: ImagePickerWidget(
            imageFile: regiController.firstImageFile,
            onTap: () {
              showImagePickerOptions(context, regiController);
            },
          ),
        ),
        _uploadPhotoButton(regiController),
      ],
    );
  }

  Widget _uploadPhotoButton(RegistrationController regiController) {
    Size size = MediaQuery.of(context).size;
    return CommonButton(
      buttonColor: blueColor,
      width: size.width / 2,
      buttonTitle: 'Upload photo',
      onTap: () {
        regi.changePage();
        //showImagePickerOptions(context, regiController);
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
                    regi.pickImage(ImageSource.camera);
                    Navigator.pop(context);
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
