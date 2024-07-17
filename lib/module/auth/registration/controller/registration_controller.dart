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
import 'package:mict_final_project/module/auth/registration/repo/regi_repo.dart';

class RegistrationController extends GetxController {
  RegiRepo? regiRepo;
  RegistrationController({this.regiRepo});

  @override
  void onInit() {
    super.onInit();
    imagePicker = ImagePicker();

    final options =
        FaceDetectorOptions(performanceMode: FaceDetectorMode.accurate);
    faceDetector = FaceDetector(options: options);

    recognizer = Recognizer();
  }

  PageController _pageController = PageController(initialPage: 0);
  int _activePage = 0;

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
      if (currentPage <= 5) {
        pageController.nextPage(
          duration: const Duration(milliseconds: 500),
          curve: Curves.ease,
        );
      }
    }
  }

  RxString selectedFrontImagePath = ''.obs;
  RxString frontFileName = ''.obs;
  RxList<double> frontFaceDestructor = <double>[].obs;

  Future<void> pickFrontImage(ImageSource source) async {
    try {
      final pickedImage = await ImagePicker().pickImage(source: source);
      if (pickedImage == null) {
        Get.back();
        DialogUtils.showNoImageTakenWarning();
        return;
      }

      String fileName = 'FrontImage${pickedImage.path.split('/').last}';
      final File imageFile = File(pickedImage.path);

      Get.back();
      DialogUtils.showLoading(title: 'uploading'.tr);

      frontFaceDestructor.clear();
      frontFaceDestructor.value = await doFaceDetection(imageFile);

      if (frontFaceDestructor.isEmpty) {
        DialogUtils.closeLoading();
        DialogUtils.showErrorDialog(
            description: 'no_face_found'.tr, btnName: 'try_again_btn'.tr);
        return;
      }

      final response = await regiRepo!.uploadFileWithDio(imageFile, fileName);
      DialogUtils.closeLoading();
      if (response["status"] == 201) {
        selectedFrontImagePath.value = pickedImage.path;
        frontFileName.value = '${response["imagePath"]}';
        changePage();
      } else {
        DialogUtils.showErrorDialog(
            description: 'upload_failed'.tr, btnName: 'try_again_btn'.tr);
      }
    } catch (error) {
      DialogUtils.closeLoading();
      DialogUtils.showErrorDialog(
          btnName: 'try_again_btn'.tr, description: "$error");
    }
  }

  RxString selectedRightImagePath = ''.obs;
  RxString rightFileName = ''.obs;
  RxList<double> rightFaceDestructor = <double>[].obs;

  Future<void> pickRightImage(ImageSource source) async {
    try {
      final pickedImage = await ImagePicker().pickImage(source: source);
      if (pickedImage == null) {
        Get.back();
        DialogUtils.showNoImageTakenWarning();
        return;
      }

      String fileName = 'RightImageImage${pickedImage.path.split('/').last}';
      final File imageFile = File(pickedImage.path);

      Get.back();
      DialogUtils.showLoading(title: 'uploading'.tr);

      rightFaceDestructor.clear();
      rightFaceDestructor.value = await doFaceDetection(imageFile);

      if (rightFaceDestructor.isEmpty) {
        DialogUtils.closeLoading();
        DialogUtils.showErrorDialog(
            description: 'no_face_found'.tr, btnName: 'try_again_btn'.tr);
        return;
      }

      final response = await regiRepo!.uploadFileWithDio(imageFile, fileName);
      DialogUtils.closeLoading();

      if (response["status"] == 201) {
        selectedRightImagePath.value = pickedImage.path;
        rightFileName.value = '${response["imagePath"]}';
        changePage();
      } else {
        DialogUtils.showErrorDialog(
            description: 'upload_failed'.tr, btnName: 'try_again_btn'.tr);
      }
    } catch (error) {
      DialogUtils.closeLoading();
      DialogUtils.showErrorDialog(
          btnName: 'try_again_btn'.tr, description: "$error");
    }
  }

  RxString selectedLeftImagePath = ''.obs;
  RxString leftFileName = ''.obs;
  RxList<double> leftFaceDestructor = <double>[].obs;

  Future<void> pickLeftImage(ImageSource source) async {
    try {
      final pickedImage = await ImagePicker().pickImage(source: source);
      if (pickedImage == null) {
        Get.back();
        DialogUtils.showNoImageTakenWarning();
        return;
      }

      String fileName = 'LeftImage${pickedImage.path.split('/').last}';
      final File imageFile = File(pickedImage.path);

      Get.back();
      DialogUtils.showLoading(title: 'uploading'.tr);

      leftFaceDestructor.clear();
      leftFaceDestructor.value = await doFaceDetection(imageFile);

      if (leftFaceDestructor.isEmpty) {
        DialogUtils.closeLoading();
        DialogUtils.showErrorDialog(
            description: 'no_face_found'.tr, btnName: 'try_again_btn'.tr);
        return;
      }

      final response = await regiRepo!.uploadFileWithDio(imageFile, fileName);
      DialogUtils.closeLoading();

      if (response["status"] == 201) {
        selectedLeftImagePath.value = pickedImage.path;
        leftFileName.value = '${response["imagePath"]}';
        changePage();
      } else {
        DialogUtils.showErrorDialog(
            description: 'upload_failed'.tr, btnName: 'try_again_btn'.tr);
      }
    } catch (error) {
      DialogUtils.closeLoading();
      DialogUtils.showErrorDialog(
          btnName: 'try_again_btn'.tr, description: "$error");
    }
  }

  RxString selectedSignatureImagePath = ''.obs;
  RxString signatureName = ''.obs;

  Future<void> pickSignatureImage(ImageSource source) async {
    try {
      final pickedImage = await ImagePicker().pickImage(source: source);
      if (pickedImage == null) {
        Get.back();
        DialogUtils.showNoImageTakenWarning();
        return;
      }

      String fileName = pickedImage.path.split('/').last;
      final File imageFile = File(pickedImage.path);

      Get.back();
      DialogUtils.showLoading(title: 'uploading'.tr);

      final response = await regiRepo!.uploadFileWithDio(imageFile, fileName);
      DialogUtils.closeLoading();

      if (response["status"] == 201) {
        selectedSignatureImagePath.value = pickedImage.path;
        signatureName.value = '${response["imagePath"]}';
        changePage();
      } else {
        DialogUtils.showErrorDialog(
            description: 'upload_failed'.tr, btnName: 'try_again_btn'.tr);
      }
    } catch (error) {
      DialogUtils.closeLoading();
      DialogUtils.showErrorDialog(
          btnName: 'try_again_btn'.tr, description: "$error");
    }
  }

  Future<void> completeRegistrationProcess() async {
    try {
      DialogUtils.showLoading(title: 'wait_for_a_while'.tr);
      Map<String, dynamic> registrationBody = {
        "face_vectors": [
          {
            "image_path": frontFileName.toString(),
            "vectors": frontFaceDestructor,
          },
          {
            "image_path": leftFileName.toString(),
            "vectors": frontFaceDestructor,
          },
          {
            "image_path": rightFileName.toString(),
            "vectors": frontFaceDestructor,
          }
        ],
        //"signature_image_path" : signatureName.toString()
      };

      Response response = await (regiRepo!
          .uploadImagePathsToCompleteRegistration(registrationBody));

      clearAllFieldsFields();

      if (response.statusCode == 201) {
        Get.offAllNamed(AppRoutes.homeScreen);
      } else {
        DialogUtils.showErrorDialog(
            description: 'upload_failed'.tr, btnName: 'try_again_btn'.tr);
      }
    } catch (error) {
      DialogUtils.closeLoading();
      DialogUtils.showErrorDialog(
          btnName: 'try_again_btn'.tr, description: "$error");
    }
  }

  void clearAllFieldsFields() {
    selectedFrontImagePath.value = '';
    selectedLeftImagePath.value = '';
    selectedRightImagePath.value = '';
    selectedSignatureImagePath.value = '';
    frontFaceDestructor.clear();
    rightFaceDestructor.clear();
    leftFaceDestructor.clear();
  }

  PageController get pageController => _pageController;

  int get activePage => _activePage;

  late ImagePicker imagePicker;
  File? _image;

  late FaceDetector faceDetector;

  late Recognizer recognizer;

  List<Face> faces = [];

  Future<List<double>> doFaceDetection(File imageFile) async {
    InputImage inputImage = InputImage.fromFile(imageFile);

    image = await decodeImageFromList(imageFile.readAsBytesSync());

    faces = await faceDetector.processImage(inputImage);

    if (faces.isNotEmpty) {
      for (Face face in faces) {
        final Rect boundingBox = face.boundingBox;

        num left = boundingBox.left < 0 ? 0 : boundingBox.left;
        num top = boundingBox.top < 0 ? 0 : boundingBox.top;
        num right = boundingBox.right > image.width
            ? image.width - 1
            : boundingBox.right;
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

        Recognition recognition =
            recognizer.recognize(croppedFace, boundingBox);

        return recognition.embeddings;
      }
    }
    return [];
  }

  removeRotation(File inputImage) async {
    final img.Image? capturedImage =
        img.decodeImage(await File(inputImage.path).readAsBytes());
    final img.Image orientedImage = img.bakeOrientation(capturedImage!);
    return await File(_image!.path).writeAsBytes(img.encodeJpg(orientedImage));
  }

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
