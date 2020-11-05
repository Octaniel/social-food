
import 'dart:convert';

import 'package:socialfood/app/data/model/comentario.dart';
import 'package:socialfood/app/res/fatura_http.dart';
import 'package:socialfood/app/res/static.dart';

class ComentarioPrivider{
  final httpfat = FaturaHttp();

  Future<bool> salvar(Comentario comentario)async{
    final response =
    await httpfat.post("${url}comentario",headers: <String,String>{
      "Content-Type":"application/json"
    },body: json.encode(comentario.toMap()));
    if (response.statusCode == 201) {
      return true;
    } else {
      print("object");
      return false;
    }
  }

  Future<List<Comentario>> listar(int idVideo) async {
    final response =
    await httpfat.get("${url}comentario?idVideo=$idVideo",headers: <String,String>{
      "Content-Type":"application/json"
    });
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(utf8.decode(response.bodyBytes));
      var listUsuarioModel = jsonResponse.map<Comentario>((map) {
        return Comentario.fromMap(map);
      }).toList();
      return listUsuarioModel;
    } else {
      print(response.body);
      print("object");
    }
    return List<Comentario>();
  }

  Future<bool> apagar(int id) async {
      var response = await httpfat.delete("${url}comentario/$id");
      if (response.statusCode == 404) {
        return true;
      } else {
        print('erro -delete');
      }
    return false;
  }
}