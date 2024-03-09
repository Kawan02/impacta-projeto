import 'package:contatos/src/views/add_contato/controllers/add_contato_controller.dart';
import 'package:contatos/src/views/edit_contato/controllers/edit_contato_controller.dart';
import 'package:contatos/src/views/home/controllers/contatos_controller.dart';
import 'package:contatos/src/views/navigator/controllers/navigator_controller.dart';
import 'package:get/get.dart';

class DependecyInjection {
  static void init() {
    Get.lazyPut<NavigatorController>(() => NavigatorController(), fenix: true);
    Get.lazyPut<ContatosController>(() => ContatosController(), fenix: true);
    Get.lazyPut<EditContatoController>(() => EditContatoController(), fenix: true);
    Get.lazyPut<AddContatoController>(() => AddContatoController(), fenix: true);
  }
}
