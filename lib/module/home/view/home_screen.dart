import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mict_final_project/core/utils/app_routes.dart';
import 'package:mict_final_project/core/utils/exports.dart';
import 'package:mict_final_project/core/widgets/exports.dart';
import 'package:mict_final_project/module/auth/login/controller/login_controller.dart';
import 'package:mict_final_project/module/home/controller/home_controller.dart';

import '../../../core/widgets/sized_box_height_10.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeController home = Get.find<HomeController>();
  final imageList = [
    openCameraIconPath,
    openCameraIconPath,
    openCameraIconPath,
    openCameraIconPath,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: whiteColor,
        centerTitle: true,
        elevation: 0,
        title: TextWidget(
          'Home',
          style: TextStyles.regular18.copyWith(
            color: darkGrayColor,
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              if (Get.find<LoginController>().userLoggedIn()) {
                Get.find<LoginController>().clearSharedData();
                Get.offAllNamed(AppRoutes.loginScreen);
              }
            },
            child: const Padding(
              padding: EdgeInsets.only(right: 10),
              child: Icon(
                Icons.logout_outlined,
                color: redColor,
                size: 25,
              ),
            ),
          )
        ],
      ),
      body: Column(
        children: [
          _profileWidget(),
          const SizedBoxHeight10(),
          // _uploadedPhotoWidget(home),
        ],
      ),
    );
  }

  Widget _profileWidget() {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height / 6,
      width: size.width,
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        border: Border.all(),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          const CircleAvatar(
            backgroundColor: blueColor,
            radius: 40,
            child: Icon(
              Icons.person,
              size: 40,
              color: Colors.white,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextWidget(
                'Abu Sale Mohammad Fahim',
                style: TextStyles.title16,
              ),
              TextWidget(
                'id: 2254991017',
                style: TextStyles.title16,
              ),
              TextWidget(
                'exam : BCS exam',
                style: TextStyles.title16,
              ),
            ],
          ),
        ],
      ),
    );
  }

  /*Widget _uploadedPhotoWidget(HomeController homeController) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 24),
          child: ImagePickerWidget(
            imageFile: homeController.firstImageFile,
            onTap: () {
              showImagePickerOptions(context, homeController);
            },
          ),
        ),
        _uploadPhotoButton(homeController),
        const SizedBoxHeight20(),
        Container(
          height: 84,
          padding: const EdgeInsets.only(left: 10),
          child: Row(
            children: [
              _uploadedPicturesWidget(
                imagePath: appIconImage,
              ),
              Container(
                height: 84,
                width: 50,
                alignment: Alignment.center,
                child: const SizedBox(
                  height: 25,
                  width: 25,
                  child: Icon(
                    Icons.camera_alt_outlined,
                    color: Colors.grey,
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget _uploadedPicturesWidget({
    required String imagePath,
  }) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width / 1.2,
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: imageList.length,
        itemBuilder: (context, index) {
          return Container(
            height: 77,
            width: 84,
            margin: const EdgeInsets.symmetric(horizontal: 5),
            decoration: BoxDecoration(
              color: darkGrayColor,
              borderRadius: radiusAll10,
            ),
            child: UploadedPicturesWidget(
              imageList[index],
              height: 48,
              width: 48,
              color: whiteColor,
            ),
          );
        },
      ),
    );
  }

  Widget _uploadPhotoButton(HomeController homeController) {
    Size size = MediaQuery.of(context).size;
    return CommonButton(
      buttonColor: blueColor,
      width: size.width / 2,
      buttonTitle: 'Upload photo',
      onTap: () {
        showImagePickerOptions(context, homeController);
      },
    );
  }*/

  Future<void> showImagePickerOptions(
    BuildContext context,
    HomeController homeController,
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
                      homeController.pickImage(ImageSource.camera);
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
}
