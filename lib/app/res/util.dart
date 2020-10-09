import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socialfood/app/theme/theme-controller.dart';

bool get isDarkMode => ThemeController.to.modoDark.value;

exibirSnackErro(String erro) {
  Get.snackbar('Oops!', erro,
      isDismissible: true,
      icon: Icon(
        Icons.error,
        color: Colors.white,
      ),
      snackPosition: SnackPosition.BOTTOM,
      borderRadius: 5,
      margin: EdgeInsets.all(15),
      snackStyle: SnackStyle.FLOATING,
      backgroundColor: Colors.black,
      duration: Duration(seconds: 10),
      colorText: Colors.white,
      animationDuration: Duration(seconds: 0));
}

exibirSnackSucesso(String mensagem) {
  Get.snackbar('Sucesso!', mensagem,
      isDismissible: true,
      icon: Icon(
        Icons.check,
        color: Colors.white,
      ),
      snackPosition: SnackPosition.BOTTOM,
      borderRadius: 5,
      margin: EdgeInsets.all(15),
      snackStyle: SnackStyle.FLOATING,
      backgroundColor: Colors.black,
      duration: Duration(seconds: 10),
      colorText: Colors.white,
      animationDuration: Duration(seconds: 0));
}
