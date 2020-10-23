import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:socialfood/app/app_controller.dart';
import 'package:socialfood/app/data/model/Item.dart';
import 'package:socialfood/app/data/model/video.dart';
import 'package:socialfood/app/modules/home/controllers/home-controller.dart';
import 'package:socialfood/app/routes/app_routes.dart';
import 'package:socialfood/app/widgets/text-widget.dart';

class AddVideoWebPage extends GetView<HomeController> {
  final _ttxeEditingcontroller1 = TextEditingController();
  final _ttxeEditingcontroller2 = TextEditingController();
  final _ttxeEditingcontroller3 = TextEditingController();
  final _ttxeEditingcontroller4 = TextEditingController();
  final _ttxeEditingcontroller5 = TextEditingController();
  final _ttxeEditingcontroller6 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CircleAvatar(
            backgroundImage: NetworkImage(
                Get.find<AppController>().usuario.pessoa?.fotoUrl??'https://p7.hiclipart.com/preview/340/956/944/computer-icons-user-profile-head-ico-download.jpg',
                scale: 2)),
        actions: [
          IconButton(
            tooltip: 'Sair',
            onPressed: () async {
              if (await Get.find<AppController>().logout()) {
                Get.offAllNamed(Routes.LOGIN);
              }
            },
            icon: Icon(FontAwesomeIcons.signOutAlt),
          ),
        ],
        centerTitle: true,
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GetBuilder<HomeController>(
            builder: (_) {
              return ListView(
                children: [
                  TextFormField(
                    controller: _ttxeEditingcontroller1,
                    onChanged: (v) => controller.video.url = v,
                    decoration: InputDecoration(
                        labelStyle: GoogleFonts.muli(),
                        labelText: 'Url do vídeo'),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextField(
                    controller: _ttxeEditingcontroller2,
                    maxLines: 3,
                    onChanged: (v) {
                      controller.video.descricao = v;
                    },
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      hintText: 'Descrição',
                      // contentPadding: EdgeInsets.all(5)
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  TextField(
                    controller: _ttxeEditingcontroller3,
                    maxLines: 3,
                    onChanged: (v) {
                      controller.video.igredientes = v;
                    },
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      hintText: 'Igredientes',
                      // contentPadding: EdgeInsets.all(5)
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  TextField(
                    controller: _ttxeEditingcontroller4,
                    maxLines: 3,
                    onChanged: (v) {
                      controller.video.preparo = v;
                    },
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      hintText: 'Preparo',
                      // contentPadding: EdgeInsets.all(5)
                    ),
                  ),
                  Row(
                    children: [
                      Container(
                        width: Get.width * .5 - 12,
                        child: TextField(
                          controller: _ttxeEditingcontroller5,
                          onChanged: (v) {
                            controller.video.canalLink = v;
                          },
                          decoration: InputDecoration(
                            hintText: 'Link do Canal',
                            // contentPadding: EdgeInsets.all(5)
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Container(
                        width: Get.width * .5 - 12,
                        child: TextField(
                          controller: _ttxeEditingcontroller6,
                          onChanged: (v) {
                            controller.video.pageLink = v;
                          },
                          decoration: InputDecoration(
                            hintText: 'Link da Pagina',
                            // contentPadding: EdgeInsets.all(5)
                          ),
                        ),
                      ),
                    ],
                  ),
                  GetBuilder<HomeController>(
                    builder: (_) {
                      return Wrap(
                        direction: Axis.horizontal,
                        children: controller.itens
                            .map((e) => Container(
                                  width: Get.width * .25 - 12,
                                  child: Row(
                                    children: [
                                      Container(
                                        width: Get.width * .20 - 12,
                                        child: TextField(
                                          onChanged: (v) {
                                            e.nome = v;
                                          },
                                          decoration: InputDecoration(
                                            hintText:
                                                'Item(${controller.itens.indexOf(e) + 1})',
                                            // contentPadding: EdgeInsets.all(5)
                                          ),
                                        ),
                                      ),
                                      // SizedBox(
                                      //   width: 5,
                                      // ),
                                      Container(
                                        height: 30,
                                        width: 30,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(50)),
                                        child: InkWell(
                                          onTap: () =>
                                              controller.removerItem(e),
                                          child: Icon(FontAwesomeIcons.times),
                                        ),
                                      ),
                                    ],
                                  ),
                                ))
                            .toList(),
                      );
                    },
                    id: 'addItem',
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    margin: EdgeInsets.only(right: Get.width * .8),
                    height: 40,
                    child: RaisedButton(
                        color: Colors.red,
                        elevation: 0,
                        child: TextWidget(
                          text: 'Adicionar Item',
                          color: Colors.white,
                        ),
                        onPressed: () => controller.addItem("")),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextWidget(
                      text: 'Caso esteja tudo pronto, clique no botão abaixo'),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: Get.width,
                    height: 50,
                    child: RaisedButton(
                        color: Colors.red,
                        elevation: 0,
                        child: TextWidget(
                          text: 'Adicionar Video',
                          color: Colors.white,
                        ),
                        onPressed: () => inserirVideo()),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  inserirVideo() async {
    if (await controller.inserirVideo()) {
      Get.rawSnackbar(
          icon: Icon(FontAwesomeIcons.check),
          duration: Duration(seconds: 2),
          backgroundColor: Color(0xFF3CFEB5),
          messageText: Text(
            'Adiciodano com sucesso',
            style: TextStyle(
                color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
          ),
          borderRadius: 10,
          margin: EdgeInsets.only(left: 20, right: 20, bottom: 20));
      Future.delayed(Duration(seconds: 2), () {
        _ttxeEditingcontroller1.text = '';
        _ttxeEditingcontroller2.text = '';
        _ttxeEditingcontroller3.text = '';
        _ttxeEditingcontroller4.text = '';
        _ttxeEditingcontroller5.text = '';
        _ttxeEditingcontroller6.text = '';
        controller.video = Video();
        controller.itens = List<Item>();
      });
    } else {
      Get.rawSnackbar(
          icon: Icon(
            FontAwesomeIcons.times,
            color: Colors.white,
          ),
          duration: Duration(seconds: 2),
          backgroundColor: Color(0xFFFE3C3C),
          messageText: Text(
            'Houve problema no envio',
            style: TextStyle(
                color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
          ),
          borderRadius: 10,
          margin: EdgeInsets.only(left: 20, right: 20, bottom: 20));
    }
  }
}
