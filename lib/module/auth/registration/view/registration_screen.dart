import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mict_final_project/core/utils/dimensions.dart';
import 'package:mict_final_project/core/utils/exports.dart';
import 'package:mict_final_project/core/widgets/exports.dart';
import 'package:mict_final_project/module/auth/registration/controller/registration_controller.dart';
import 'package:mict_final_project/module/auth/registration/view/complete_registration_process_screen.dart';
import 'package:mict_final_project/module/auth/registration/view/front_face_screen.dart';
import 'package:mict_final_project/module/auth/registration/view/left_face_screen.dart';
import 'package:mict_final_project/module/auth/registration/view/right_face_screen.dart';
import 'package:mict_final_project/module/auth/registration/view/signature_upload_screen.dart';
import 'package:mict_final_project/module/auth/registration/view/verification_message.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class RegistrationScreen extends StatelessWidget {
  RegistrationScreen({Key? key}) : super(key: key);

  final _list = [
    VerificationMessage(),
    FrontFaceScreen(),
    RightFaceUploadScreen(),
    LeftFaceUploadScreen(),
    UploadSignatureScreen(),
    CompleteRegistrationScreen(),
  ];

  final RegistrationController regi = Get.put(RegistrationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: primaryColor,
        centerTitle: true,
        elevation: 0,
        title: TextWidget(
          'registration'.tr,
          style: TextStyles.title20.copyWith(
            color: whiteColor,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: commonScaffoldPadding,
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  controller: regi.pageController,
                  itemCount: _list.length,
                  // onPageChanged: (page) {
                  //   regi.activePage = page;
                  // },
                  itemBuilder: (_, index) {
                    return _list[index];
                  },
                ),
              ),
              SizedBox(
                height: Dimensions.height10 * 8,
                width: Dimensions.screenWidth,
                child: Center(
                  child: SmoothPageIndicator(
                    controller: regi.pageController,
                    count: _list.length,
                    effect: WormEffect(
                      activeDotColor: primaryColor,
                      dotWidth: Dimensions.width35,
                      dotHeight: Dimensions.height10,
                      spacing: Dimensions.width10 * 1.7,
                      type: WormType.underground,
                    ),
                    onDotClicked: (int page) {
                      // Jump to the selected page
                      regi.pageController.jumpToPage(page);
                    },
                  ),
                ),
              ),
              const SizedBoxHeight20(),
              // _continueButton(),
            ],
          ),
        ),
      ),
    );
  }
}
