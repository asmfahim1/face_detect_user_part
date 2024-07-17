import 'package:get/get.dart';
import 'package:mict_final_project/module/home/repo/home_repo.dart';

class HomeController extends GetxController {
  final HomeRepo? homeRepo;
  HomeController({this.homeRepo});

  RxMap userInfo = {}.obs;

  void getUserData() async {
    userInfo.value = (await homeRepo!.getUserInfo()) as RxMap;
    print("============${userInfo}");
  }
}
