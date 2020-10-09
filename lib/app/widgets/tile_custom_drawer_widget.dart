import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../app_controller.dart';

class TileCustomDrawerWidget extends GetWidget<AppController> {
  final String nomeTela;
  final String caminho;
  final IconData icondata;

  TileCustomDrawerWidget(this.nomeTela, this.icondata, this.caminho);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        controller.caminho = caminho;
        Get.offAllNamed(caminho);
      },
      child: Container(
        height: 50,
        child: GetBuilder<AppController>(
          builder: (_) {
            return Row(
              children: [
                SizedBox(width: 20),
                Icon(
                  icondata,
                  color: !Get.isDarkMode? controller.caminho != caminho
                      ? Color(0xFF666666)
                      : Colors.red:controller.caminho != caminho
                      ? Colors.black54
                      : Colors.black87,
                ),
                SizedBox(width: 20),
                Visibility(
                  visible: controller.caminho != caminho,
                  replacement: Text(
                    nomeTela,
                    style: TextStyle(
                      color: !Get.isDarkMode?Colors.redAccent:Colors.black87,
                      fontSize: 18,
                      fontWeight: FontWeight.w700
                    ),
                  ),
                  child: Text(
                    nomeTela,
                    style: TextStyle(
                      color: !Get.isDarkMode?Color(0xFF666666):Colors.black87,
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
