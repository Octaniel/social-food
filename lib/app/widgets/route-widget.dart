import 'package:get/get.dart';

goTo(route) =>
    Future.delayed(const Duration(milliseconds: 0), () => Get.toNamed(route));

goToWithParameters(route, parameters) => Future.delayed(
    const Duration(milliseconds: 0),
    () => Get.toNamed(route, arguments: parameters));

goToAll(route) => Future.delayed(
    const Duration(milliseconds: 0), () => Get.offAllNamed(route));
