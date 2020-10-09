import 'package:get/get.dart';

import 'controllers/favorito_controller.dart';

class FavoritoBinding extends Bindings{
  @override
  void dependencies() {
    Get.put<FavoritoController>(FavoritoController());
  }

}