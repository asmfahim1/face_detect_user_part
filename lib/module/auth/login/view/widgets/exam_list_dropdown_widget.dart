import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mict_final_project/core/utils/colors.dart';
import 'package:mict_final_project/core/utils/dimensions.dart';
import 'package:mict_final_project/core/utils/styles.dart';
import 'package:mict_final_project/core/widgets/text_widget.dart';
import 'package:mict_final_project/module/auth/login/controller/login_controller.dart';

class ExamDropdown extends StatelessWidget {
  const ExamDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(
      builder: (controller) {
        if (controller.isExamListLoaded.value) {
          return const Center(
              child: CircularProgressIndicator(
            color: primaryColor,
          )); // Show loading indicator while fetching data
        }

        if (controller.examList.isEmpty) {
          return TextWidget(
            'null_exam_list'.tr,
            style: TextStyles.regular14.copyWith(color: redColor),
          );
        }

        return Container(
          height: Dimensions.screenHeight / 14,
          width: Dimensions.screenWidth,
          padding: const EdgeInsets.only(left: 10, right: 10),
          alignment: Alignment.centerLeft,
          margin: const EdgeInsets.only(top: 10),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey,
              width: 1.0,
            ),
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: DropdownButton<String>(
            focusColor: whiteColor,
            underline: const SizedBox(),
            iconSize: 30.0,
            style: const TextStyle(
              fontSize: 18.0,
              color: Colors.black,
            ),
            items: controller.examList.map((exam) {
              return DropdownMenuItem<String>(
                value: exam.name!,
                child: Text(exam.name!),
              );
            }).toList(),
            onChanged: (selectedExam) {
              controller.setSelectedValue(selectedExam!);
              // final exam = controller.examList
              //     .firstWhere((element) => element.name! == selectedExam);
              // controller.examType.value = exam.name!;
              // controller.examId.value = exam.id!;
            },
            hint: TextWidget(
              controller.examType.value,
              style: TextStyles.title16,
            ),
            isExpanded: true,
            icon: const Icon(
              Icons.arrow_drop_down,
              color: Colors.grey,
            ),
          ),
        );
      },
    );
  }
}
