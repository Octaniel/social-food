import 'package:socialfood/app/data/model/pessoa.dart';
import 'package:socialfood/app/data/model/video.dart';

class Comentario {
  int id;
  Video video;
  Pessoa pessoa;
  String texto;

  Comentario({
    this.id,
    this.video,
    this.pessoa,
    this.texto,
  });

  factory Comentario.fromMap(Map<String, dynamic> map) {
    return new Comentario(
      id: map['id'] as int,
      video: Video.fromJson(map['video']),
      pessoa: Pessoa.fromJson(map['pessoa']),
      texto: map['texto'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'video': this.video.toJsonId(),
      'pessoa': this.pessoa.toJsonId(),
      'texto': this.texto,
    };
  }
}
