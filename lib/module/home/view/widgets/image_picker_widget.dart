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
        height: Dimensions.height100 * 1.8,
        width: Dimensions.width100 * 1.5,
        decoration: BoxDecoration(
          border: Border.all(color: primaryColor, width: 2),
          borderRadius: BorderRadius.circular(10),
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
                      height: double.infinity,
                    )
                  : Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: _getPlaceholderImage(),
                    ),
            ),

            // Remove button (visible only when image is selected)
            if (imageFile != null && imageFile!.path.isNotEmpty)
              Positioned(
                top: 6,
                right: 6,
                child: GestureDetector(
                  onTap: onRemove,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.5),
                      shape: BoxShape.circle,
                    ),
                    padding: const EdgeInsets.all(6),
                    child: const Icon(
                      Icons.close,
                      color: Colors.white,
                      size: 18,
                    ),
                  ),
                ),
              ),
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
