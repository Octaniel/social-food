import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_link_preview/flutter_link_preview.dart';
import 'package:get/get.dart';
import 'package:socialfood/app/data/model/video.dart';
import 'package:socialfood/app/modules/favoritos/controllers/favorito_controller.dart';
import 'package:socialfood/app/modules/favoritos/widgets/comentarios_widget.dart';
import 'package:socialfood/app/res/util.dart';
import 'package:socialfood/app/widgets/custom_drawer.dart';
import 'package:socialfood/app/widgets/loader-widget.dart';
import 'package:socialfood/app/widgets/text-widget.dart';

class FavoritoPage extends GetView<FavoritoController> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: CustomDrawer(),
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
            icon: Icon(Icons.restaurant_menu),
            onPressed: () {
              _scaffoldKey.currentState.openDrawer();
            }),
        title: TextWidget(
          text: 'FeedFood',
        ),
      ),
      body: GetBuilder<FavoritoController>(
        initState: (v) {
          controller.listarVideoQueGostei();
        },
        builder: (_) {
          return Visibility(
              visible: !controller.carregando,
              replacement: LoaderWidget(),
              child: controller.videos.isEmpty
                  ? Center(
                      child: TextWidget(
                        text: 'Nenhum Favorito adicionado',
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

                                          // leading: CircleAvatar(
                                          //     backgroundImage:
                                          //         NetworkImage(video.pessoa.fotoUrl)),
                                          leading: CircleAvatar(
                                            child: Icon(Icons.person),
                                          ),
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
                                        //   child: renderLinkPreview1(video.url),
                                        // ),
                                        Container(
                                          height: 270,
                                          width: 270,
                                          color: Colors.greenAccent,
                                        ),
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
                                                  color: video.voceGostou
                                                      ? Colors.red
                                                      : Colors.black87,
                                                ),
                                                onPressed: () {
                                                  controller
                                                      .salvarGosto(video.id);
                                                }),
                                            IconButton(
                                                icon: Icon(
                                                    Ionicons.ios_chatboxes),
                                                onPressed: () =>
                                                    Get.bottomSheet(BottomSheet(
                                                        onClosing: () => {
                                                              controller
                                                                  .listarVideoQueGostei()
                                                            },
                                                        builder: (context) {
                                                          return ComentariosWidget(
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
      ),
    );
  }

  Widget renderLinkPreview(String link, bool total) {
    double width = total ? Get.width * .9 : Get.width * .8;
    double height = total ? Get.height * .6 : Get.height * .4;
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
    return total
        ? Scaffold(
            body: SafeArea(
              child: Center(
                child: wid,
              ),
            ),
          )
        : wid;
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
                renderLinkPreview(link, false),
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
