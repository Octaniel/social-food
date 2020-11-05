import 'dart:convert';

import 'package:socialfood/app/data/model/video.dart';
import 'package:socialfood/app/res/fatura_http.dart';
import 'package:socialfood/app/res/static.dart';

class VideoProvider{
  final httpfat = FaturaHttp();

  Future<List<Video>> listar(int page, String nome) async {
    final response =
    await httpfat.get("${url}video?page=$page&size=5&nome=$nome",headers: <String,String>{
      "Content-Type":"application/json"
    });
    if (response.statusCode == 200) {
      var decode = utf8.decode(response.bodyBytes);
      List jsonResponse = json.decode(decode);
      var listUsuarioModel = jsonResponse.map<Video>((map) {
        return Video.fromJson(map);
      }).toList();
      return listUsuarioModel;
    } else {
      print(response.body);
      print("object");
    }
    return List<Video>();
  }

  Future<List<Video>> listarQueGostei(int page, String nome) async {
    final response =
    await httpfat.get("${url}video/gostei?page=$page&size=5&nome=$nome",headers: <String,String>{
      "Content-Type":"application/json"
    });
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(utf8.decode(response.bodyBytes));
      var listUsuarioModel = jsonResponse.map<Video>((map) {
        return Video.fromJson(map);
      }).toList();
      return listUsuarioModel;
    } else {
      print(response.body);
      print("object");
    }
    return List<Video>();
  }

  Future<bool> salvar(Video video)async{
    final response =
    await httpfat.post("${url}video",headers: <String,String>{
      "Content-Type":"application/json"
    },body: json.encode(video.toJson()));
    if (response.statusCode == 201) {
      return true;
    } else {
      print("object");
      return false;
    }
  }

  Future<bool> atlauizar(Video video)async{
    final response =
    await httpfat.put("${url}video",headers: <String,String>{
      "Content-Type":"application/json"
    },body: json.encode(video.toJson()));
    if (response.statusCode == 200) {
      return true;
    } else {
      print("object");
      return false;
    }
  }
}