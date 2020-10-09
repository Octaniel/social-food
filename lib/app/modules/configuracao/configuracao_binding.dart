import 'package:get/get.dart';

import 'controllers/configuracao_controller.dart';

class ConfiguracaoBinding extends Bindings{
  @override
  void dependencies() {
    Get.put<ConfiguracaoController>(ConfiguracaoController());
  }

}