import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_link_preview/flutter_link_preview.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
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
      builder: (_) {
        return Visibility(
            visible: !controller.carregando,
            replacement: LoaderWidget(),
            child: controller.videos.isEmpty
                ? Center(
                    child: TextWidget(
                      text: 'Nenhum vídeo cadastrado no momento',
                    ),
                  )
                : ListView.builder(
                    itemCount: controller.videos.length,
                    itemBuilder: (context, index) {
                      Video video = controller.videos[index];

                      return Column(
                        children: [
                          Container(
                              margin: EdgeInsets.all(10),
                              width: Get.width,
                              height: 400,
                              child: Card(
                                  color: isDarkMode
                                      ? Colors.grey[800]
                                      : Colors.grey[200],
                                  elevation: 0,
                                  child: Column(
                                    children: [
                                      ListTile(
                                        title: TextWidget(
                                            text:
                                                '${video.pessoa.nome} ${video.pessoa.apelido}'),

                                        leading: CircleAvatar(
                                            backgroundImage: NetworkImage(
                                                video.pessoa.fotoUrl)),
                                        // leading: CircleAvatar(
                                        //   child: Icon(Icons.person),
                                        // ),
                                      ),
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
                                        child: renderLinkPreview1(video.url),
                                      ),
                                      // GestureDetector(
                                      //   onTap: () {
                                      //     Navigator.push(
                                      //         context,
                                      //         MaterialPageRoute(
                                      //             builder: (context) =>
                                      //                 renderLinkPreview(
                                      //                     video.url, true)));
                                      //   },
                                      //   child: Container(
                                      //     height: 270,
                                      //     width: 270,
                                      //     color: Colors.greenAccent,
                                      //   ),
                                      // ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
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
                                                controller
                                                    .salvarGosto(video.id);
                                              }),
                                          IconButton(
                                              icon:
                                                  Icon(Ionicons.ios_chatboxes),
                                              onPressed: () => Get.bottomSheet(
                                                  BottomSheet(
                                                      onClosing: () => {
                                                            controller
                                                                .listarVideo()
                                                          },
                                                      builder: (context) {
                                                        return ComentariosView(
                                                          videoId: video.id,
                                                        );
                                                      }))),
                                          IconButton(
                                              icon: Icon(Ionicons.md_eye),
                                              onPressed: () {}),
                                          SizedBox(
                                            width: 10,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ))),
                          Visibility(
                            visible: index % 2 != 0,
                            replacement: Text(""),
                            child: Container(
                              margin: EdgeInsets.symmetric(horizontal: 10),
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
                    }));
      },
    );
  }

  Widget renderLinkPreview(String link, bool total, Video video) {
    double width = total ? Get.width : Get.width * .8;
    double height = total ? Get.height * .4 : Get.height * .23;
    String provider = nomeServer(link), videoID = idVideo(link);
    var htmlDataVimeo =
        '''<iframe src="https://player.vimeo.com/video/$videoID" width=$width height=$height frameborder="0" allow="autoplay; fullscreen" allowfullscreen></iframe>''';
    var htmlData =
        """<iframe width=$width height=$height src="https://www.youtube.com/embed/$videoID" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>""";
    final wid = provider == 'youtube'
        ? Html(
            data: htmlData,
          )
        : Html(
            data: htmlDataVimeo,
          );
    // print(Get.find<AppController>().usuario.pessoa.fotoUrl);
    final textEditingControler = TextEditingController();
    textEditingControler.text =
        video != null && video.descricao != null ? video.descricao : '';
    final dateFormat = DateFormat('dd/MM/yyyy HH:mm');
    return total
        ? Scaffold(
            body: SafeArea(
              child: Center(
                child: ListView(
                  children: [
                    wid,
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
                      dispose: (s){
                        controller.descricao = '';
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
                        : Text('')
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

  Widget renderLinkPreview1(String link) {
    return FlutterLinkPreview(
      key: ValueKey(link),
      url: link,
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
                        webInfo.title,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ],
              ),
              if (WebAnalyzer.isNotEmpty(webInfo.image)) ...[
                const SizedBox(height: 2),
                renderLinkPreview(link, false, null),
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
