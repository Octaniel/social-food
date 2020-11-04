import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_link_preview/flutter_link_preview.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:socialfood/app/app_controller.dart';
import 'package:socialfood/app/data/model/video.dart';
import 'package:socialfood/app/modules/home/controllers/home-controller.dart';
import 'package:socialfood/app/res/util.dart';
import 'package:socialfood/app/widgets/loader-widget.dart';
import 'package:socialfood/app/widgets/text-widget.dart';

import 'comentarios-view.dart';

class FeedView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    controller.listarVideo();
    return GetBuilder<HomeController>(
      // initState: (d) {
      //   controller.scrollController.addListener(() {
      //     if (controller.scrollController.position.pixels ==
      //         controller.scrollController.position.maxScrollExtent) {
      //       print('uuuoou');
      //       controller.listarVideo(refresh: true);
      //     }
      //   });
      // },
      // dispose: (s) {
      //   controller.scrollController.dispose();
      // },
      builder: (_) {
        return Visibility(
            visible: !controller.carregando,
            replacement: LoaderWidget(),
            child: controller.videosFiltrado.isEmpty
                ? Center(
                    child: TextWidget(
                      text: controller.texteditingController.text.isEmpty
                          ? 'Nenhum vídeo cadastrado no momento'
                          : 'Nenhum vídeo relaoicnado com a sua pesquisa no momento',
                    ),
                  )
                : Stack(
                    children: [
                      SmartRefresher(
                        enablePullDown: true,
                        enablePullUp: true,
                        onRefresh: (){
                          controller.listarVideo(refresh: false);
                        },
                        onLoading: (){
                          controller.listarVideo(refresh: true);
                        },
                        controller: controller.refreshController,
                        footer: CustomFooter(
                          builder: (BuildContext context,LoadStatus mode){
                            Widget body ;
                            if(mode==LoadStatus.idle){
                              body =  Text("Carregando");
                            }
                            else if(mode==LoadStatus.loading){
                              body =  CircularProgressIndicator();
                            }
                            else if(mode == LoadStatus.canLoading){
                              body =  CircularProgressIndicator(
                                              backgroundColor: Colors.cyanAccent,
                                              valueColor:
                                                  new AlwaysStoppedAnimation<Color>(
                                                      Colors.red));
                            }
                            else{
                              body = Text("Sem mais vídeos");
                            }
                            return Container(
                              height: 55.0,
                              child: Center(child:body),
                            );
                          },
                        ),
                        child: ListView.builder(
                            // controller: controller.scrollController,
                            itemCount: controller.videosFiltrado.length,
                            itemBuilder: (context, index) {
                              Video video = controller.videosFiltrado[index];

                              return Column(
                                children: [
                                  Container(
                                      margin: EdgeInsets.all(10),
                                      width: Get.width,
                                      height: Get.height * .42 < 350
                                          ? 350
                                          : Get.height * .38,
                                      child: Card(
                                          color: isDarkMode
                                              ? Colors.grey[800]
                                              : Colors.grey[200],
                                          elevation: 0,
                                          child: Column(
                                            children: [
                                              // ListTile(
                                              //   title: TextWidget(
                                              //       text:
                                              //           '${video.pessoa.nome} ${video.pessoa.apelido}'),
                                              //
                                              //   leading: CircleAvatar(
                                              //       backgroundImage: NetworkImage(
                                              //           video.pessoa.fotoUrl)),
                                              //   // leading: CircleAvatar(
                                              //   //   child: Icon(Icons.person),
                                              //   // ),
                                              // ),
                                              GestureDetector(
                                                onTap: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              renderLinkPreview(
                                                                  video.url,
                                                                  true,
                                                                  video)));
                                                },
                                                child: renderLinkPreview1(video),
                                              ),
                                            ],
                                          ))),
                                  Visibility(
                                    visible: index % 2 != 0,
                                    replacement: Text(""),
                                    child: Container(
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 10),
                                      height: 50,
                                      width: Get.width,
                                      decoration: BoxDecoration(
                                        color: controller.color,
                                        borderRadius: BorderRadius.circular(11),
                                      ),
                                      child: Center(
                                        child: Text(
                                          'Espaço para publicidade',
                                          style: TextStyle(
                                            fontFamily: 'Segoe UI',
                                            fontSize: 20,
                                            color: const Color(0xffffffff),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            }),
                      ),
                      // GetBuilder<HomeController>(
                      //   builder: (_) {
                      //     return controller.carregandoRefresh
                      //         ? Align(
                      //             alignment: Alignment.bottomCenter,
                      //             child: CircularProgressIndicator(
                      //               backgroundColor: Colors.cyanAccent,
                      //               valueColor:
                      //                   new AlwaysStoppedAnimation<Color>(
                      //                       Colors.red),
                      //             ),
                      //           )
                      //         : Text('');
                      //   },
                      //   id: 'carregandoRefresh',
                      // )
                    ],
                  ));
      },
      id: 'videosFiltrado',
    );
  }

  Widget renderLinkPreview(String link, bool total, Video video) {
    double width = total ? Get.width : Get.width * .8;
    double height = total
        ? Get.height * .4 < 250
            ? 250
            : Get.height * .4
        : Get.height * .23 < 200
            ? 200
            : Get.height * .23;
    String provider = nomeServer(link), videoID = idVideo(link);
    var htmlDataVimeo =
        '''<iframe src="https://player.vimeo.com/video/$videoID" width=$width height=$height frameborder="0" allow="autoplay; fullscreen" allowfullscreen></iframe>''';
    var htmlData =
        """<iframe width=$width height=$height src="https://www.youtube.com/embed/$videoID" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>""";
    final wid = GetPlatform.isAndroid || GetPlatform.isIOS
        ? provider == 'youtube'
            ? Html(
                data: htmlData,
              )
            : Html(
                data: htmlDataVimeo,
              )
        : Container(
            width: width,
            height: height,
            color: Colors.blueGrey,
          );
    // if(total) print('hhhhhhhhhh${video.descricao}');
    final textEditingControler = TextEditingController();
    textEditingControler.text =
        video != null && video.descricao != null ? video.descricao : '';
    final dateFormat = DateFormat('dd/MM/yyyy HH:mm');
    return total
        ? Scaffold(
            appBar: AppBar(
              title: Text('Janela de video'),
            ),
            body: SafeArea(
              child: Center(
                child: ListView(
                  children: [
                    wid,
                    SizedBox(
                      height: 3,
                    ),
                    GetBuilder<HomeController>(
                      builder: (_) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: 10,
                            ),
                            IconButton(
                                icon: Icon(
                                  Ionicons.ios_heart,
                                  color: !Get.isDarkMode
                                      ? video.voceGostou
                                          ? Colors.red
                                          : Colors.black87
                                      : video.voceGostou
                                          ? Colors.black87
                                          : Colors.white,
                                ),
                                onPressed: () {
                                  controller.salvarGosto(video.id);
                                }),
                            IconButton(
                                icon: Icon(Ionicons.ios_chatboxes),
                                onPressed: () => Get.bottomSheet(BottomSheet(
                                    onClosing: () => {controller.listarVideo()},
                                    builder: (context) {
                                      return ComentariosView(
                                        videoId: video.id,
                                      );
                                    }))),
                            SizedBox(
                              width: 10,
                            ),
                          ],
                        );
                      },
                      id: 'salverGosto',
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 7),
                      child: Text(
                          'Publicado em ${dateFormat.format(video.dataPublicacao)}'),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    GetBuilder<HomeController>(
                      dispose: (s) {
                        controller.descricao1 = '';
                      },
                      initState: (s) {
                        controller.descricao = textEditingControler.text;
                      },
                      builder: (_) {
                        return controller.descricao.isEmpty
                            ? Text(
                                'Sem descrição',
                                textAlign: TextAlign.center,
                              )
                            : Text(
                                '${controller.descricao}',
                                style: TextStyle(fontSize: 16),
                                textAlign: TextAlign.center,
                              );
                      },
                      id: 'descricaoVideo',
                    ),
                    Get.find<AppController>().usuario.grupo == 'administrador'
                        ? IconButton(
                            tooltip: 'Editar descrição',
                            icon: Icon(Icons.edit),
                            onPressed: () {
                              Get.defaultDialog(
                                  title: 'Editar descrição',
                                  content: TextField(
                                    controller: textEditingControler,
                                    maxLines: 3,
                                    onChanged: (v) {
                                      video.descricao = v;
                                      controller.descricao = v;
                                    },
                                    textAlign: TextAlign.center,
                                    decoration: InputDecoration(
                                      hintText: 'Descrição',
                                      // contentPadding: EdgeInsets.all(5)
                                    ),
                                  ),
                                  onConfirm: () async {
                                    if (await controller
                                        .atualizarDescricaoVideo(video)) {
                                      Get.rawSnackbar(
                                          icon: Icon(FontAwesomeIcons.check),
                                          duration: Duration(seconds: 2),
                                          backgroundColor: Color(0xFF3CFEB5),
                                          messageText: Text(
                                            'Descrição editado com sucesso',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          borderRadius: 10,
                                          margin: EdgeInsets.only(
                                              left: 20, right: 20, bottom: 20));
                                      Future.delayed(Duration(seconds: 2), () {
                                        Navigator.pop(Get.context);
                                      });
                                    }
                                  });
                            },
                          )
                        : Text(''),
                    !video.igredientes.isNullOrBlank
                        ? Column(
                            children: [
                              Text(
                                'Igredientes:',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              Text(
                                '${video.igredientes}',
                                style: TextStyle(),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          )
                        : Text(''),
                    !video.preparo.isNullOrBlank
                        ? Column(
                            children: [
                              Text(
                                'Preparo:',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              Text(
                                '${video.preparo}',
                                style: TextStyle(),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          )
                        : Text(''),
                    !video.canalLink.isNullOrBlank
                        ? Column(
                            children: [
                              Text(
                                'Link do canal:',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              Text(
                                '${video.canalLink}',
                                style: TextStyle(),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          )
                        : Text(''),
                    !video.pageLink.isNullOrBlank
                        ? Column(
                            children: [
                              Text(
                                'Link da pagina:',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              Text(
                                '${video.pageLink}',
                                style: TextStyle(),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          )
                        : Text(''),
                  ],
                ),
              ),
            ),
          )
        : Stack(
            children: [
              wid,
              Container(
                height: height,
                width: width,
                color: Colors.transparent,
              ),
            ],
          );
  }

  Widget renderLinkPreview1(Video video) {
    return FlutterLinkPreview(
      key: ValueKey(video.url),
      url: video.url,
      builder: (info) {
        if (info == null) {
          return LoaderWidget();
        }

        if (info is WebImageInfo) {
          return CachedNetworkImage(
            imageUrl: info.image,
            fit: BoxFit.contain,
          );
        }

        final WebInfo webInfo = info;
        if (!WebAnalyzer.isNotEmpty(webInfo.title)) return const SizedBox();
        return Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  CachedNetworkImage(
                    imageUrl: webInfo.icon ?? "",
                    imageBuilder: (context, imageProvider) {
                      return Image(
                        image: imageProvider,
                        fit: BoxFit.contain,
                        width: 30,
                        height: 30,
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(Icons.link);
                        },
                      );
                    },
                  ),
                  const SizedBox(width: 8),
                  Container(
                    child: Flexible(
                      child: Text(
                        video.nome,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ],
              ),
              if (WebAnalyzer.isNotEmpty(webInfo.image)) ...[
                const SizedBox(height: 2),
                renderLinkPreview(video.url, false, null),
              ]
            ],
          ),
        );
      },
    );
  }

  String nomeServer(String link) {
    if (link.contains('vimeo.com'))
      return 'vimeo';
    else
      return 'youtube';
  }

  String idVideo(String link) {
    var split;
    if (link.contains("youtu.be"))
      split = link.split('be/');
    else if (link.contains('youtube.com'))
      split = link.split('?v=');
    else
      split = link.split('com/');
    return split.elementAt(1);
  }
}
