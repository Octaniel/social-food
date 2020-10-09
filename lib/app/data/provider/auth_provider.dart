import 'dart:convert';

import 'package:cross_local_storage/cross_local_storage.dart';
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
        List jsonResponse = json.decode(decoder(response.body));
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
      var jsonResponse = json.decode(decoder(response.body));
      return Usuario.fromJson(jsonResponse);
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
      final storage = await LocalStorage.getInstance();
      var decode = jsonDecode(response.body);
      storage.setString("nomeUsuario", decode["nome"]);
      storage.setInt("idUsuario", decode["idUsuario"]);
      storage.setString("access_token", decode["access_token"]);
      storage.setString("date_expires_in", DateTime.now().toString());
      storage.setString("expires_in", decode["expires_in"].toString());
      storage.setString("refresh_token", decode["refresh_token"].toString());
      return true;
    }
    return false;
  }

  Future<bool> add(Usuario obj) async {
    var response = await httpClient.post('${baseUrl}usuario/add',
        headers: {'Content-Type': 'application/json'}, body: jsonEncode(obj));
    if (response.statusCode == 201) {
      return true;
    } else {
      print('erro -post');
    }
    return false;
  }

  Future<bool> logout() async {
    final httpfat = FaturaHttp();
    final storage = await LocalStorage.getInstance();
    var response = await httpfat.delete("${baseUrl}tokens/revoke");
    if (response.statusCode == 204) {
      await storage.clear();
      print(true);
      return true;
    }
//    await storage.clear();
    return false;
  }

  Future<bool> accsessTokenExpirado() async {
    final storage = await LocalStorage.getInstance();
    var read = storage.getString("date_expires_in");
    var read1 = storage.getString("expires_in");
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
    final storage = await LocalStorage.getInstance();
    var read1 = storage.getString("refresh_token");
    var response =
        await http.post("${baseUrl}oauth/token", headers: <String, String>{
      "Content-Type": "application/x-www-form-urlencoded",
      "Authorization": "Basic YW5ndWxhcjpAbmd1bEByMA==",
    }, body: <String, String>{
      "grant_type": "refresh_token",
      "refresh_token": read1 == null ? "" : read1
    });
    if (response.statusCode == 200) {
      var decode = jsonDecode(response.body);
      storage.setString("access_token", decode["access_token"]);
      storage.setString("date_expires_in", DateTime.now().toString());
      storage.setString("expires_in", decode["expires_in"].toString());
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
