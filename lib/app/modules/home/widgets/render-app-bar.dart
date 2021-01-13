import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:socialfood/app/modules/home/controllers/home-controller.dart';
import 'package:socialfood/app/modules/home/widgets/search-bar.dart';
import 'package:socialfood/app/routes/app_routes.dart';
import 'package:socialfood/app/widgets/text-widget.dart';

import '../../../app_controller.dart';

AppBar renderAppBar(bool isDash) {
  var find = Get.find<AppController>();
  return AppBar(
    elevation: 0,
    leading: GestureDetector(
      onTap: () => Get.toNamed(Routes.PERFIL),
      child: Container(
        margin: EdgeInsets.all(5),
        child: CircleAvatar(
          backgroundImage: NetworkImage(find.usuario.pessoa.fotoUrl),
        ),
      ),
    ),
    title: GetBuilder<HomeController>(
      builder: (controller) {
        return !controller.searchBar
            ? TextWidget(
                text: 'FeedFood(BETA)',
              )
            : searchBar();
      },
    ),
    actions: [
      if (!isDash)
        GetBuilder<HomeController>(
          builder: (controller) {
            return !controller.searchBar
                ? IconButton(
                    tooltip: "Pesquisar",
                    icon: Icon(Icons.search),
                    onPressed: () => controller.searchBar = true)
                : Text('');
          },
        )
      else
        Tooltip(
          message: "Lista de Videos",
          child: IconButton(
              icon: Icon(FontAwesomeIcons.film),
              onPressed: () => Get.toNamed(Routes.FEED)),
        ),
      if (!isDash)
        IconButton(
            tooltip: "Dashboard",
            icon: Icon(FontAwesomeIcons.chartLine),
            onPressed: () {
              Get.toNamed(Routes.HOME);
            }),
      find.usuario.grupo == 'administrador'
          ? IconButton(
              tooltip: "Adicionar video",
              icon: Icon(Icons.video_call),
              onPressed: () {
                GetPlatform.isWeb || GetPlatform.isDesktop
                    ? Get.toNamed(Routes.ADDVIDEOWEB)
                    : Get.toNamed(Routes.INSERIRVIDEO);
              })
          : Text(''),
    ],
  );
}
