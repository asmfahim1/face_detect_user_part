import 'dart:io';
import 'package:flutter/material.dart';
import 'package:mict_final_project/module/home/view/widgets/image_picker_widget.dart';


class CommonImageShowWidget extends StatelessWidget {
  final String imagePath;

  const CommonImageShowWidget({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return ImagePickerWidget(
      imageFile: File(imagePath), onTap: null,
    );
  }
}
