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
                : SmartRefresher(
                    enablePullDown: true,
                    enablePullUp: true,
                    onRefresh: () {
                      controller.listarVideo(refresh: false);
                    },
                    onLoading: () {
                      controller.listarVideo(refresh: true);
                    },
                    controller: controller.refreshController,
                    footer: CustomFooter(
                      builder: (BuildContext context, LoadStatus mode) {
                        Widget body;
                        if (mode == LoadStatus.idle) {
                          body = Text("Carregando");
                        } else if (mode == LoadStatus.loading) {
                          body = CircularProgressIndicator();
                        } else if (mode == LoadStatus.canLoading) {
                          body = CircularProgressIndicator(
                              backgroundColor: Colors.cyanAccent,
                              valueColor: new AlwaysStoppedAnimation<Color>(
                                  Colors.red));
                        } else {
                          body = Text("Sem mais vídeos");
                        }
                        return Container(
                          height: 55.0,
                          child: Center(child: body),
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
                                  margin: EdgeInsets.symmetric(horizontal: 10),
                                  width: Get.width,
                                  height: Get.height * .30 < 300
                                      ? 300
                                      : Get.height * .30,
                                  child: Card(
                                      color: isDarkMode
                                          ? Colors.grey[800]
                                          : Colors.grey[200],
                                      elevation: 0,
                                      child: Column(
                                        children: [
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
                              SizedBox(
                                height: 25,
                              ),
                            ],
                          );
                        }),
                  ));
      },
      id: 'videosFiltrado',
    );
  }

  Widget renderLinkPreview(String link, bool total, Video video) {
    double width = total ? Get.width : Get.width * .85;
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
    var htmlDataFacebook =
        '''<iframe src="https://www.facebook.com/plugins/video.php?href=https%3A%2F%2Fwww.facebook.com%2F164841987800427%2Fvideos%2F$videoID%2F&show_text=0&width=$width" width=$width height=$height style="border:none;overflow:hidden" scrolling="no" frameborder="0" allowTransparency="true" allowFullScreen="true"></iframe>''';
    var htmlDataInstagram =
        '''<iframe width=$width height=$height src="http://instagram.com/p/$videoID/embed" frameborder="0"></iframe>''';
    var htmlData =
        """<iframe width=$width height=$height src="https://www.youtube.com/embed/$videoID" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>""";
    final wid = GetPlatform.isMobile
        ? provider == 'youtube'
            ? Html(
                data: htmlData,
              )
            : provider == 'facebook'
                ? Html(
                    data: htmlDataFacebook,
                  )
                : provider == 'instagram'
                    ? Html(
                        data: htmlDataInstagram,
                      )
                    : Html(
                        data: htmlDataVimeo,
                      )
        : GetPlatform.isWeb? Container()
            // ? provider == 'youtube'
            //     ? total
            //         ? EasyWebView(
            //             src: "https://www.youtube.com/embed/$videoID",
            //             onLoaded: () {},
            //             height: height,
            //             width: width,
            //             widgetsTextSelectable: true,
            //           )
            //         : Image.network(
            //             "https://img.youtube.com/vi/$videoID/0.jpg",
            //             fit: BoxFit.contain,
            //           )
            //     : provider == 'facebook'
            //         ? total
            //             ? EasyWebView(
            //                 src:
            //                     "https://www.facebook.com/plugins/video.php?href=https%3A%2F%2Fwww.facebook.com%2F164841987800427%2Fvideos%2F$videoID%2F&show_text=0&width=$width",
            //                 onLoaded: () {},
            //                 height: height,
            //                 width: width,
            //                 widgetsTextSelectable: true,
            //               )
            //             : Image.asset(
            //                 "images/facebook_thumb.jpg",
            //                 fit: BoxFit.contain,
            //                 height: height,
            //                 width: width,
            //               )
            //         : provider == 'instagram'
            //             ? total
            //                 ? EasyWebView(
            //                     src: "http://instagram.com/p/$videoID/embed",
            //                     onLoaded: () {},
            //                     height: height,
            //                     width: width,
            //                     widgetsTextSelectable: true,
            //                   )
            //                 : Image.asset(
            //                     "images/instagram_thumb.jpg",
            //                     fit: BoxFit.contain,
            //                     height: height,
            //                     width: width,
            //                   )
            //             : total
            //                 ? EasyWebView(
            //                     src: "https://player.vimeo.com/video/$videoID",
            //                     onLoaded: () {},
            //                     height: height,
            //                     width: width,
            //                     widgetsTextSelectable: true,
            //                   )
            //                 : Image.asset(
            //                     "images/instagram_thumb.jpg",
            //                     fit: BoxFit.contain,
            //                     height: height,
            //                     width: width,
            //                   )
            : Container(
                width: width,
                height: height,
                color: Colors.blueGrey,
              );
    final textEditingControler = TextEditingController();
    textEditingControler.text =
        video != null && video.descricao != null ? video.descricao : '';
    final dateFormat = DateFormat('dd/MM/yyyy HH:mm');
    return total
        ? Scaffold(
            appBar: AppBar(
              title: Text('Janela de video'),
              centerTitle: true,
            ),
            body: SafeArea(
              child: Center(
                child: ListView(
                  children: [
                    wid,
                    Container(
                      height: Get.height,
                      child: ListView(
                        children: [
                          SizedBox(
                            height: 3,
                          ),
                          Text(
                            '${video.nome}',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                            textAlign: TextAlign.center,
                          ),
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
                                      onPressed: () => Get.bottomSheet(
                                          BottomSheet(
                                              onClosing: () =>
                                                  {controller.listarVideo()},
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
                          Get.find<AppController>().usuario.grupo ==
                                  'administrador'
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
                                                icon:
                                                    Icon(FontAwesomeIcons.check),
                                                duration: Duration(seconds: 2),
                                                backgroundColor:
                                                    Color(0xFF3CFEB5),
                                                messageText: Text(
                                                  'Descrição editado com sucesso',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                borderRadius: 10,
                                                margin: EdgeInsets.only(
                                                    left: 20,
                                                    right: 20,
                                                    bottom: 20));
                                            Future.delayed(Duration(seconds: 2),
                                                () {
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
                          video.itens.isEmpty
                              ? Text('')
                              : Column(
                                  children: [
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      'Itens',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        // fontSize: 20
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    SizedBox(
                                      height: 3,
                                    ),
                                    Container(
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 10),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          border: Border.all(
                                              color: Colors.redAccent)),
                                      child: Center(
                                        child: Column(
                                          children: video.itens
                                              .map((e) => Column(
                                                    children: [
                                                      ListTile(
                                                        leading: Container(
                                                          child: Text(
                                                            e.nome,
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600),
                                                          ),
                                                        ),
                                                        trailing: InkWell(
                                                          onTap: () {
                                                            controller.launchURL(
                                                                e.link);
                                                          },
                                                          child: Container(
                                                            padding:
                                                                EdgeInsets.all(5),
                                                            decoration:
                                                                BoxDecoration(
                                                              boxShadow: [
                                                                BoxShadow(
                                                                  color: Colors
                                                                      .grey
                                                                      .withOpacity(
                                                                          0.5),
                                                                  spreadRadius: 5,
                                                                  blurRadius: 7,
                                                                  offset: Offset(
                                                                      0,
                                                                      3), // changes position of shadow
                                                                ),
                                                              ],
                                                              color: Colors.green,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                            ),
                                                            child:
                                                                Text("Comprar"),
                                                          ),
                                                        ),
                                                      ),
                                                      video.itens.indexOf(e) ==
                                                              video.itens.length -
                                                                  1
                                                          ? Text("")
                                                          : Divider(),
                                                    ],
                                                  ))
                                              .toList(),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                          // Wrap(
                          //   direction: Axis.horizontal,
                          //   children: video.itens.map((e) => Container(
                          //
                          //   )).toList(),
                          // ),
                        ],
                      ),
                    ),
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
    if (GetPlatform.isWeb) {
      return renderLinkPreview(video.url, false, null);
    }
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
                const SizedBox(height: 2),
                renderLinkPreview(video.url, false, null),
            ],
          ),
        );
      },
    );
  }

  String nomeServer(String link) {
    if (link.contains('vimeo.com'))
      return 'vimeo';
    else if (link.contains('facebook.com'))
      return 'facebook';
    else if (link.contains('instagram.com'))
      return 'instagram';
    else
      return 'youtube';
  }

  String idVideo(String link) {
    var split;
    if (link.contains("youtu.be"))
      split = link.split('be/');
    else if (link.contains('youtube.com'))
      split = link.split('?v=');
    else if (link.contains('facebook.com'))
      split = link.split('videos/');
    else if (link.contains('instagram.com'))
      split = link.split('tv/');
    else
      split = link.split('com/');
    return split.elementAt(1);
  }
}
