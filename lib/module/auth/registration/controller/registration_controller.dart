import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';
import 'package:mict_final_project/core/ML/Recognition.dart';
import 'package:mict_final_project/core/ML/Recognizer.dart';
import 'package:mict_final_project/core/utils/app_routes.dart';
import 'package:mict_final_project/core/utils/dialogue_utils.dart';
import 'package:mict_final_project/module/auth/registration/repo/regi_repo.dart';
import 'package:path_provider/path_provider.dart';

class RegistrationController extends GetxController {
  RegiRepo? regiRepo;
  RegistrationController({this.regiRepo});

  @override
  void onInit() {
    super.onInit();
    imagePicker = ImagePicker();

    final options = FaceDetectorOptions(performanceMode: FaceDetectorMode.accurate);
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

      final File imageFile = File(pickedImage.path);
      String fileName = 'FrontImage${pickedImage.path.split('/').last}';

      Get.back();
      DialogUtils.showLoading(title: 'uploading'.tr);

      frontFaceDestructor.clear();
      frontFaceDestructor.value = await doFaceDetection(imageFile);

      if (frontFaceDestructor.isEmpty) {
        DialogUtils.closeLoading();
        DialogUtils.showErrorDialog(description: 'no_face_found'.tr, btnName: 'try_again_btn'.tr);
        return;
      }

      final File? compressedFile = await adaptiveCompressImage(imageFile.path);

      if (compressedFile == null) {
        DialogUtils.closeLoading();
        DialogUtils.showErrorDialog(description: 'Compression failed', btnName: 'try_again_btn'.tr);
        return;
      }

      // final response = await regiRepo!.uploadFileWithDio(imageFile, fileName);
      final response = await regiRepo!.uploadFileWithDio(compressedFile, fileName);

      DialogUtils.closeLoading();
      if (response["status"] == 201) {
        selectedFrontImagePath.value = imageFile.path;
        frontFileName.value = '${response["imagePath"]}';
        changePage();
      } else {
        DialogUtils.showErrorDialog(
            description: "${response["error"]}", btnName: 'try_again_btn'.tr);
      }
    } catch (error) {
      DialogUtils.closeLoading();
      DialogUtils.showErrorDialog(btnName: 'try_again_btn'.tr, description: "$error ==");
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

      final File imageFile = File(pickedImage.path);
      String fileName = 'RightImage${pickedImage.path.split('/').last}';

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

      final File? compressedFile = await adaptiveCompressImage(imageFile.path);

      if (compressedFile == null) {
        DialogUtils.closeLoading();
        DialogUtils.showErrorDialog(description: 'Compression failed', btnName: 'try_again_btn'.tr);
        return;
      }

      final response = await regiRepo!.uploadFileWithDio(compressedFile, fileName);

      DialogUtils.closeLoading();

      if (response["status"] == 201) {
        selectedRightImagePath.value = imageFile.path;
        rightFileName.value = '${response["imagePath"]}';
        changePage();
      } else {
        DialogUtils.showErrorDialog(
            description: "${response["error"]}", btnName: 'try_again_btn'.tr);
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

      final File imageFile = File(pickedImage.path);
      String fileName = 'LeftImage${pickedImage.path.split('/').last}';

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
      final File? compressedFile = await adaptiveCompressImage(imageFile.path);

      if (compressedFile == null) {
        DialogUtils.closeLoading();
        DialogUtils.showErrorDialog(description: 'Compression failed', btnName: 'try_again_btn'.tr);
        return;
      }

      // final response = await regiRepo!.uploadFileWithDio(imageFile, fileName);
      final response = await regiRepo!.uploadFileWithDio(compressedFile, fileName);


      DialogUtils.closeLoading();

      if (response["status"] == 201) {
        selectedLeftImagePath.value = pickedImage.path;
        leftFileName.value = '${response["imagePath"]}';
        changePage();
      } else {
        DialogUtils.showErrorDialog(
            description: "${response["message"]}", btnName: 'try_again_btn'.tr);
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

      final File? compressedFile = await adaptiveCompressImage(imageFile.path);

      if (compressedFile == null) {
        DialogUtils.closeLoading();
        DialogUtils.showErrorDialog(description: 'Compression failed', btnName: 'try_again_btn'.tr);
        return;
      }

      final response = await regiRepo!.uploadFileWithDio(compressedFile, fileName);
      DialogUtils.closeLoading();

      if (response["status"] == 201) {
        selectedSignatureImagePath.value = imageFile.path;
        signatureName.value = '${response["imagePath"]}';
        changePage();
      } else {
        DialogUtils.showErrorDialog(
            description: "${response["error"]}", btnName: 'try_again_btn'.tr);
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
        "images": [
          {
            "image": frontFileName.toString(),
            "faceVector": frontFaceDestructor,
          },
          {
            "image": leftFileName.toString(),
            "faceVector": leftFaceDestructor,
          },
          {
            "image": rightFileName.toString(),
            "faceVector": rightFaceDestructor,
          }
        ],
        //"signature_image_path" : signatureName.toString()
      };

      Response response = await (regiRepo!
          .uploadImagePathsToCompleteRegistration(registrationBody));

      DialogUtils.closeLoading();


      if (response.statusCode == 201) {
        Get.offAllNamed(AppRoutes.homeScreen);
        clearAllFieldsFields();
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

  Future<File?> adaptiveCompressImage(String path, {int targetWidth = 600, int jpegQuality = 60}) async {
    try {
      final originalBytes = await File(path).readAsBytes();
      final originalImage = img.decodeImage(originalBytes);

      if (originalImage == null) {
        print("Invalid image data");
        return null;
      }

      // Resize while maintaining aspect ratio
      img.Image resizedImage = img.copyResize(
        originalImage,
        width: targetWidth,
      );

      // Compress directly at fixed quality
      final compressedBytes = img.encodeJpg(resizedImage, quality: jpegQuality);

      // Save compressed image to temp directory
      final tempDir = await getTemporaryDirectory();
      final compressedFile = File('${tempDir.path}/compressed_${DateTime.now().millisecondsSinceEpoch}.jpg');
      await compressedFile.writeAsBytes(compressedBytes);

      print("Compressed file size: ${compressedBytes.length} bytes (${compressedBytes.length / 1024} KB)");
      return compressedFile;
    } catch (e) {
      print("Compression error: $e");
      return null;
    }
  }
  Future<File> getTempFile(String path) async {
    Directory tempDir = await getTemporaryDirectory();
    return await File("${tempDir.path}/upload${DateTime
        .now()
        .millisecondsSinceEpoch}.${path
        .split('.')
        .last}").create();
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
