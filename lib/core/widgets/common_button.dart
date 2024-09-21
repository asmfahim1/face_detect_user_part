import 'package:flutter/material.dart';
import 'package:mict_final_project/core/utils/dimensions.dart';
import 'package:mict_final_project/core/widgets/text_widget.dart';
import '../utils/colors.dart';
import '../utils/styles.dart';

class CommonButton extends StatelessWidget {
  const CommonButton({
    super.key,
    required this.buttonTitle,
    this.onPressed,
    this.height,
    this.width,
    this.fontSize = 14,
    this.borderRadius = 6,
    this.buttonTextColor,
    this.fontWeight = FontWeight.w500,
    this.buttonColor,
  });

  final String buttonTitle;
  final double? height;
  final VoidCallback? onPressed;
  final double? width;
  final double borderRadius;
  final Color? buttonColor;
  final Color? buttonTextColor;
  final double fontSize;
  final FontWeight fontWeight;

  @override
  Widget build(BuildContext context) {
    Color btnColor = buttonColor ?? primaryColor;
    return SizedBox(
      height: height ?? Dimensions.height10 * 5.7,
      width: width,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          backgroundColor: btnColor,
        ),
        onPressed: onPressed,
        child: Flexible(
          child: TextWidget(
            buttonTitle,
            textAlign: TextAlign.center,
            style: TextStyles.title16.copyWith(
              color: buttonTextColor ?? whiteColor,
              fontSize: fontSize,
              fontWeight: fontWeight,
            ),
          ),
        ),
      ),
    );
  }
}
