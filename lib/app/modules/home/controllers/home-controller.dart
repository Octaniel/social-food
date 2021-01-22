import 'package:flutter/material.dart';
import 'package:flutter_link_preview/flutter_link_preview.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:socialfood/app/data/model/Item.dart';
import 'package:socialfood/app/data/model/comentario.dart';
import 'package:socialfood/app/data/model/gosto.dart';
import 'package:socialfood/app/data/model/pessoa.dart';
import 'package:socialfood/app/data/model/usuario.dart';
import 'package:socialfood/app/data/model/video.dart';
import 'package:socialfood/app/data/repository/auth_repository.dart';
import 'package:socialfood/app/data/repository/comentario_repository.dart';
import 'package:socialfood/app/data/repository/gosto_repository.dart';
import 'package:socialfood/app/data/repository/video_repository.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../app_controller.dart';

class HomeController extends GetxController {
  final videoRepository = VideoRepository();
  final comentarioRepository = ComentarioRepository();
  final gostoRepository = GostoRepository();
  final texteditingController = TextEditingController();
  var scrollController = ScrollController();
  final authRepository = AuthRepository();

  // final cusntomAddmob = CunstomAddmob();
  int page = 0;
  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  int pageUsers = 0;
  RefreshController refreshControllerUsers =
      RefreshController(initialRefresh: false);
  final PageController controller = PageController(
    initialPage: 0,
  );

  RxInt currentIndex = 0.obs;

  final _carregando = false.obs;
  final _carregandoRefresh = false.obs;
  final _videos = <Video>[].obs;
  final _videosFiltrado = <Video>[].obs;
  final _comentarios = <Comentario>[].obs;
  final _usuarios = <Usuario>[].obs;
  final _usuariosResumo = <Map<String, Object>>[].obs;
  final _comentario = Comentario().obs;
  final _video = Video().obs;
  final _usuario = Usuario().obs;
  final _permitirComentarios = false.obs;
  final _color = Colors.red.obs;
  final _descricao = ''.obs;
  final _itens = <Item>[].obs;
  final _searchBar = false.obs;
  final _totalVideo = 0.obs;
  final _totalUsuario = 0.obs;
  final _totalUsuarioUltimo30Dias = 0.obs;
  final _rf1 = 0.obs;
  var searchVideo = '';
  var searchUsuario = '';
  // var usuario1 = Usuario();

  get rf1 => _rf1.value;

  set rf1(value) {
    _rf1.value = value;
  }

  Usuario get usuario => _usuario.value;

  set usuario(Usuario value) {
    _usuario.value = value;
  }

  get usuarios => _usuarios.value;

  set usuarios(value) {
    _usuarios.assignAll(value);
  }

  List<Map<String, Object>> get usuariosResumo => _usuariosResumo.value;

  set usuariosResumo(value) {
    _usuariosResumo.value = value;
  }

  get totalUsuarioUltimo30Dias => _totalUsuarioUltimo30Dias.value;

  set totalUsuarioUltimo30Dias(value) {
    _totalUsuarioUltimo30Dias.value = value;
  }

  get totalVideo => _totalVideo.value;

  set totalVideo(value) {
    _totalVideo.value = value;
  }

  get totalUsuario => _totalUsuario.value;

  set totalUsuario(value) {
    _totalUsuario.value = value;
  }

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
      list = await videoRepository.listar(page, searchVideo);
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
      videos = await videoRepository.listar(page, searchVideo);
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

  listarUsuario({bool refresh = false}) async {
    if (refresh) {
      var list = <Usuario>[];
      carregandoRefresh = true;
      pageUsers += 1;
      list = await authRepository.listar(pageUsers, searchUsuario);
      usuarios.addAll(list);
      carregandoRefresh = false;
      if (list.length == 0) {
        refreshControllerUsers.loadNoData();
      } else {
        refreshControllerUsers.loadComplete();
      }
      update();
    } else {
      pageUsers = 0;
      carregando = true;
      usuarios = await authRepository.listar(pageUsers, searchUsuario);
      print(usuarios);
      // page += 1;
      carregando = false;
      print(carregando);
      refreshControllerUsers.loadComplete();
      refreshControllerUsers.refreshCompleted();
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
    if (GetPlatform.isAndroid || GetPlatform.isIOS) {
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

  Future<void> totalUsuarios() async {
    totalUsuario = await authRepository.getCount();
  }

  Future<void> totalUsuariosUltimo30Dias() async {
    totalUsuarioUltimo30Dias = await authRepository.getCountUltimo30Dias();
  }

  Future<void> totalVideos() async {
    totalVideo = await videoRepository.totalVideo();
  }

  Future<bool> remover(int id) async {
    return await videoRepository.remover(id);
  }

  Future<bool> removerUsuario(int id) async {
    return await authRepository.remover(id);
  }

  Future<void> listarUsuarioDtoParaGrafico() async {
    usuariosResumo = await authRepository.listarUsuarioDtoParaGrafico();
    rf1 = rf1 + 1;
  }

  launchURL(url) async {
    // const url = 'https://flutter.dev';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<List<dynamic>> saveUser() async {
    return await authRepository.add(usuario);
  }

  @override
  Future<void> onInit() async {
    super.onInit();
    await totalVideos();
    await totalUsuarios();
    await totalUsuariosUltimo30Dias();
    await listarUsuarioDtoParaGrafico();
    update();
  }

  @override
  void onClose() {
    page = 0;
    super.onClose();
  }
}
