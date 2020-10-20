import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'package:socialfood/app/routes/app_routes.dart';
import 'package:socialfood/app/widgets/tile_custom_drawer_widget.dart';

import '../app_controller.dart';

class CustomDrawer extends GetWidget<AppController> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            height: MediaQuery.of(context).size.height / 3,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: Get.isDarkMode ? Colors.black12 : Colors.red,
                borderRadius:
                    BorderRadius.only(bottomRight: Radius.circular(150)),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black54, blurRadius: 20, spreadRadius: 13),
                ]),
            child: GetBuilder(builder: (_) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Spacer(flex: 300),
                  GestureDetector(
                    child: Container(
                      child: CircleAvatar(
                        radius: 70,
                        // child: Icon(Icons.person),
                        backgroundImage: NetworkImage(controller.usuario.pessoa.fotoUrl),
                      ),
                      alignment: Alignment.centerLeft,
                      width: 100,
                    ),
                    onTap: () {
                      controller.caminho = "/perfil";
                      Get.offNamed(Routes.PERFIL);
                    },
                  ),
                  Text(
                    controller.usuario.pessoa.nome,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.w600),
                  ),
                  Text(
                    controller.usuario.pessoa.email,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 19,
                    ),
                  ),
                  SizedBox(height: 30),
                ],
              );
            }),
          ),
          Container(
            height: MediaQuery.of(context).size.height / 1.5,
            child: Column(
              children: [
                SizedBox(height: 10),
                TileCustomDrawerWidget('Home', Icons.home, Routes.HOME),
                Divider(),
                TileCustomDrawerWidget(
                    'Favoritos', Ionicons.ios_heart_empty, Routes.FAVORITO),
                Divider(),
                TileCustomDrawerWidget(
                    'Configuração', Icons.settings, Routes.CONFIGURACAO),
                Divider(),
                Spacer(flex: 300),
                InkWell(
                  onTap: () async {
                    if (await controller.logout()) {
                      Get.offAllNamed(Routes.LOGIN);
                    }
                  },
                  child: Container(
                    height: 41,
                    color: Get.isDarkMode
                        ? Colors.black87.withOpacity(.5)
                        : Colors.red,
                    child: Row(
                      children: [
                        SizedBox(width: 20),
                        Icon(
                          Icons.exit_to_app,
                          color: Colors.white,
                        ),
                        SizedBox(width: 20),
                        Text(
                          'Sair',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
