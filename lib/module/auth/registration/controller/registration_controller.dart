import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image/image.dart' as img;
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mict_final_project/core/ML/Recognition.dart';
import 'package:mict_final_project/core/ML/Recognizer.dart';
import 'package:mict_final_project/core/utils/app_routes.dart';
import 'package:mict_final_project/core/utils/dialogue_utils.dart';
import 'package:mict_final_project/core/utils/exports.dart';
import 'package:mict_final_project/core/utils/extensions.dart';
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

    final options = FaceDetectorOptions(performanceMode: FaceDetectorMode.accurate);
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

  /*File? _firstImageFile;
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
  }*/

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
      if (currentPage < 3 - 1) {
        // Not the last page, proceed to the next page
        pageController.nextPage(
          duration: const Duration(milliseconds: 500),
          curve: Curves.ease,
        );
      } else {
        // Last page, navigate to home page
        Get.offAllNamed(AppRoutes.homeScreen); // Adjust route as needed
      }
    }
  }

  final RxString frontFileName = ''.obs;
  RxBool isFileUploaded = false.obs;
  Future<void> pickFrontImage(ImageSource source) async {
    print('test 1');
    final pickedImage = await ImagePicker().pickImage(source: source);
    if (pickedImage != null) {
      print('test 2');
      selectedFrontImagePath.value = pickedImage.path;
      frontFileName.value = pickedImage.path.split('/').last;
      final File imageFile = File(selectedFrontImagePath.value);
      isFileUploaded(true);
      DialogUtils.showLoading();
      try {
        print('test 3');
        Map<String, dynamic> response = await regiRepo!.uploadFileWithDio(imageFile, frontFileName.value);
        print('response : $response');
        if (response["statusCode"] == 200) {
          //selectedPdfFileList[index] = response["name"];
          print('test 1=================$response');
        } else {
          print('test 2=================$response');
        }
        print('test 4');
        Get.back();
        Get.back();
        isFileUploaded(false);
      } catch (error) {
        print('test 5 $error');
        Get.back();
        Get.back();
        isFileUploaded(false);
      }
      //await uploadData(selectedFrontImagePath.value, 'http://localhost:8000/file-upload');
    } else {
      print('test 6');
      Get.back();
      Get.snackbar(
        'Warning!',
        'No image selected from device',
        snackPosition: SnackPosition.TOP,
        backgroundColor: redColor,
        colorText: whiteColor,
        duration: const Duration(seconds: 2),
      );
    }
  }

  Future<void> pickRightImage(ImageSource source) async {
    final pickedImage = await ImagePicker().pickImage(source: source);
    if (pickedImage != null) {
      selectedRightImagePath.value = pickedImage.path;
      selectedRightImageSize.value =
          '${((File(selectedRightImagePath.value)).lengthSync() / 1024 / 1024).toStringAsFixed(2)} MB';
      // await uploadSelectedImage(selectedRightImagePath.value);
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

  Future<void> pickLeftImage(ImageSource source) async {
    final pickedImage = await ImagePicker().pickImage(source: source);
    if (pickedImage != null) {
      selectedLeftImagePath.value = pickedImage.path;
      selectedLeftImageSize.value =
          '${((File(selectedLeftImagePath.value)).lengthSync() / 1024 / 1024).toStringAsFixed(2)} MB';
      // await uploadSelectedImage(selectedLeftImagePath.value);
      Get.back();
      "the size of the image is: $selectedLeftImageSize".log();
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
      selectedSignatureImageSize.value =
          '${((File(selectedSignatureImagePath.value)).lengthSync() / 1024 / 1024).toStringAsFixed(2)} MB';
      //await uploadSelectedImage(selectedSignatureImagePath.value);
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

  /*Future<void> uploadSelectedImage(String imagePath) async {
    DialogUtils.showLoading(title: 'uploading photo...');
    try {
      final File imageFile = File(imagePath);
      final response = await apiClient.uploadFileWithDio(
          AppConstants.fileUpload, imageFile, frontFileName.value);
      print('response : $response');
      if (response.statusCode == 200) {
        hideLoading();
        DialogUtils.showSnackBar('Successful', 'Image uploaded successfully');
        changePage();
      } else {
        hideLoading();
        DialogUtils.showSnackBar('Error', 'Failed to upload, please try again',
            bgColor: redColor);
        print('Error uploading image: ${response.statusCode}');
      }
    } catch (e) {
      hideLoading();
      DialogUtils.showErrorDialog(
        title: 'Error',
        description:
            'Network issue! Make sure you have stable internet connection',
      );
      print('Error uploading image: $e');
    }
  }*/

/*  Future uploadData(imageFilePath, url) async {
    var request = http.MultipartRequest('POST', Uri.parse(url));

    await http.MultipartFile.fromPath(
      'image',
      imageFilePath,
      filename: 'image.jpg',
    );
    request.fields['fileName'] = 'fahim';
    request.fields['own_id'] = 'fahim';

    var res = await request.send();
    print('statusCode : ${res.statusCode}');
    return res.statusCode;
  }*/

  void hideLoading() {
    Get.back();
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


  //TODO capture image using camera
  _imgFromCamera() async {
    XFile? pickedFile = await imagePicker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      _image = File(pickedFile.path);
      doFaceDetection();
      update();
    }
  }

  //TODO choose image using gallery
  _imgFromGallery() async {
    XFile? pickedFile =
    await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      _image = File(pickedFile.path);
      doFaceDetection();
      update();
    }
  }

  //TODO face detection code here
  List<Face> faces = [];
  doFaceDetection() async {
    //TODO remove rotation of camera images
    InputImage inputImage = InputImage.fromFile(_image!);

    //image = await _image?.readAsBytes();
    image = await decodeImageFromList(_image!.readAsBytesSync());

    //TODO passing input to face detector and getting detected faces
    faces = await faceDetector.processImage(inputImage);

    for (Face face in faces){
      final Rect  boundingBox = face.boundingBox;
      print('locate face in image : $boundingBox');


      num left = boundingBox.left < 0 ? 0 : boundingBox.left;
      num top = boundingBox.top < 0 ? 0 : boundingBox.top;
      num right = boundingBox.right > image.width ? image.width -1 : boundingBox.right;
      num bottom = boundingBox.bottom > image.width ? image.width -1 : boundingBox.bottom;

      num width = right - left ;
      num height = bottom - top ;


      //crop image
      final bytes =  _image!.readAsBytesSync();
      img.Image? faceImage = img.decodeImage(bytes);
      img.Image croppedFace =  img.copyCrop(faceImage!, x: left.toInt(), y: top.toInt(), width: width.toInt(), height: height.toInt());

      Recognition recognition = recognizer.recognize(croppedFace, boundingBox);
      recognizer.registerFaceInDB(textEditingController.text, recognition.embeddings);
      //showFaceRegistrationDialogue(Uint8List.fromList(img.encodeBmp(croppedFace)), recognition);


    }

    drawRectangleAroundFaces();


    //TODO call the method to perform face recognition on detected faces
  }

  //TODO remove rotation of camera images
  removeRotation(File inputImage) async {
    final img.Image? capturedImage = img.decodeImage(await File(inputImage.path).readAsBytes());
    final img.Image orientedImage = img.bakeOrientation(capturedImage!);
    return await File(_image!.path).writeAsBytes(img.encodeJpg(orientedImage));
  }

  //TODO perform Face Recognition

  //TODO Face Registration Dialogue
  TextEditingController textEditingController = TextEditingController();
/*  showFaceRegistrationDialogue(Uint8List cropedFace, Recognition recognition){
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Face Registration",textAlign: TextAlign.center),alignment: Alignment.center,
        content: SizedBox(
          height: 340,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20,),
              Image.memory(
                cropedFace,
                width: 200,
                height: 200,
              ),
              SizedBox(
                width: 200,
                child: TextField(
                    controller: textEditingController,
                    decoration: const InputDecoration( fillColor: Colors.white, filled: true,hintText: "Enter Name")
                ),
              ),
              const SizedBox(height: 10,),
              ElevatedButton(
                  onPressed: () {
                    recognizer.registerFaceInDB(textEditingController.text, recognition.embeddings);
                    // print('face embeddings============= : ${recognition.embeddings}');
                    textEditingController.text = "";
                    Get.back();
                    Get.snackbar('Successful', 'Face Registered',);
                  },style: ElevatedButton.styleFrom(backgroundColor:Colors.blue,minimumSize: const Size(200,40)),
                  child: const Text("Register"))
            ],
          ),
        ),contentPadding: EdgeInsets.zero,
      ),
    );
  }*/
  //TODO draw rectangles
  var image;
  drawRectangleAroundFaces() async {
    image = await _image?.readAsBytes();
    image = await decodeImageFromList(image);
    print("${image.width}   ${image.height}");
    image;
    faces;
    update();
  }

















/*  File? get firstImageFile => _firstImageFile;
  File? get secondImageFile => _secondImageFile;
  File? get thirdImageFile => _thirdImageFile;
  File? get fourImageFile => _fourImageFile;*/
}
