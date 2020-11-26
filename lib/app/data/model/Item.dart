import 'package:socialfood/app/data/model/video.dart';

class Item {
  int id;
  Video video;
  String nome;
  String link;

  Item({this.id, this.link, this.video, this.nome});

  Item.fromJson1(Map<String, dynamic> json) {
    id = json['id'];
    nome = json['nome'];
    link = json['link'];
    video = Video.fromJson(json['video']);
  }

  Item.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nome = json['nome'];
    link = json['link'];
    // video = Video.fromJson(json['video']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nome'] = this.nome;
    data['link'] = this.link;
    return data;
  }
}
