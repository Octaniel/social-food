import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:socialfood/app/data/model/usuario.dart';
import 'package:socialfood/app/modules/home/controllers/home-controller.dart';
import 'package:socialfood/app/modules/home/widgets/render-app-bar.dart';
import 'package:socialfood/app/routes/app_routes.dart';
import 'package:socialfood/app/widgets/loader-widget.dart';
import 'package:socialfood/app/widgets/text-widget.dart';

class UsersPage extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    controller.listarUsuario();
    return GetBuilder<HomeController>(
      builder: (_) {
        return Scaffold(
          appBar: renderAppBar(true, isUsers: true),
          body: Visibility(
              visible: !controller.carregando,
              replacement: LoaderWidget(),
              child: controller.usuarios.isEmpty
                  ? Center(
                      child: TextWidget(
                        text: controller.texteditingController.text.isEmpty
                            ? 'Nenhum usuario cadastrado no momento'
                            : 'Nenhum usuario relacionado com a sua pesquisa no momento',
                      ),
                    )
                  : SmartRefresher(
                      enablePullDown: true,
                      enablePullUp: true,
                      onRefresh: () {
                        controller.listarUsuario(refresh: false);
                      },
                      onLoading: () {
                        controller.listarUsuario(refresh: true);
                      },
                      controller: controller.refreshControllerUsers,
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
                      child: GridView.builder(
                        // controller: controller.scrollController,
                        itemCount: controller.usuarios.length,
                        itemBuilder: (context, index) {
                          Usuario usuario = controller.usuarios[index];

                          return Container(
                            margin: EdgeInsets.only(top: 10),
                            child: Column(
                              children: [
                                Container(
                                  margin: EdgeInsets.symmetric(horizontal: 10),
                                  width: Get.width,
                                  height: 200,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.grey[200],
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10),
                                      ),
                                    ),
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Container(
                                          // margin: EdgeInsets.all(5),
                                          child: CircleAvatar(
                                            radius: 40,
                                            backgroundImage: NetworkImage(
                                                usuario.pessoa.fotoUrl),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          "${usuario.pessoa.nome}",
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          "${usuario.pessoa.email}",
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            IconButton(
                                                tooltip: "Editar",
                                                icon: Icon(
                                                  FontAwesomeIcons.pen,
                                                  color: Colors.blueGrey,
                                                ),
                                                onPressed: () {
                                                  controller.usuario = usuario;
                                                  Get.toNamed(
                                                      Routes.USERUPDATE);
                                                }),
                                            IconButton(
                                                tooltip: "Remover",
                                                icon: Icon(
                                                  FontAwesomeIcons.trash,
                                                  color: Colors.red,
                                                ),
                                                onPressed: () async {
                                                  Get.defaultDialog(
                                                      title: "Apagar video",
                                                      middleText:
                                                          "Tens certesa que queres excluir permanentemente este usuario?",
                                                      onConfirm: () async {
                                                        var remover =
                                                            await controller
                                                                .removerUsuario(
                                                                    usuario.id);
                                                        if (remover) {
                                                          Get.rawSnackbar(
                                                              icon: Icon(
                                                                  FontAwesomeIcons
                                                                      .check),
                                                              duration:
                                                                  Duration(
                                                                      seconds:
                                                                          2),
                                                              backgroundColor:
                                                                  Color(
                                                                      0xFF3CFEB5),
                                                              messageText: Text(
                                                                'Usuario removido com sucesso.',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        15,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                              borderRadius: 10,
                                                              margin: EdgeInsets
                                                                  .only(
                                                                      left: 20,
                                                                      right: 20,
                                                                      bottom:
                                                                          20));
                                                        } else {
                                                          Get.rawSnackbar(
                                                              icon: Icon(
                                                                FontAwesomeIcons
                                                                    .times,
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                              duration:
                                                                  Duration(
                                                                      seconds:
                                                                          2),
                                                              backgroundColor:
                                                                  Color(
                                                                      0xFFFE3C3C),
                                                              messageText: Text(
                                                                'Houve erro ao remover o usuario',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        15,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                              borderRadius: 10,
                                                              margin: EdgeInsets
                                                                  .only(
                                                                      left: 20,
                                                                      right: 20,
                                                                      bottom:
                                                                          20));
                                                        }
                                                        controller
                                                            .listarUsuario(
                                                                refresh: false);
                                                        Future.delayed(
                                                            Duration(
                                                                seconds: 2),
                                                            () {
                                                          Navigator.pop(
                                                              Get.context);
                                                        });
                                                      });
                                                }),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          );
                        },
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4),
                      ),
                    )),
        );
      },
    );
  }
}
