import 'package:get/get.dart';
import 'package:socialfood/app/data/model/pessoa.dart';

import '../../app_controller.dart';

class Video {
  int id;
  String titulo;
  String subtitulo;
  String url;
  String thumbnail;
  bool permitirComentarios;
  Pessoa pessoa;
  List<Pessoa> listaDePessoasQueGostaram;
  bool voceGostou;

  Video(
      {this.id,
      this.titulo,
      this.subtitulo,
      this.url,
      this.thumbnail,
      this.permitirComentarios,
      this.pessoa,});

  Video.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    titulo = json['titulo'];
    subtitulo = json['subtitulo'];
    url = json['url'];
    thumbnail = json['thumbnail'];
    permitirComentarios = json['permitirComentarios'];
    pessoa = Pessoa.fromJson(json['pessoa']);
    listaDePessoasQueGostaram = (json['listaDePessoasQueGostaram'] as List==null?List():json['listaDePessoasQueGostaram'] as List).map((e) => Pessoa.fromJson(e)).toList();
    voceGostou = listaDePessoasQueGostaram.contains(Get.find<AppController>().usuario.pessoa);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['titulo'] = this.titulo;
    data['subTitulo'] = this.subtitulo;
    data['url'] = this.url;
    data['thumbnail'] = this.thumbnail;
    data['permitirComentarios'] = this.permitirComentarios;
    data['pessoa'] = pessoa.toJsonId();
    return data;
  }

  Map<String, dynamic> toJsonId() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    return data;
  }
}
