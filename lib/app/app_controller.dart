import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:socialfood/app/data/repository/auth_repository.dart';

import 'data/model/usuario.dart';

class AppController extends GetxController {
  AppController(){
    refreshUsuario();
  }

  final repository = AuthRepository();

  var _usuario = Usuario().obs;

  Usuario get usuario => _usuario.value;

  set usuario(Usuario value) {
    _usuario.value = value;
  }

  var _caminho = '/home'.obs;

  get caminho => _caminho.value;

  set caminho(value) {
    _caminho.value = value;
    update();
  }

  Future<void> refreshUsuario() async {
    final storage = GetStorage();
    var id = storage.read('idUsuario');
    usuario = await repository.getId(id);
    update();
  }

  Future<bool> logout() async {
    usuario = Usuario();
    return await repository.logout();
  }

  @override
  void onClose() {
    print("object");
    super.onClose();
  }
}
  