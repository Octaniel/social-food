import 'package:socialfood/app/data/model/pessoa.dart';
import 'package:socialfood/app/data/model/video.dart';

class Gosto{
 IdGosto idGosto;


 Gosto({
     this.idGosto,
  });

  Map<String, dynamic> toMap() {
    return {
      'idGosto': this.idGosto.toMap(),
    };
  }
}
class IdGosto{
 Video video;
 Pessoa pessoa;

 IdGosto({
     this.video,
     this.pessoa,
  });

  factory IdGosto.fromMap(Map<String, dynamic> map) {
    return new IdGosto(
      video: Video.fromJson(map['video']),
      pessoa: Pessoa.fromJson(map['pessoa']),
    );
  }

 Map<String, dynamic> toMap() {
    return {
      'video': this.video.toJsonId(),
      'pessoa': this.pessoa.toJsonId(),
    };
  }
}