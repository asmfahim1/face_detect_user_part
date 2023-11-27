import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mict_final_project/core/utils/extensions.dart';

import '../../../core/utils/colors.dart';

class RegistrationController extends GetxController {
  PageController _pageController = PageController(initialPage: 0);
  int _activePage = 0;
  RxString selectedFrontImagePath = ''.obs;
  RxString selectedFrontImageSize = ''.obs;
  RxString selectedLeftImagePath = ''.obs;
  RxString selectedLeftImageSize = ''.obs;
  RxString selectedRightImagePath = ''.obs;
  RxString selectedRightImageSize = ''.obs;
  RxString selectedSignatureImagePath = ''.obs;
  RxString selectedSignatureImageSize = ''.obs;

  File? _firstImageFile;
  File? _secondImageFile;
  File? _thirdImageFile;
  File? _fourImageFile;

  set firstImageFile(File? file) {
    _firstImageFile = file;
    update();
  }

  set secondImageFile(File? file) {
    _secondImageFile = file;
    update();
  }

  set thirdImageFile(File? file) {
    _thirdImageFile = file;
    update();
  }

  set fourImageFile(File? file) {
    _fourImageFile = file;
    update();
  }

  set pageController(PageController value) {
    _pageController = value;
    update();
  }

  set activePage(int value) {
    _activePage = value;
    update();
  }

  changePage() {
    if (pageController.page != null) {
      pageController.nextPage(
          duration: const Duration(milliseconds: 500), curve: Curves.ease);
    }
  }

  Future<void> pickFrontImage(ImageSource source) async {
    final pickedImage = await ImagePicker().pickImage(source: source);
    if (pickedImage != null) {
      selectedFrontImagePath.value = pickedImage.path;
      //image size converted to MB
      selectedFrontImageSize.value =
          '${((File(selectedFrontImagePath.value)).lengthSync() / 1024 / 1024).toStringAsFixed(2)} MB';
      Get.back();
      "the size of the image is: $selectedFrontImageSize".log();
    } else {
      Get.back();
      Get.snackbar('Warning!', 'No image selected from device',
          snackPosition: SnackPosition.TOP,
          backgroundColor: redColor,
          colorText: whiteColor,
          duration: const Duration(seconds: 2));
    }
  }

  Future<void> pickLeftImage(ImageSource source) async {
    final pickedImage = await ImagePicker().pickImage(source: source);
    if (pickedImage != null) {
      selectedLeftImagePath.value = pickedImage.path;
      //image size converted to MB
      selectedLeftImageSize.value =
          '${((File(selectedLeftImagePath.value)).lengthSync() / 1024 / 1024).toStringAsFixed(2)} MB';
      Get.back();
      "the size of the image is: $selectedFrontImageSize".log();
    } else {
      Get.back();
      Get.snackbar('Warning!', 'No image selected from device',
          snackPosition: SnackPosition.TOP,
          backgroundColor: redColor,
          colorText: whiteColor,
          duration: const Duration(seconds: 2));
    }
  }

  Future<void> pickRightImage(ImageSource source) async {
    final pickedImage = await ImagePicker().pickImage(source: source);
    if (pickedImage != null) {
      selectedRightImagePath.value = pickedImage.path;
      //image size converted to MB
      selectedRightImageSize.value =
          '${((File(selectedRightImagePath.value)).lengthSync() / 1024 / 1024).toStringAsFixed(2)} MB';
      Get.back();
      "the size of the image is: $selectedRightImagePath".log();
    } else {
      Get.back();
      Get.snackbar('Warning!', 'No image selected from device',
          snackPosition: SnackPosition.TOP,
          backgroundColor: redColor,
          colorText: whiteColor,
          duration: const Duration(seconds: 2));
    }
  }

  Future<void> pickSignatureImage(ImageSource source) async {
    final pickedImage = await ImagePicker().pickImage(source: source);
    if (pickedImage != null) {
      selectedSignatureImagePath.value = pickedImage.path;
      //image size converted to MB
      selectedSignatureImageSize.value =
          '${((File(selectedSignatureImagePath.value)).lengthSync() / 1024 / 1024).toStringAsFixed(2)} MB';
      Get.back();
      "the size of the image is: $selectedSignatureImagePath".log();
    } else {
      Get.back();
      Get.snackbar('Warning!', 'No image selected from device',
          snackPosition: SnackPosition.TOP,
          backgroundColor: redColor,
          colorText: whiteColor,
          duration: const Duration(seconds: 2));
    }
  }

  void clearImageFields() {
    selectedFrontImagePath.value = '';
    selectedFrontImageSize.value = '';
    selectedLeftImagePath.value = '';
    selectedLeftImageSize.value = '';
    selectedRightImagePath.value = '';
    selectedRightImageSize.value = '';
    selectedSignatureImagePath.value = '';
    selectedSignatureImageSize.value = '';
  }

  PageController get pageController => _pageController;

  int get activePage => _activePage;

  File? get firstImageFile => _firstImageFile;
  File? get secondImageFile => _secondImageFile;
  File? get thirdImageFile => _thirdImageFile;
  File? get fourImageFile => _fourImageFile;
}
