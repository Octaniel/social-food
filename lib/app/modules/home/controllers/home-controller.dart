import 'dart:convert';

// import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:flutter_link_preview/flutter_link_preview.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:socialfood/app/data/model/Item.dart';
import 'package:socialfood/app/data/model/comentario.dart';
import 'package:socialfood/app/data/model/gosto.dart';
import 'package:socialfood/app/data/model/pessoa.dart';
import 'package:socialfood/app/data/model/video.dart';
import 'package:socialfood/app/data/repository/comentario_repository.dart';
import 'package:socialfood/app/data/repository/gosto_repository.dart';
import 'package:socialfood/app/data/repository/video_repository.dart';
import 'package:socialfood/app/widgets/cunstom_addmob.dart';
import 'package:socialfood/app/widgets/loader-widget.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../app_controller.dart';

class HomeController extends GetxController {
  final videoRepository = VideoRepository();
  final comentarioRepository = ComentarioRepository();
  final gostoRepository = GostoRepository();
  final texteditingController = TextEditingController();
  var scrollController = ScrollController();
  // final cusntomAddmob = CunstomAddmob();
  int page = 0;
  RefreshController refreshController =
      RefreshController(initialRefresh: false);
  final PageController controller = PageController(
    initialPage: 0,
  );

  RxInt currentIndex = 0.obs;

  final _carregando = false.obs;
  final _carregandoRefresh = false.obs;
  final _videos = List<Video>().obs;
  final _videosFiltrado = List<Video>().obs;
  final _comentarios = List<Comentario>().obs;
  final _comentario = Comentario().obs;
  final _video = Video().obs;
  final _permitirComentarios = false.obs;
  final _color = Colors.red.obs;
  final _descricao = ''.obs;
  final _itens = List<Item>().obs;
  final _searchBar = false.obs;

  bool get carregandoRefresh => _carregandoRefresh.value;

  set carregandoRefresh(bool value) {
    _carregandoRefresh.value = value;
    update(['carregandoRefresh']);
  }

  List<Video> get videosFiltrado => _videosFiltrado.value;

  set videosFiltrado(List<Video> value) {
    _videosFiltrado.value = value;
    update(['videosFiltrado']);
  }

  bool get searchBar => _searchBar.value;

  set searchBar(bool value) {
    _searchBar.value = value;
    update(['searchBar']);
  }

  List<Item> get itens => _itens.value;

  set itens(List<Item> value) {
    _itens.value = value;
    update();
  }

  addItem(String value) {
    var item = Item(nome: value);
    itens.add(item);
    update(['addItem']);
  }

  removerItem(Item index) {
    itens.remove(index);
    update(['addItem']);
  }

  String get descricao => _descricao.value;

  set descricao(String value) {
    _descricao.value = value;
    update(['descricaoVideo']);
  }

  set descricao1(String value) {
    _descricao.value = value;
  }

  MaterialColor get color => _color.value;

  set color(value) {
    _color.value = value;
  }

  get permitirComentarios => _permitirComentarios;

  set permitirComentarios(value) {
    _permitirComentarios.value = value;
  }

  Video get video => _video.value;

  set video(value) {
    _video.value = value;
    update(['switchPermitirComentários']);
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

  listarVideo({bool refresh = false}) async {
    if (refresh) {
      var list = List<Video>();
      carregandoRefresh = true;
      page += 1;
      list = await videoRepository.listar(page, texteditingController.text);
      videos.addAll(list);
      videosFiltrado = videos;
      carregandoRefresh = false;
      if (list.length == 0) {
        refreshController.loadNoData();
      } else {
        refreshController.loadComplete();

      }
      update();
    } else {
      page = 0;
      carregando = true;
      videos = await videoRepository.listar(page, texteditingController.text);
      // page += 1;
      videosFiltrado = videos;
      carregando = false;
      refreshController.loadComplete();
      refreshController.refreshCompleted();
      // refreshController.loadComplete();
      update();
      mudarCor();
    }
  }

  // filtrarVideo(String nome) async {
  //   videosFiltrado = List<Video>();
  //   videos.forEach((element) {
  //     if (element.nome?.toLowerCase().contains(nome.toLowerCase())) {
  //       videosFiltrado.add(element);
  //     }
  //   });
  //   update();
  // }

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
    update(['listaComentario']);
  }

  Future<bool> inserirVideo() async {
    video.itens = itens;
    if(GetPlatform.isAndroid||GetPlatform.isIOS){
      WebInfo info = await WebAnalyzer.getInfo(video.url);
      video.nome = info.title;
    }
    video.pessoa = Pessoa(id: Get.find<AppController>().usuario.pessoa.id);
    return await videoRepository.salvar(video);
  }

  onTabTapped(int index) {
    this.currentIndex.value = index;
    controller.jumpToPage(index);
  }

  salvarGosto(int idVideo) async {
    var idGosto = IdGosto(
        pessoa: Pessoa(id: Get.find<AppController>().usuario.pessoa.id),
        video: Video(id: idVideo));
    var salvar = await gostoRepository.salvar(Gosto(idGosto: idGosto));
    if (salvar) {
      var video = videos.firstWhere((element) => element.id == idVideo);
      video.voceGostou = true;
    } else {
      var video = videos.firstWhere((element) => element.id == idVideo);
      video.voceGostou = false;
    }
    update(['salverGosto']);
  }

  mudarCor() async {
    for (int i = 0; i < 4000000; i++) {
      await Future.delayed(Duration(seconds: 2), () {
        if (color == Colors.red)
          color = Colors.green;
        else if (color == Colors.green)
          color = Colors.blue;
        else
          color = Colors.red;
      });
      update();
    }
  }

  Future<bool> atualizarDescricaoVideo(Video video) async {
    return await videoRepository.atlauizar(video);
  }

  launchURL(url) async {
    // const url = 'https://flutter.dev';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  void onInit() {
    super.onInit();
    // showBnner();
    // scrollController = ScrollController();
  }

  // showBnner(){
  //   cusntomAddmob.myBanner()
  //   // typically this happens well before the ad is shown
  //     ..load()
  //     ..show(
  //       // Positions the banner ad 60 pixels from the bottom of the screen
  //       // anchorOffset: 60.0,
  //       // Positions the banner ad 10 pixels from the center of the screen to the right
  //       // horizontalCenterOffset: 10.0,
  //       // Banner Position
  //       anchorType: AnchorType.bottom,
  //     );
  // }



  @override
  void onClose() {
    page = 0;
    // cusntomAddmob.myBanner()..load()..dispose();
    // scrollController.dispose();
    // scrollController = null;
    super.onClose();
  }
}
