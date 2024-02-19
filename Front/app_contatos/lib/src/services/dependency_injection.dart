import 'package:app_contatos/src/services/network.dart';
import 'package:get/get.dart';

class DependecyInjection {
  static void init() {
    Get.put<NetworkController>(NetworkController(), permanent: true);
    // Get.put(HomeController());
  }
}
