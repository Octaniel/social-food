import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socialfood/app/modules/home/controllers/home-controller.dart';

class BottomNavWidget extends GetWidget<HomeController> {
  final HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (_){
      return Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        height: 50,
        width: Get.width,
        decoration: BoxDecoration(
          color: controller.color,
          borderRadius: BorderRadius.circular(11),
        ),
        child: Center(
          child: Text(
            'Anucio',
            style: TextStyle(
              fontFamily: 'Segoe UI',
              fontSize: 20,
              color: const Color(0xffffffff),
            ),
          ),
        ),
      );
    });
  }
}
