import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class RegistrationController extends GetxController{
  PageController _pageController = PageController(initialPage: 0);
  int _activePage = 0;

  File? _firstImageFile;
  File? _secondImageFile;
  File? _thirdImageFile;
  File? _fourImageFile;
  final List<File?> _fileList = [];


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

  changePage(){
    if (pageController.page != null) {
      pageController.nextPage(duration: const Duration(milliseconds: 500), curve: Curves.ease);
    }
  }

  void pickImage(
      ImageSource source,
      ) async {
    final pickedImage = await ImagePicker().pickImage(source: source);
    if (pickedImage != null) {
      _fileList.add(File(pickedImage.path));
    }
  }

  PageController get pageController => _pageController;

  int get activePage => _activePage;

  File? get firstImageFile => _firstImageFile;
  File? get secondImageFile => _secondImageFile;
  File? get thirdImageFile => _thirdImageFile;
  File? get fourImageFile => _fourImageFile;
}