import 'package:get/get.dart';
import 'package:socialfood/app/data/model/pessoa.dart';
import 'package:socialfood/app/data/model/usuario.dart';
import 'package:socialfood/app/data/repository/auth_repository.dart';

class AuthController extends GetxController{
  final repository = AuthRepository();

  var pessoa = Pessoa();
  var usuario = Usuario();
  final _carregando = false.obs;

  get carregando => _carregando.value;

  set carregando(value) {
    _carregando.value = value;
    update();
  }

  var _senha = ''.obs;
  var _email = ''.obs;

  String get senha => _senha.value;

  set senha(value) {
    _senha.value = value;
  }

  Future<bool> logar() async {
   return await repository.login(senha, email);
  }

  get email => _email.value;

  set email(value) {
    _email.value = value;
  }

  Future<bool> salvarUsuario() async {
    usuario.pessoa = pessoa;
    usuario.nome = pessoa.nome.toLowerCase().trim();
   return await repository.add(usuario);
  }

  bool get isValidLogin{
    if(!GetUtils.isEmail(email)||senha.length<6){
      return false;
    }
    return true;
  }


}
