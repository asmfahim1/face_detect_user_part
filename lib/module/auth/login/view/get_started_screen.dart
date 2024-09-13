import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mict_final_project/core/utils/dimensions.dart';
import 'package:mict_final_project/core/widgets/exports.dart';

import '../../../../core/utils/app_routes.dart';
import '../../../../core/utils/exports.dart';

class GetStartedScreen extends StatelessWidget {
  const GetStartedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _topSectionWidget(context),
          _bottomSectionWidget(context),
        ],
      ),
    );
  }

  Widget _topSectionWidget(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height / 2,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(loginBackgroundImage),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _bottomSectionWidget(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Expanded(
      child: InkWell(
        onTap: () {
          Get.toNamed(AppRoutes.loginScreen);
        },
        child: Container(
          color: primaryColor,
          child: Column(
            children: [
              Container(
                height: size.height / 2.4,
                padding: EdgeInsets.all(Dimensions.padding20),
                child: Column(
                  children: [
                    TextWidget(
                      'welcome_text_title'.tr,
                      style: TextStyles.title20.copyWith(color: whiteColor),
                    ),
                    const SizedBoxHeight20(),
                    TextWidget(
                      'welcome_text_description'.tr,
                      style: TextStyles.regular14.copyWith(color: whiteColor),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  width: size.width,
                  decoration: const BoxDecoration(
                    border: Border(
                      top: BorderSide(
                        color: whiteColor,
                        width: 1.1,
                      ),
                    ),
                  ),
                  alignment: Alignment.center,
                  child: TextWidget(
                    'next_btn'.tr,
                    style: TextStyles.regular18.copyWith(color: whiteColor),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}