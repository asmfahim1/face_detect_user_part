import 'dart:convert';

import 'package:get/get.dart';
import 'package:mict_final_project/core/utils/const_key.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiClient extends GetConnect implements GetxService {
  late String token;
  final String appBaseUrl;
  late SharedPreferences sharedPreferences;
  late Map<String, String> _mainHeaders;
  late Map<String, String> _mainHeadersFileUpload;

  ApiClient({required this.appBaseUrl, required this.sharedPreferences}) {
    baseUrl = appBaseUrl;

    timeout = const Duration(seconds: 20);
    token = sharedPreferences.getString(AppConstantKey.TOKEN.key) ?? '';
    _mainHeaders = {
      'Context-type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
    };
    /*_mainHeadersFileUpload = {
      'Context-type': 'multipart/form-data; charset=UTF-8',
      'Authorization': 'Bearer $token',
    };*/
  }

  void updateHeader(String token) {
    _mainHeaders = {
      'Context-type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
    };
  }

  Future<Response> getData(String uri, {Map<String, String>? headers}) async {
    try {
      Response response =
          await get(Uri.encodeFull(uri), headers: headers ?? _mainHeaders);
      return response;
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  Future<Response> postData(String uri, dynamic body) async {
    try {
      Response response =
          await post(uri, jsonEncode(body), headers: _mainHeaders);

      print(response.body);
      return response;
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  Future<Response> putData(String uri, dynamic body) async {
    try {
      Response response =
          await put(uri, jsonEncode(body), headers: _mainHeaders);
      return response;
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

/*  Future<Response> uploadImage(String partialUrl, File imageFile) async {
    try {
      final url = _buildUrl(partialUrl);
      // Open the image file and read its content
      final bytes = await imageFile.readAsBytes();
      // Send a POST request with the image content as the request body
      final response = await post(
        url,
        bytes,
        headers: _mainHeaders,
        contentType:
            'image/jpg', // Adjust the content type based on your image type
      );
      return response;
    } catch (e) {
      print('Error uploading image: $e');
      rethrow;
    }
  }*/

/*  Future<Map<String, dynamic>> uploadFileWithDio(
      String uri, File file, String fileName) async {
    Map<String, dynamic> map = {};
    String completeUrl = '$baseUrl' '$uri';
    final request = dio.Dio();
    final formData = dio.FormData.fromMap({
      'file': await dio.MultipartFile.fromFile(file.path,
          filename: fileName, contentType: MediaType('image', 'jpg')),
    });

    final response = await request.postUri(
      Uri.parse('http://localhost:38784/file-upload,'),
      data: formData,
      */ /*options: dio.Options(
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer $token',
          HttpHeaders.contentTypeHeader: 'multipart/form-data; charset=UTF-8',
          HttpHeaders.contentLengthHeader: formData.length,
        },
      ),*/ /*
    );
    print(' response data : $response');
    map = response.data;
    print('map from response data : $map');
    return map;
  }*/
}
