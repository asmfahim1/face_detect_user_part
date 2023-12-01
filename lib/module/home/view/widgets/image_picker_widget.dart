import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mict_final_project/core/utils/asset_path.dart';
import 'package:mict_final_project/core/utils/dimensions.dart';

import '../../../../core/utils/colors.dart';

class ImagePickerWidget extends StatelessWidget {
  final File? imageFile;
  final void Function()? onTap;
  const ImagePickerWidget({
    Key? key,
    this.imageFile,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('Image path $imageFile');
    return InkWell(
      onTap: onTap,
      child: Container(
        height: Dimensions.height100 * 2,
        width: Dimensions.width100 * 2,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(color: strokeColor),
        ),
        child: (imageFile != null && imageFile!.path.isNotEmpty)
            ? Image.file(
                imageFile!,
                height: Dimensions.height100 * 2,
                width: Dimensions.width100 * 2,
                fit: BoxFit.cover,
              )
            : Image.asset(
                appIconImage,
                height: Dimensions.height100 * 2,
                width: Dimensions.width100 * 2,
                fit: BoxFit.cover,
              ),
      ),
    );
  }
}
