import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socialfood/app/data/model/comentario.dart';
import 'package:socialfood/app/data/model/gosto.dart';
import 'package:socialfood/app/data/model/pessoa.dart';
import 'package:socialfood/app/data/model/video.dart';
import 'package:socialfood/app/data/repository/comentario_repository.dart';
import 'package:socialfood/app/data/repository/gosto_repository.dart';
import 'package:socialfood/app/data/repository/video_repository.dart';

import '../../../app_controller.dart';

class FavoritoController extends GetxController{
  final videoRepository = VideoRepository();
  final comentarioRepository = ComentarioRepository();
  final gostoRepository = GostoRepository();
  int page = 0;
  final PageController controller = PageController(
    initialPage: 0,
  );

  RxInt currentIndex = 0.obs;

  final _carregando = false.obs;
  final _videos = List<Video>().obs;
  final _comentarios = List<Comentario>().obs;
  final _comentario = Comentario().obs;
  final _permitirComentarios = false.obs;
  final _color = Colors.red.obs;
  final _descricao = ''.obs;

  String get descricao => _descricao.value;

  set descricao(String value) {
    _descricao.value = value;
    update(['descricaoVideo']);
  }

  MaterialColor get color => _color.value;

  set color(value) {
    _color.value = value;
  }

  get permitirComentarios => _permitirComentarios;

  set permitirComentarios(value) {
    _permitirComentarios.value = value;
  }

  Comentario get comentario => _comentario.value;

  set comentario(value) {
    _comentario.value = value;
  }

  List<Comentario> get comentarios => _comentarios.value;

  set comentarios(value) {
    _comentarios.value = value;
  }

  List<Video> get videos => _videos.value;

  set videos(value) {
    _videos.value = value;
  }

  get carregando => _carregando.value;

  set carregando(value) {
    _carregando.value = value;
  }

  excluirComentario(int comentarioId, int videoId) async {
    await comentarioRepository.apagar(comentarioId);
    listarComentario(videoId);
  }

  inserirComentario(int videoId) {
    comentario.video = Video(id: videoId);
    comentario.pessoa = Pessoa(id: Get.find<AppController>().usuario.pessoa.id);
    comentarioRepository.salvar(comentario);
  }

  listarComentario(int idVideo) async {
    carregando = true;
    comentarios = await comentarioRepository.listar(idVideo);
    carregando = false;
    update();
    print("rr");
  }

  onTabTapped(int index) {
    this.currentIndex.value = index;
    controller.jumpToPage(index);
  }

  listarVideoQueGostei(String nome, {bool refresh=false}) async {
    // final listVideoAux = List<Video>();
    carregando = true;
    videos = await videoRepository.listarQueGostei(page,'');
    page += 1;
    // videos.forEach((element) {
    //   if(element.voceGostou) listVideoAux.add(element);
    // });
    // videos = listVideoAux;
    carregando = false;
    update();
    mudarCor();
  }

  salvarGosto(int idVideo) async {
    var idGosto = IdGosto(pessoa: Pessoa(id: Get.find<AppController>().usuario.pessoa.id), video: Video(id: idVideo));
    var salvar = await gostoRepository.salvar(Gosto(idGosto: idGosto));
    if(salvar){
      var video = videos.firstWhere((element) => element.id==idVideo);
      video.voceGostou = true;
    }else{
      var video = videos.firstWhere((element) => element.id==idVideo);
      video.voceGostou = false;
    }
    update();
  }

  mudarCor() async {
    for(int i=0;i<4000000;i++){
      await Future.delayed(Duration(seconds: 2),(){
        if(color==Colors.red) color = Colors.green;
        else if(color==Colors.green) color = Colors.blue;
        else color = Colors.red;
      });
      update();
    }
  }

  Future<bool> atualizarDescricaoVideo(Video video) async {
    return await videoRepository.atlauizar(video);
  }

}