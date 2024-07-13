import 'package:flutter/foundation.dart';
import 'package:mict_final_project/core/utils/const_key.dart';
import 'package:mict_final_project/core/utils/pref_helper.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AppVersion {
  static String currentVersion = "";
  static String versionCode = "";
  static Future<void> getVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    currentVersion = packageInfo.version;
    versionCode = packageInfo.buildNumber;
    await PrefHelper.setString(AppConstantKey.APP_VERSION.key, currentVersion);
    await PrefHelper.setString(AppConstantKey.BUILD_NUMBER.key, versionCode);

    if (kDebugMode) {
      print('Current version is  ${currentVersion.toString()}');
      print('App version Code is  ${versionCode.toString()}');
    }

  }
}


