import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:mict_final_project/core/utils/app_constants.dart';

class ApiClient extends GetConnect implements GetxService {
  String? token;
  late Map<String, String> _mainHeaders;

  ApiClient() {
    timeout = const Duration(seconds: 20);
    _mainHeaders = {
      'Context-type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer ${token ?? ''}',
    };
  }

  String _buildUrl(String partialUrl) {
    final baseUrl = AppConstants.baseUrl;
    return baseUrl + partialUrl;
  }

  void updateHeader(String token) {
    _mainHeaders = {
      'Context-type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
    };
  }

  Future<Response> getData(String uri, {Map<String, String>? headers}) async {
    try {
      final completeUrl = _buildUrl(uri);
      Response response = await get(Uri.encodeFull(completeUrl),
          headers: headers ?? _mainHeaders);
      return response;
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  Future<Response> postData(String uri, dynamic body) async {
    try {
      final completeUrl = _buildUrl(uri);
      Response response =
          await post(completeUrl, jsonEncode(body), headers: _mainHeaders);
      return response;
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  Future<Response> putData(String uri, dynamic body) async {
    try {
      final completeUrl = _buildUrl(uri);
      Response response =
          await put(uri, jsonEncode(completeUrl), headers: _mainHeaders);
      return response;
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  Future<Response> patchData(String uri, dynamic body) async {
    try {
      final completeUrl = _buildUrl(uri);
      Response response =
          await patch(completeUrl, jsonEncode(body), headers: _mainHeaders);
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

  Future<http.StreamedResponse> uploadImage(
      String partialUrl, File image) async {
    final url = _buildUrl(partialUrl);
    print('the complete url is : $url');
    var stream = http.ByteStream(image.openRead());
    stream.cast();

    var length = await image.length();

    //var uri = Uri.parse(url);
    var uri = Uri.parse('https://fakestoreapi.com/products');

    var request = http.MultipartRequest('POST', uri);

    request.fields['title'] = "Static title";

    var multiport = http.MultipartFile('image', stream, length);

    request.files.add(multiport);

    var response = await request.send();

    print(response.stream.toString());

    return response;
  }
}
