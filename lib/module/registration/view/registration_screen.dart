import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mict_final_project/core/widgets/exports.dart';
import 'package:mict_final_project/module/home/view/home_screen.dart';
import 'package:mict_final_project/module/registration/controller/registration_controller.dart';
import 'package:mict_final_project/module/registration/view/front_face_screen.dart';
import 'package:mict_final_project/module/registration/view/left_face_screen.dart';
import 'package:mict_final_project/module/registration/view/right_face_screen.dart';
import 'package:mict_final_project/module/registration/view/signature_upload_screen.dart';
import '../../../core/utils/exports.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _list = [
    const FrontFaceScreen(),
    const RightFaceUploadScreen(),
    const LeftFaceUploadScreen(),
    const UploadSignatureScreen(),
  ];
  RegistrationController regi = Get.put(RegistrationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: whiteColor,
        centerTitle: true,
        elevation: 0,
        title: TextWidget(
          'Registration',
          style: TextStyles.regular18.copyWith(
            color: darkGrayColor,
          ),
        ),
      ),
      backgroundColor: whiteColor,
      body: SafeArea(
        child:  Padding(
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

  /*Widget _continueButton() {
    Size size = MediaQuery.of(context).size;
    return CommonButton(
      buttonColor: blueColor,
      width: size.width / 2,
      buttonTitle: 'Continue',
      onTap: () {
        regi.changePage();
        //Get.to(()=> HomeScreen());
      },
    );
  }*/
}
