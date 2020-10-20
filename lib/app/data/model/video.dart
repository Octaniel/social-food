import 'package:get/get.dart';
import 'package:socialfood/app/data/model/pessoa.dart';

import '../../app_controller.dart';

class Video {
  int id;
  String url;
  Pessoa pessoa;
  String descricao;
  List<Pessoa> listaDePessoasQueGostaram;
  bool voceGostou;
  DateTime dataPublicacao;

  Video(
      {this.id,
      this.url,
      this.pessoa,this.descricao});

  Video.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    url = json['url'];
    descricao = json['descricao'];
    pessoa = Pessoa.fromJson(json['pessoa']);
    dataPublicacao = DateTime.parse(json['dataCriacao']);
    listaDePessoasQueGostaram = (json['listaDePessoasQueGostaram'] as List==null?List():json['listaDePessoasQueGostaram'] as List).map((e) => Pessoa.fromJson(e)).toList();
    voceGostou = listaDePessoasQueGostaram.contains(Get.find<AppController>().usuario.pessoa);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['url'] = this.url;
    data['descricao'] = this.descricao;
    data['pessoa'] = pessoa.toJsonId();
    return data;
  }

  Map<String, dynamic> toJsonId() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    return data;
  }
}
