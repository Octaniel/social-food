import 'dart:convert';

import 'package:socialfood/app/data/model/gosto.dart';
import 'package:socialfood/app/res/fatura_http.dart';
import 'package:socialfood/app/res/static.dart';

class GostoProvider{
  final httpfat = FaturaHttp();

  Future<bool> salvar(Gosto gosto)async{
    final response =
    await httpfat.post("${url}gosto",headers: <String,String>{
      "Content-Type":"application/json"
    },body: json.encode(gosto.toMap()));
    if (response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }
}