import 'package:socialfood/app/data/model/video.dart';

class Item {
  int id;
  Video video;
  String nome;

  Item({this.id, this.video, this.nome});

  Item.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nome = json['nome'];
    video = Video.fromJson(json['video']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nome'] = this.nome;
    return data;
  }
}
