import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mict_final_project/core/utils/exports.dart';
import 'package:mict_final_project/core/widgets/exports.dart';
import 'package:mict_final_project/module/auth/registration/controller/registration_controller.dart';
import 'package:mict_final_project/module/auth/registration/view/complete_registration_process_screen.dart';
import 'package:mict_final_project/module/auth/registration/view/front_face_screen.dart';
import 'package:mict_final_project/module/auth/registration/view/left_face_screen.dart';
import 'package:mict_final_project/module/auth/registration/view/right_face_screen.dart';
import 'package:mict_final_project/module/auth/registration/view/signature_upload_screen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class RegistrationScreen extends StatelessWidget {
  RegistrationScreen({Key? key}) : super(key: key);

  final _list = [
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
          'Registration',
          style: TextStyles.title20.copyWith(
            color: darkGrayColor,
          ),
        ),
      ),
      backgroundColor: whiteColor,
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
              const SizedBoxHeight20(),
              SmoothPageIndicator(
                controller: regi.pageController,
                count: _list.length,
                effect: const WormEffect(
                  activeDotColor: primaryColor,
                  dotWidth: 30,
                  dotHeight: 8,
                  spacing: 16,
                  type: WormType.underground,
                ),
                onDotClicked: (int page) {
                  // Jump to the selected page
                  regi.pageController.jumpToPage(page);
                },
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
