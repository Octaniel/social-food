import 'dart:convert';

import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:socialfood/app/data/model/usuario.dart';
import 'package:socialfood/app/res/fatura_http.dart';
import 'package:socialfood/app/res/static.dart';

final baseUrl = url;

class AuthProvider {
  final httpClient = http.Client();

  Future<List<Usuario>> getAll() async {
    try {
      var response = await httpClient.get(baseUrl + 'home');
      if (response.statusCode == 200) {
        List jsonResponse = json.decode(utf8.decode(response.bodyBytes));
        var listUsuario = jsonResponse.map<Usuario>((map) {
          return Usuario.fromJson(map);
        }).toList();
        return listUsuario;
      } else {
        print('erro -get');
      }
    } catch (_) {}
    return [];
  }

  Future<Usuario> getId(int id) async {
    var response = await FaturaHttp().get('${url}usuario/$id',
        headers: <String, String>{"Content-Type": "application/json"});
    if (response.statusCode == 200) {
      var jsonResponse = json.decode(utf8.decode(response.bodyBytes));
      return Usuario.fromJson(jsonResponse);
    } else {
      print('erro -get');
    }
    return null;
  }

  Future<List<Map<String, Object>>> listarUsuarioDtoParaGrafico() async {
    var response = await FaturaHttp().get(
        '${url}usuario/listarUsuarioDtoParaGrafico',
        headers: <String, String>{"Content-Type": "application/json"});
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(utf8.decode(response.bodyBytes));
      var listUsuarioModel = jsonResponse.map<Map<String, Object>>((map) {
        return {'quntidade': map['quntidade'], 'mes': map['mes']};
      }).toList();
      return listUsuarioModel;
    } else {
      print('erro -get');
    }
    return null;
  }

  Future<int> getCount() async {
    var response = await FaturaHttp().get('${url}usuario/quntidadeUsuario',
        headers: <String, String>{"Content-Type": "application/json"});
    if (response.statusCode == 200) {
      return int.parse(response.body);
    } else {
      print('erro -get');
    }
    return null;
  }

  Future<int> getCountUltimo30Dias() async {
    var response = await FaturaHttp().get(
        '${url}usuario/quntidadeUsuarioUltimo30Dias',
        headers: <String, String>{"Content-Type": "application/json"});
    if (response.statusCode == 200) {
      return int.parse(response.body);
    } else {
      print('erro -get');
    }
    return null;
  }

  Future<bool> login(String senha, String email) async {
    String login = "username=$email&password=$senha&grant_type=password";
    final response = await http.post("${baseUrl}oauth/token",
        headers: <String, String>{
          "Content-Type": "application/x-www-form-urlencoded",
          "Authorization": "Basic YW5ndWxhcjpAbmd1bEByMA==",
          "bmobile": " ",
        },
        body: login);
    if (response.statusCode == 200) {
      final storage = GetStorage();
      var decode = json.decode(utf8.decode(response.bodyBytes));
      storage.write("nomeUsuario", decode["nome"]);
      storage.write("idUsuario", decode["idUsuario"]);
      storage.write("access_token", decode["access_token"]);
      storage.write("date_expires_in", DateTime.now().toString());
      storage.write("expires_in", decode["expires_in"].toString());
      storage.write("refresh_token", decode["refresh_token"].toString());
      return true;
    }
    return false;
  }

  Future<List> add(Usuario obj) async {
    var response = await httpClient.post('${baseUrl}usuario/add',
        headers: {'Content-Type': 'application/json'}, body: jsonEncode(obj));
    if (response.statusCode == 201) {
      var list = List();
      list.insert(0, true);
      list.insert(1, 'Registrado(a) com sucesso');
      return list;
    } else if (response.statusCode == 409) {
      var list = List();
      list.insert(0, false);
      list.insert(1, 'Este E-mail já esta sendo utilizado por outra pessoa');
      return list;
    } else {
      var list = List();
      list.insert(0, false);
      list.insert(1, 'Erro ao registrar');
      return list;
    }
  }

  Future<bool> logout() async {
    final httpfat = FaturaHttp();
    final storage = GetStorage();
    var response = await httpfat.delete("${baseUrl}tokens/revoke");
    if (response.statusCode == 204) {
      await storage.erase();
      // await storage.setBool("removido", true);
      // await storage.reload();
      print(true);
      return true;
    }
//    await storage.clear();
    return false;
  }

  Future<bool> accsessTokenExpirado() async {
    final storage = GetStorage();
    var read = storage.read("date_expires_in");
    var read1 = storage.read("expires_in");
    if (read == null) return true;
    var date = DateTime.parse(read);
    int i = int.parse(read1);
    date = date.add(Duration(seconds: i));
    if (date.isAfter(DateTime.now())) {
      return false;
    }
    return true;
  }

  Future<void> refreshToken() async {
    final storage = GetStorage();
    var read1 = storage.read("refresh_token");
    var response =
        await http.post("${baseUrl}oauth/token", headers: <String, String>{
      "Content-Type": "application/x-www-form-urlencoded",
      "Authorization": "Basic YW5ndWxhcjpAbmd1bEByMA==",
    }, body: <String, String>{
      "grant_type": "refresh_token",
      "refresh_token": read1 == null ? "" : read1
    });
    if (response.statusCode == 200) {
      var decode = json.decode(utf8.decode(response.bodyBytes));
      storage.write("access_token", decode["access_token"]);
      storage.write("date_expires_in", DateTime.now().toString());
      storage.write("expires_in", decode["expires_in"].toString());
    }
  }

  Future<bool> verificarERenovarToken() async {
    if (await accsessTokenExpirado()) {
      await refreshToken();
      if (await accsessTokenExpirado()) {
        return false;
      }
    }
    return true;
  }

  Future<bool> edit(Usuario obj) async {
    try {
      var response = await httpClient.put(baseUrl,
          headers: {'Content-Type': 'application/json'}, body: jsonEncode(obj));
      if (response.statusCode == 200) {
        return true;
      } else {
        print('erro -put');
      }
    } catch (_) {}
    return false;
  }

  Future<bool> delete(int id) async {
    try {
      var response = await httpClient.delete(baseUrl);
      if (response.statusCode == 200) {
        return true;
      } else {
        print('erro -delete');
      }
    } catch (_) {}
    return false;
  }
}
