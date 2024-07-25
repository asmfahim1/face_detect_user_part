import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mict_final_project/core/utils/app_version.dart';
import 'package:mict_final_project/core/utils/dimensions.dart';
import 'package:mict_final_project/l10n/getx_localization.dart';
import 'package:mict_final_project/module/home/view/home_screen.dart';

import 'core/utils/app_routes.dart';
import 'core/utils/colors.dart';
import 'core/utils/dependencies.dart' as dep;
import 'core/utils/pref_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  await dep.init();
  initializeGet();
  runApp(const MyApp());
}

Future<void> initializeGet() async {
  await Get.putAsync(() async {
    return Dimensions(); // Initialize Dimensions class
  });
  await PrefHelper.init();
  await AppVersion.getVersion();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    return GetMaterialApp(
      title: 'user demo',
      debugShowCheckedModeBanner: false,
      //localization
      translations: Language(),
      locale: (PrefHelper.getLanguage() == 1)
          ? const Locale('en', 'US')
          : const Locale('bn', 'BD'),
      theme: ThemeData(
        progressIndicatorTheme:
            const ProgressIndicatorThemeData(color: primaryColor),
        appBarTheme: const AppBarTheme(
            backgroundColor: primaryColor, centerTitle: true, elevation: 0),
        scaffoldBackgroundColor: whiteColor,
        textTheme: GoogleFonts.poppinsTextTheme(),
        primaryColor: primaryColor,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        colorScheme:
            ThemeData().colorScheme.copyWith(secondary: secondaryColor),
      ),
      home: HomeScreen(),
      //initialRoute: AppRoutes.splashScreen,
      //getPages: AppRoutes.routes,
    );
  }
}
