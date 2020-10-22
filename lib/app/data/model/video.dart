import 'package:get/get.dart';
import 'package:socialfood/app/data/model/pessoa.dart';

import '../../app_controller.dart';
import 'Item.dart';

class Video {
  int id;
  String url;
  Pessoa pessoa;
  String descricao;
  String igredientes;
  String preparo;
  String canalLink;
  String pageLink;
  List<Pessoa> listaDePessoasQueGostaram;
  bool voceGostou;
  DateTime dataPublicacao;
  List<Item> itens;

  Video(
      {this.id,
      this.url,
      this.pessoa,this.descricao});

  Video.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    url = json['url'];
    descricao = json['descricao'];
    igredientes = json['igredientes'];
    preparo = json['preparo'];
    canalLink = json['canalLink'];
    pageLink = json['pageLink'];
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
    data['igredientes'] = this.igredientes;
    data['preparo'] = this.preparo;
    data['canalLink'] = this.canalLink;
    data['pageLink'] = this.pageLink;
    data['pessoa'] = pessoa.toJsonId();
    data['itens'] = itens!=null?itens.map((e) => e.toJson()).toList():null;
    return data;
  }

  Map<String, dynamic> toJsonId() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    return data;
  }
}
