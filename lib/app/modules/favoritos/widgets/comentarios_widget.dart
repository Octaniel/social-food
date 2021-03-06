import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socialfood/app/modules/favoritos/controllers/favorito_controller.dart';
import 'package:socialfood/app/modules/home/controllers/home-controller.dart';
import 'package:socialfood/app/widgets/loader-widget.dart';
import 'package:socialfood/app/widgets/text-widget.dart';

import '../../../app_controller.dart';

class ComentariosWidget extends GetView<FavoritoController> {
  final int videoId;

  final scrollController = ScrollController(initialScrollOffset: 0);

  ComentariosWidget({Key key, this.videoId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FavoritoController>(
      initState: (v){
        controller.listarComentario(videoId);
      },
        builder: (_) {
          // if (!controller.carregando) scrollToBottom();
          return ListView(
            children: [
              Visibility(
                replacement: LoaderWidget(),
                visible: !controller.carregando,
                child: Visibility(
                  visible: controller.comentarios.length == 0,
                  replacement: comComentario(),
                  child: semComentario(),
                ),
              ),
            ],
          );
        });
  }

  Container comComentario() {
    return Container(
      height: Get.height * .55,
      child: Visibility(
        replacement: LoaderWidget(),
        visible: !controller.carregando,
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            TextWidget(
              text: 'Comentários',
              fontSize: 17,
            ),
            Expanded(
              child: Container(
                height: Get.height * .4,
                child: ListView.builder(
                    controller: scrollController,
                    itemCount: controller.comentarios.length,
                    itemBuilder: (context, index) {
                      var comentario = controller.comentarios[index];

                      return ListTile(
                        // leading: CircleAvatar(
                        //     backgroundImage: NetworkImage(
                        //         comentario.pessoa.fotoUrl,
                        //         scale: 2)),
                        leading: CircleAvatar(
                          child: Icon(Icons.person),
                        ),
                        title: TextWidget(
                          text: comentario.pessoa.nome,
                        ),
                        subtitle: TextWidget(text: comentario.texto),
                        trailing: Get.find<AppController>().usuario.pessoa.id ==
                                comentario.pessoa.id
                            ? IconButton(
                                icon: Icon(Icons.delete),
                                onPressed: () => controller.excluirComentario(
                                    comentario.id, videoId))
                            : Text(""),
                      );
                    }),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: renderAdicionarComentario(),
            ),
          ],
        ),
      ),
    );
  }

  Widget semComentario() {
    return Container(
      height: Get.height * .55,
      child: Center(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            height: 40,
          ),
          TextWidget(
            text: 'Nenhum comentário encontrado, que tal você ser o primeiro?',
          ),
          renderAdicionarComentario()
        ],
      )),
    );
  }

  scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      scrollController.jumpTo(scrollController.position.maxScrollExtent);
    });
  }

  Widget renderAdicionarComentario() {
    return Container(
      height: 50,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
              child: TextFormField(
                onChanged: (v) => controller.comentario.texto = v,
                decoration: InputDecoration(hintText: 'Escreva seu comentário'),
              ),
            ),
            IconButton(
                icon: Icon(Icons.send),
                onPressed: () {
                  controller.inserirComentario(videoId);
                  Get.back();
                })
          ],
        ),
      ),
    );
  }
}
