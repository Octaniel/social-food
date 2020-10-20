import 'dart:convert';

import 'package:socialfood/app/data/model/video.dart';
import 'package:socialfood/app/res/fatura_http.dart';
import 'package:socialfood/app/res/static.dart';

class VideoProvider{
  final httpfat = FaturaHttp();

  Future<List<Video>> listar() async {
    final response =
    await httpfat.get("${url}video",headers: <String,String>{
      "Content-Type":"application/json"
    });
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(decoder(response.body));
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