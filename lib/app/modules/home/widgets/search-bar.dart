import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socialfood/app/modules/home/controllers/home-controller.dart';

import '../../../app_controller.dart';

Widget searchBar() {
  var controller = Get.find<HomeController>();
  return Container(
    width: Get.width * .75,
    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
    decoration: BoxDecoration(
        color: Get.isDarkMode
            ? Colors.grey[900]
            : Colors.redAccent.withOpacity(.8),
        borderRadius: BorderRadius.circular(22)),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: Get.find<AppController>().usuario.grupo != 'administrador'
              ? Get.width * .7 - 25
              : Get.width * .7 - 73,
          padding: EdgeInsets.symmetric(horizontal: 5),
          child: TextFormField(
            controller: controller.texteditingController,
            onFieldSubmitted: (s) {
              controller.page = 0;
              controller.listarVideo();
              controller.searchBar = false;
            },
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Pesquisar',
                hintStyle: TextStyle(color: Colors.white),
                icon: Icon(Icons.search, color: Colors.white)),
          ),
        ),
      ],
    ),
  );
}