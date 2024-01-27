import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mict_final_project/module/home/repo/home_repo.dart';

class HomeController extends GetxController {
  final HomeRepo? homeRepo;
  HomeController({this.homeRepo});

  File? _firstImageFile;
  File? _secondImageFile;
  File? _thirdImageFile;
  File? _fourthImageFile;
  final List<File?> _fileList = [];

  set firstImageFile(File? file) {
    _firstImageFile = file;
    update();
  }

  Future<void> pickImage(
    ImageSource source,
  ) async {
    final pickedImage = await ImagePicker().pickImage(source: source);
    if (pickedImage != null) {
      _fileList.add(File(pickedImage.path));
    }
  }

  File? get firstImageFile => _firstImageFile;
  File? get secondImageFile => _secondImageFile;
  File? get thirdImageFile => _thirdImageFile;
  File? get fourthImageFile => _fourthImageFile;
}
