import 'package:socialfood/app/data/model/comentario.dart';
import 'package:socialfood/app/data/provider/comentario_provider.dart';

class ComentarioRepository{
  final comentarioPrivider = ComentarioPrivider();

  Future<bool> salvar(Comentario comentario)async{
    return await comentarioPrivider.salvar(comentario);
  }

  Future<bool> apagar(int id) async {
   return await comentarioPrivider.apagar(id);
  }

  Future<List<Comentario>> listar(int idVideo) async {
    return await comentarioPrivider.listar(idVideo);
  }
}