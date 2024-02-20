import 'package:app_contatos/src/services/network.dart';
import 'package:app_contatos/src/views/edit_contato/controllers/edit_contato_controller.dart';
import 'package:app_contatos/src/views/home/controllers/contatos_controller.dart';
import 'package:get/get.dart';

class DependecyInjection {
  static void init() {
    Get.put<NetworkController>(NetworkController(), permanent: true);
    Get.lazyPut<ContatosController>(() => ContatosController());
    Get.lazyPut<EditContatoController>(() => EditContatoController());
  }
}
