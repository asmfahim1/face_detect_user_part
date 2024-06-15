import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mict_final_project/core/utils/dimensions.dart';
import 'package:mict_final_project/core/utils/extensions.dart';
import 'package:mict_final_project/module/home/view/widgets/image_picker_widget.dart';


class CommonImageShowWidget extends StatelessWidget {
  final String imagePath;

  const CommonImageShowWidget({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Dimensions.height100 * 1.5,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6)
      ),
      child: ImagePickerWidget(
        imageFile: File(imagePath), onTap: () {},
      ),
    );
  }
}
