import 'package:get/get.dart';
import 'package:mict_final_project/module/auth/login/view/get_started_screen.dart';
import 'package:mict_final_project/module/auth/login/view/splash_screen.dart';
import 'package:mict_final_project/module/auth/registration/view/registration_screen.dart';

import '../../module/auth/login/view/login_screen.dart';
import '../../module/home/view/home_screen.dart';

class AppRoutes {
  static const splashScreen = '/splash_screen';
  static const getStartedScreen = '/get_started_screen';

  //Auth
  static const loginScreen = '/login_page';
  static const registrationPage = '/registration_page';

  static const homeScreen = '/home_page';

  static List<GetPage> routes = [
    GetPage(
      name: splashScreen,
      transition: Transition.cupertino,
      page: () => const SplashScreen(),
    ),
    GetPage(
      name: getStartedScreen,
      transition: Transition.cupertino,
      page: () => const GetStartedScreen(),
    ),
    GetPage(
      name: loginScreen,
      transition: Transition.noTransition,
      page: () => const LoginScreen(),
    ),
    GetPage(
      name: registrationPage,
      transition: Transition.noTransition,
      page: () => const RegistrationScreen(),
    ),
    GetPage(
      name: homeScreen,
      transition: Transition.noTransition,
      page: () => const HomeScreen(),
    ),
  ];
}
