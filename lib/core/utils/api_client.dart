import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'package:http_parser/http_parser.dart';
import 'package:mict_final_project/core/utils/const_key.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiClient extends GetConnect implements GetxService {
  late String token;
  final String appBaseUrl;
  late SharedPreferences sharedPreferences;
  late Map<String, String> _mainHeaders;

  ApiClient({required this.appBaseUrl, required this.sharedPreferences}) {
    baseUrl = appBaseUrl;

    timeout = const Duration(seconds: 20);
    token = sharedPreferences.getString(AppConstantKey.TOKEN.key) ?? '';
    _mainHeaders = {
      'Context-type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
    };
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

Future<Map<String, dynamic>> uploadFileWithDio(
      String uri, File file, String fileName) async {
    Map<String, dynamic> map = {};
    String completeUrl = '$baseUrl' '$uri';
    final request = dio.Dio();
    final formData = dio.FormData.fromMap({
      'file': await dio.MultipartFile.fromFile(file.path,
          filename: fileName, contentType: MediaType('application', 'pdf')),
    });

    final response = await request.postUri(
      Uri.parse(
        completeUrl,
      ),
      data: formData,
      options: dio.Options(
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer $token',
          HttpHeaders.contentTypeHeader: 'multipart/form-data; charset=UTF-8',
          HttpHeaders.contentLengthHeader: formData.length,
        },
      ),
    );
    map = response.data;
    print('map from response data : $map');
    return map;
  }

/* //Download pdf file
  Future<String> _getDownloadPath() async {
    Directory? downloadsDirectory;
    if (Platform.isAndroid) {
      if (await Permission.storage.request().isGranted) {
        downloadsDirectory = await getExternalStorageDirectory();
      } else {
        throw Exception('Storage permission not granted');
      }
    } else if (Platform.isIOS) {
      downloadsDirectory = await getApplicationDocumentsDirectory();
    }
    if (downloadsDirectory == null) {
      throw Exception('Could not access download directory');
    }
    return downloadsDirectory.path;
  }

  Future<Map<String, dynamic>> downloadPDF(
      String uri, Function(double) onProgress) async {
    final request = dio.Dio();
    String completeUrl = '$baseUrl' '$uri';
    Map<String, dynamic> map = {};
    String downloadPath = await _getDownloadPath();
    String filePath = '$downloadPath/flutter-succinctly.pdf';
    final response = await request.download(
        'https://cdn.syncfusion.com/content/PDFViewer/flutter-succinctly.pdf',
        filePath, onReceiveProgress: (received, total) {
      if (total != -1) {
        onProgress((received / total) * 100);
      }
    });
    print('-------${response.data}${response.statusCode}---------');
    map = response.data;
    print('map from response data : $map');
    return map;
  }*/
}
