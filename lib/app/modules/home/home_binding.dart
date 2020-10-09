import 'package:get/get.dart';
import 'package:socialfood/app/modules/home/controllers/home-controller.dart';

class HomeBinding extends Bindings{
  @override
  void dependencies() {
   Get.put<HomeController>(HomeController());
  }

}