import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> init() async{
 final sharedPreferences = await SharedPreferences.getInstance();

 ///shared prefs
  Get.lazyPut(() => sharedPreferences, fenix: true);
}