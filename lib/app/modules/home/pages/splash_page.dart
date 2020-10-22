import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socialfood/app/data/provider/auth_provider.dart';
import 'package:socialfood/app/routes/app_routes.dart';
import 'package:socialfood/app/widgets/loader-widget.dart';
import 'package:socialfood/app/widgets/text-widget.dart';

import '../../../app_controller.dart';


class SplashPage extends StatelessWidget {

  // ignore: missing_return
  Future verificarToken(){
    Future.delayed(Duration(seconds: 2),() async {
      if (await AuthProvider().verificarERenovarToken()){
      await Get.find<AppController>().refreshUsuario();
      GetPlatform.isWeb?Get.offAllNamed(Routes.ADDVIDEOWEB):Get.offAllNamed(Routes.HOME);
      }else{
      Get.offNamed(Routes.LOGIN);
      }
    });

  }

  @override
  Widget build(BuildContext context) {
    verificarToken();
    return Scaffold(
            body: Container(
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('images/capa_Feed Food.png',
                      fit: BoxFit.contain,),
                    TextWidget(
                      fontWeight: FontWeight.bold,
                      color: Get.isDarkMode? Colors.white:Colors.black87,
                      text: 'FeedfooD',
                      fontSize: 30,
                    ),
                    LoaderWidget()
                  ],
                ),
              ),
            ),
          );
  }
}
