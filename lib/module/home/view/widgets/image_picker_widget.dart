import 'dart:io';
import 'package:flutter/material.dart';
import 'package:mict_final_project/core/utils/asset_path.dart';
import 'package:mict_final_project/core/utils/dimensions.dart';
import '../../../../core/utils/colors.dart';

class ImagePickerWidget extends StatelessWidget {
  final File? imageFile;
  final String? faceName;
  final VoidCallback? onTap;
  final VoidCallback? onRemove;

  const ImagePickerWidget({
    super.key,
    this.imageFile,
    required this.onTap,
    this.onRemove,
    this.faceName,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (imageFile != null && imageFile!.path.isNotEmpty) ? onTap : null,
      child: Container(
        width: Dimensions.screenWidth * 0.8,
        height: Dimensions.screenWidth * 0.8,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: Colors.grey.shade300,
            width: 2,
          ),
        ),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: (imageFile != null && imageFile!.path.isNotEmpty)
                  ? Image.file(
                imageFile!,
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,  //< now safe because parent has fixed height
              )
                  : Padding(
                padding: const EdgeInsets.all(16.0),
                child: _getPlaceholderImage(),
              ),
            ),
            // Remove button as before...
          ],
        ),
      ),
    );
  }

  Widget _getPlaceholderImage() {
    switch (faceName) {
      case 'front':
        return Image.asset(faceIconFront1, fit: BoxFit.cover);
      case 'left':
        return Image.asset(faceIconLeft1, fit: BoxFit.cover);
      case 'right':
        return Image.asset(faceIconRight1, fit: BoxFit.cover);
      case 'signature':
        return Image.asset(signatureIcon, fit: BoxFit.cover);
      default:
        return Image.asset(appIconImage, fit: BoxFit.cover);
    }
  }
}
