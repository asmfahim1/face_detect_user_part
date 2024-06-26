import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';
import 'package:mict_final_project/core/ML/Recognition.dart';
import 'package:mict_final_project/core/ML/Recognizer.dart';
import 'package:mict_final_project/core/utils/app_routes.dart';
import 'package:mict_final_project/core/utils/dialogue_utils.dart';
import 'package:mict_final_project/core/utils/exports.dart';
import 'package:mict_final_project/module/auth/registration/repo/regi_repo.dart';

class RegistrationController extends GetxController {
  RegiRepo? regiRepo;
  RegistrationController({this.regiRepo});

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    imagePicker = ImagePicker();

    //TODO initialize face detector

    final options =
        FaceDetectorOptions(performanceMode: FaceDetectorMode.accurate);
    faceDetector = FaceDetector(options: options);

    //TODO initialize face recognizer
    recognizer = Recognizer();
  }

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

  set pageController(PageController value) {
    _pageController = value;
    update();
  }

  set activePage(int value) {
    _activePage = value;
    update();
  }

  void changePage() {
    if (pageController.page != null) {
      int currentPage = pageController.page!.round();
      if (currentPage <= 4) {
        // Not the last page, proceed to the next page
        pageController.nextPage(
          duration: const Duration(milliseconds: 500),
          curve: Curves.ease,
        );
      }
    }
  }

  final RxString frontFileName = ''.obs;
  Future<void> pickFrontImage(ImageSource source) async {
    final pickedImage = await ImagePicker().pickImage(source: source);
    if (pickedImage != null) {

      String fileName = pickedImage.path.split('/').last;
      final File imageFile = File(pickedImage.path);

      Get.back();
      DialogUtils.showLoading(title: 'uploading'.tr);

      try {
        if (await doFaceDetection(imageFile) == true) {
          Map<String, dynamic> response =
              await (regiRepo!.uploadFileWithDio(imageFile, fileName));

          if (response["status"] == 201) {
            selectedFrontImagePath.value = pickedImage.path;
            DialogUtils.closeLoading();
            changePage();

            frontFileName.value = '${response["imagePath"]}';
          }
        } else {
          DialogUtils.closeLoading();
          DialogUtils.showErrorDialog(
              description: 'no_face_found'.tr, btnName: 'try_again_btn'.tr);
        }
      } catch (error) {
        DialogUtils.closeLoading();
        DialogUtils.showErrorDialog(btnName: 'try_again_btn'.tr, description: "$error");
      }
    } else {
      Get.back();
      Get.snackbar(
        'warning'.tr,
        'no_image_selected'.tr,
        snackPosition: SnackPosition.TOP,
        backgroundColor: redColor,
        colorText: whiteColor,
        duration: const Duration(seconds: 2),
      );
    }
  }

  final RxString rightFileName = ''.obs;
  Future<void> pickRightImage(ImageSource source) async {
    final pickedImage = await ImagePicker().pickImage(source: source);
    if (pickedImage != null) {

      String fileName = pickedImage.path.split('/').last;
      final File imageFile = File(pickedImage.path);

      Get.back();

      DialogUtils.showLoading(title: 'uploading'.tr);

      try {
        if (await doFaceDetection(imageFile) == true) {
          Map<String, dynamic> response =
              await (regiRepo!.uploadFileWithDio(imageFile, fileName));

          if (response["status"] == 201) {
            selectedRightImagePath.value = pickedImage.path;
            DialogUtils.closeLoading();
            changePage();

            rightFileName.value = '${response["imagePath"]}';
          }
        } else {
          DialogUtils.closeLoading();
          DialogUtils.showErrorDialog(
              description: 'no_face_found'.tr, btnName: 'try_again_btn'.tr);
        }
      } catch (error) {
        DialogUtils.closeLoading();
        DialogUtils.showErrorDialog(btnName: 'try_again_btn'.tr, description: "$error");
      }
    } else {
      Get.back();
      Get.snackbar(
        'warning'.tr,
        'no_image_selected'.tr,
        snackPosition: SnackPosition.TOP,
        backgroundColor: redColor,
        colorText: whiteColor,
        duration: const Duration(seconds: 2),
      );
    }
  }

  final RxString leftFileName = ''.obs;
  Future<void> pickLeftImage(ImageSource source) async {
    final pickedImage = await ImagePicker().pickImage(source: source);
    if (pickedImage != null) {

      String fileName = pickedImage.path.split('/').last;
      final File imageFile = File(pickedImage.path);

      Get.back();

      DialogUtils.showLoading(title: 'uploading'.tr);

      try {
        if (await doFaceDetection(imageFile) == true) {
          Map<String, dynamic> response =
              await (regiRepo!.uploadFileWithDio(imageFile, fileName));

          if (response["status"] == 201) {
            selectedLeftImagePath.value = pickedImage.path;
            DialogUtils.closeLoading();
            changePage();

            leftFileName.value = '${response["imagePath"]}';
          }
        } else {
          DialogUtils.closeLoading();
          DialogUtils.showErrorDialog(
              description: 'no_face_found'.tr, btnName: 'try_again_btn'.tr);
        }
      } catch (error) {
        DialogUtils.closeLoading();
        DialogUtils.showErrorDialog(btnName: 'try_again_btn'.tr, description: "$error");
      }
    } else {
      Get.back();
      Get.snackbar(
        'warning'.tr,
        'no_image_selected'.tr,
        snackPosition: SnackPosition.TOP,
        backgroundColor: redColor,
        colorText: whiteColor,
        duration: const Duration(seconds: 2),
      );
    }
  }

  final RxString signatureName = ''.obs;
  Future<void> pickSignatureImage(ImageSource source) async {
    final pickedImage = await ImagePicker().pickImage(source: source);

    if (pickedImage != null) {
      String fileName = pickedImage.path.split('/').last;
      final File imageFile = File(pickedImage.path);

      Get.back();

      DialogUtils.showLoading(title: 'uploading'.tr);


      try {
        Map<String, dynamic> response =
            await (regiRepo!.uploadFileWithDio(imageFile, fileName));



        if (response["status"] == 201) {
          selectedSignatureImagePath.value = pickedImage.path;
          DialogUtils.closeLoading();
          changePage();

          signatureName.value = '${response["imagePath"]}';
        }
      } catch (error) {
        DialogUtils.closeLoading();
        DialogUtils.showErrorDialog(btnName: 'try_again_btn'.tr, description: "$error");
      }
    } else {
      Get.back();
      Get.snackbar(
        'warning'.tr,
        'no_image_selected'.tr,
        snackPosition: SnackPosition.TOP,
        backgroundColor: redColor,
        colorText: whiteColor,
        duration: const Duration(seconds: 2),
      );
    }
  }

  Future<void> completeRegistrationProcess() async {
    DialogUtils.showLoading(title: 'wait_for_a_while'.tr);
    Map<String, dynamic> imagePathList = {
      "imagePaths": [
        {"image": frontFileName.toString()},
        {"image": leftFileName.toString()},
        {"image": rightFileName.toString()}
      ]
    };

    try {
      Response response = await (regiRepo!
          .uploadImagePathsToCompleteRegistration(imagePathList));

      if (response.statusCode == 201) {
        DialogUtils.closeLoading();
        clearImageFields();
        Get.offAllNamed(AppRoutes.homeScreen);
      }
    } catch (error) {
      DialogUtils.closeLoading();
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

  ///face detection function work flow

  //TODO declare variables
  late ImagePicker imagePicker;
  File? _image;

  //TODO declare detector
  late FaceDetector faceDetector;

  //TODO declare face recognizer
  late Recognizer recognizer;

  //TODO face detection code here
  List<Face> faces = [];
  Future<bool?> doFaceDetection(File imageFile) async {

    //TODO remove rotation of camera images
    InputImage inputImage = InputImage.fromFile(imageFile);

    image = await decodeImageFromList(imageFile.readAsBytesSync());

    //TODO passing input to face detector and getting detected faces
    faces = await faceDetector.processImage(inputImage);

    for (Face face in faces) {
      final Rect boundingBox = face.boundingBox;

      num left = boundingBox.left < 0 ? 0 : boundingBox.left;
      num top = boundingBox.top < 0 ? 0 : boundingBox.top;
      num right =
          boundingBox.right > image.width ? image.width - 1 : boundingBox.right;
      num bottom = boundingBox.bottom > image.width
          ? image.width - 1
          : boundingBox.bottom;

      num width = right - left;
      num height = bottom - top;

      ///crop image
      final bytes = imageFile.readAsBytesSync();
      img.Image? faceImage = img.decodeImage(bytes);
      img.Image croppedFace = img.copyCrop(faceImage!,
          x: left.toInt(),
          y: top.toInt(),
          width: width.toInt(),
          height: height.toInt());

      Recognition recognition = recognizer.recognize(croppedFace, boundingBox);

      Map<String, dynamic> faceVectorsBody = {
        "faceVector": "${recognition.embeddings}",
      };

      try {
        Response response =
            await (regiRepo!.uploadFaceVectors(faceVectorsBody));

        if (response.statusCode == 201) {
          return true;
        }
      } catch (error) {
        if (kDebugMode) {
          print('Error occurred : $error');
        }
      }
    }
    return null;
  }

  //TODO remove rotation of camera images
  removeRotation(File inputImage) async {
    final img.Image? capturedImage =
        img.decodeImage(await File(inputImage.path).readAsBytes());
    final img.Image orientedImage = img.bakeOrientation(capturedImage!);
    return await File(_image!.path).writeAsBytes(img.encodeJpg(orientedImage));
  }

  //TODO draw rectangles
  var image;
  drawRectangleAroundFaces(File imageSelected) async {
    image = await imageSelected.readAsBytes();
    image = await decodeImageFromList(image);

    if (kDebugMode) {
      print("${image.width}   ${image.height}");
    }
    image;
    faces;
    update();
  }
}
