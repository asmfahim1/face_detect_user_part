import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mict_final_project/core/utils/asset_path.dart';
import 'package:mict_final_project/core/utils/dimensions.dart';

import '../../../../core/utils/colors.dart';

class ImagePickerWidget extends StatelessWidget {
  final File? imageFile;
  final String? faceName;
  final void Function()? onTap;
  const ImagePickerWidget({
    Key? key,
    this.imageFile,
    required this.onTap,
    this.faceName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: Dimensions.height100 * 1.8,
        width: Dimensions.width100 * 1.5,
        decoration: BoxDecoration(
          border: Border.all(color: primaryColor, width: 2),
        ),
        child: (imageFile != null && imageFile!.path.isNotEmpty)
            ? Image.file(
                imageFile!,
                fit: BoxFit.cover,
              )
            : Padding(
                padding: const EdgeInsets.all(16.0),
                child: faceName == 'front'
                    ? Image.asset(
                        faceIconFront1,
                        fit: BoxFit.cover,
                      )
                    : faceName == 'left'
                        ? Image.asset(
                            faceIconLeft1,
                            fit: BoxFit.cover,
                          )
                        : faceName == 'right'
                            ? Image.asset(
                                faceIconRight1,
                                fit: BoxFit.cover,
                              )
                            : faceName == 'signature'
                                ? Image.asset(
                                    signatureIcon,
                                    fit: BoxFit.cover,
                                  )
                                : Image.asset(
                                    appIconImage,
                                    fit: BoxFit.cover,
                                  ),
              ),
      ),
    );
  }
}
